import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.VirtualKeyboard
import QtQuick.VirtualKeyboard.Settings
import SddmComponents

Item {
    id: loginFrame

    property int sessionIndex: sessionModel ? sessionModel.lastIndex : 0
    property string userIndex: userList.currentIndex
    property string userName: userModel ? userModel.lastUser : ""
    property string userIcon: userList.currentItem.iconPath
    property alias input: passwdInput
    property alias button: loginButton
    property bool showKeyboard: false
    property bool returnKeyboard: false
    property string activeMenu: ""
    property bool isAuthorizing: false

    property var activePopup: null

    // Break binding so it doesn't update when `keyboard.capsLock` changes.
    property bool capsLockOn: {
        capsLockOn = keyboard ? keyboard.capsLock : false;
    }

    signal needClose

    onActiveMenuChanged: {
        if (returnKeyboard) {
            showKeyboard = true;
            returnKeyboard = false;
        }
        passwdInput.input.forceActiveFocus();
    }

    Connections {
        function onLoginSucceeded() {
            spinner.visible = false;
        }

        function onLoginFailed() {
            isAuthorizing = false;
            spinner.visible = false;
            loginMessage.warn(textConstants.loginFailed, "error");
            passwdInput.text = "";
            passwdInput.focus = true;
            loginArea.visible = true;
            if (returnKeyboard) {
                showKeyboard = true;
                returnKeyboard = false;
            }
        }

        target: sddm
    }

    Item {
        id: loginItem

        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        Component.onCompleted: {
            VirtualKeyboardSettings.locale = keyboard.layouts[keyboard.currentLayout] ? Languages.getKBCodeFor(keyboard.layouts[keyboard.currentLayout].shortName) : "en_US";
        }
        focus: activeMenu !== ""
        Keys.onEscapePressed: () => {
            if (loginFrame.activeMenu !== "") {
                loginFrame.activeMenu = "";
                passwdInput.input.forceActiveFocus();
                return;
            }
            if (isAuthorizing)
                return;

            if (config.showLockScreen !== "false")
                needClose();

            passwdInput.text = "";
        }
        Keys.onPressed: event => {
            // TODO: Move this to the Main
            if (event.key == Qt.Key_CapsLock && !isAuthorizing) {
                capsLockOn = !capsLockOn;
                if (capsLockOn)
                    loginMessage.warn(textConstants.capslockWarning, "warning");
                else
                    loginMessage.clear();
            }
        }

        User {
            id: userListContainer

            width: parent.width
            height: config.selectedAvatarSize || 120
            listUsers: loginFrame.activeMenu === "user"
            enabled: loginFrame.activeMenu === "user" || loginFrame.activeMenu === ""
            onClick: {
                loginFrame.activeMenu = "user";
                if (showKeyboard) {
                    showKeyboard = false;
                    returnKeyboard = true;
                }
            }
            onUserChanged: index => {
                userIndex = index;
            }
            onCloseUserList: {
                loginFrame.activeMenu = "";
            }

            anchors {
                top: parent.top
                topMargin: parent.height / 3
                horizontalCenter: parent.horizontalCenter
            }
        }

        Text {
            id: userNameText

            text: userName
            font.bold: true
            font.family: config.font || "RedHatDisplay"
            color: config.userNameColor || "#FFFFFF"
            font.pointSize: config.userNameFontSize || 15

            anchors {
                top: userListContainer.bottom
                topMargin: 10
                horizontalCenter: parent.horizontalCenter
            }
        }

        Spinner {
            id: spinner

            anchors.top: userNameText.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 10
            visible: false
        }

        Item {
            id: loginArea

            width: childrenRect.width
            anchors.top: userNameText.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 20

            PasswordInput {
                id: passwdInput
                enabled: loginFrame.activePopup === null
                onAccepted: {
                    if (passwdInput.text.length > 0) {
                        spinner.visible = true;
                        loginArea.visible = false;
                        isAuthorizing = true;
                        if (showKeyboard) {
                            showKeyboard = false;
                            returnKeyboard = true;
                        }
                        sddm.login(userName, passwdInput.text, sessionIndex);
                    }
                }
            }

            IconButton {
                id: loginButton

                height: passwdInput.height
                width: height
                enabled: activePopup === null
                anchors.left: (passwdInput.right)
                anchors.leftMargin: config.loginButtonMarginLeft || 5
                icon: "icons/arrow-right.svg"
                tooltip_text: textConstants.login
                iconSize: config.loginButtonIconSize || 24
                iconColor: config.loginButtonIconColor || "#FFFFFF"
                hoverIconColor: config.loginButtonHoverIconColor || "#FFFFFF"
                backgroundColor: config.loginButtonBackgroundColor || "#FFFFFF"
                backgroundOpacity: config.loginButtonBackgroundOpacity || 0.15
                hoverBackgroundColor: config.loginButtonHoverBackgroundColor || "#FFFFFF"
                hoverBackgroundOpacity: config.loginButtonHoverBackgroundOpacity || 0.3
                onClicked: {
                    if (passwdInput.text.length > 0) {
                        spinner.visible = true;
                        loginArea.visible = false;
                        isAuthorizing = true;
                        if (showKeyboard) {
                            showKeyboard = false;
                            returnKeyboard = true;
                        }
                        sddm.login(userName, passwdInput.text, sessionIndex);
                    }
                }
            }
        }

        // FIX: Virtual keyboard not working on the second screen.
        InputPanel {
            // TODO: Keep keyboard visible.
            id: inputPanel
            z: 99
            width: Math.min(parent.width / 2, loginArea.width * 3)
            visible: showKeyboard
            externalLanguageSwitchEnabled: true
            onExternalLanguageSwitch: {
                activeMenu = activeMenu === "" ? "language" : "";
            }
            onActiveChanged: {
                if (showKeyboard)
                    showKeyboard = false;
            }
            Component.onCompleted: {
                VirtualKeyboardSettings.styleName = "tstyle";
                VirtualKeyboardSettings.layout = "symbols";
            }

            anchors {
                top: loginArea.bottom
                horizontalCenter: parent.horizontalCenter
                topMargin: loginMessage.text === "" ? 50 : 80
            }
        }

        Text {
            id: loginMessage
            font.pointSize: config.warningMessageSize || 9
            font.family: config.font || "RedHatDisplay"
            color: config.warningMessageColor || "#FFFFFF"
            visible: false
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: loginArea.bottom
                topMargin: 50
            }
            Component.onCompleted: {
                if (loginFrame.capsLockOn)
                    loginMessage.warn("CapsLock on", "warning");
            }

            function warn(message, type) {
                text = message;
                visible = true;
            }

            function clear() {
                visible = false;
                text = "";
            }
        }

        Item {
            id: menuArea
            anchors.fill: parent

            function calculatePopupPos(dir, popup_w, popup_h, parent_w, parent_h, parent_x) {
                let x = 0, y = 0;
                const popup_margin = 5;
                if (dir === "up") {
                    if (parent_x + (parent_w - popup_w) / 2 < 10) {
                        // Align popup left
                        x = 0;
                    } else if (parent_x - (parent_w - popup_w) / 2 > loginFrame.width - 10) {
                        // Align popup right
                        x = -popup_w + parent_w;
                    } else {
                        // Center popup
                        x = (parent_w - popup_w) / 2;
                    }
                    y = -popup_h - popup_margin;
                } else if (dir === "down") {
                    if (parent_x + (parent_w - popup_w) / 2 < 10) {
                        // Align popup left
                        x = 0;
                    } else if (parent_x - (parent_w - popup_w) / 2 > loginFrame.width - 10) {
                        // Align popup right
                        x = -popup_w + parent_w;
                    } else {
                        // Center popup
                        x = (parent_w - popup_w) / 2;
                    }
                    y = parent.height + popup_margin;
                } else if (dir === "left") {
                    x = -popup_w - popup_margin;
                    y = 0;
                } else {
                    x = parent_w + popup_margin;
                    y = 0;
                }
                return [x, y];
            }

            Component {
                id: sessionMenuComponent

                IconButton {
                    id: sessionButton
                    property bool showLabel: true
                    width: showLabel ? 200 : childrenRect.width
                    height: 30
                    iconSize: 15
                    pressed: popup.visible
                    onClicked: {
                        popup.open();
                        activePopup = popup;
                    }
                    tooltip_text: "Change session"

                    Popup {
                        id: popup
                        property int popupMargin: 5
                        parent: sessionButton
                        background: Rectangle {
                            color: "transparent"
                        }
                        dim: true

                        focus: true
                        modal: true
                        popupType: Popup.Item
                        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

                        StackLayout {
                            Session {
                                onSessionChanged: (newSessionIndex, sessionIcon, sessionLabel) => {
                                    sessionIndex = newSessionIndex;
                                    sessionButton.icon = sessionIcon;
                                    sessionButton.label = sessionButton.showLabel ? sessionLabel : "";
                                }
                            }
                        }

                        Component.onCompleted: {
                            [x, y] = menuArea.calculatePopupPos("up", width, height, parent.width, parent.height, parent.parent.x);
                        }
                        onClosed: {
                            loginFrame.activePopup = null;
                        }
                    }
                }
            }

            Component {
                id: languageMenuComponent

                IconButton {
                    id: languageButton

                    height: 30
                    icon: "icons/language.svg"
                    iconSize: 15
                    pressed: popup.visible
                    onClicked: {
                        popup.open();
                        activePopup = popup;
                    }
                    tooltip_text: "Change keyboard layout"
                    label: keyboard.layouts[keyboard.currentLayout] ? keyboard.layouts[keyboard.currentLayout].shortName.toUpperCase() : ""

                    Popup {
                        id: popup
                        property int popupMargin: 5
                        parent: languageButton
                        background: Rectangle {
                            color: "transparent"
                        }
                        dim: true

                        focus: true
                        modal: true
                        popupType: Popup.Item
                        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
                        StackLayout {
                            Language {
                                onLanguageChanged: index => {
                                    languageButton.label = keyboard.layouts[keyboard.currentLayout].shortName.toUpperCase();
                                    VirtualKeyboardSettings.locale = Languages.getKBCodeFor(keyboard.layouts[keyboard.currentLayout].shortName);
                                }
                            }
                        }
                        Component.onCompleted: {
                            [x, y] = menuArea.calculatePopupPos("up", width, height, parent.width, parent.height, parent.parent.x);
                        }
                        onClosed: {
                            loginFrame.activePopup = null;
                        }
                    }
                }
            }

            Component {
                id: keyboardMenuComponent

                IconButton {
                    id: keyboardButton

                    height: 30
                    width: 30
                    icon: "icons/keyboard.svg"
                    iconSize: 15
                    pressed: showKeyboard
                    onClicked: {
                        showKeyboard = !showKeyboard;
                    }
                    tooltip_text: "Toggle virtual keyboard"
                }
            }

            Component {
                id: powerMenuComponent

                IconButton {
                    id: powerButton

                    height: 30
                    width: 30
                    icon: "icons/power.svg"
                    iconSize: 15
                    pressed: popup.visible
                    onClicked: {
                        popup.open();
                        activePopup = popup;
                    }
                    tooltip_text: "Power options"

                    Popup {
                        id: popup
                        property int popupMargin: 5
                        parent: powerButton
                        background: Rectangle {
                            color: "transparent"
                        }
                        dim: true

                        focus: true
                        modal: true
                        popupType: Popup.Item
                        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

                        StackLayout {
                            Power {
                                visible: true
                            }
                        }

                        Component.onCompleted: {
                            [x, y] = menuArea.calculatePopupPos("up", width, height, parent.width, parent.height, parent.parent.x);
                        }
                        onClosed: {
                            loginFrame.activePopup = null;
                        }
                    }
                }
            }

            Row {
                // top_left
                id: topLeftButtons

                height: 30
                spacing: 10

                anchors {
                    top: parent.top
                    left: parent.left
                    topMargin: 50
                    leftMargin: 50
                }
            }

            Row {
                // top_center
                id: topCenterButtons

                height: 30
                spacing: 10

                anchors {
                    top: parent.top
                    horizontalCenter: parent.horizontalCenter
                    topMargin: 50
                }
            }

            Row {
                // top_right
                id: topRightButtons

                height: 30
                spacing: 10

                anchors {
                    top: parent.top
                    right: parent.right
                    topMargin: 50
                    rightMargin: 50
                }
            }

            Column {
                // center_left
                id: centerLeftButtons

                width: 30
                spacing: 10

                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                    leftMargin: 50
                }
            }

            Column {
                // center_right
                id: centerRightButtons

                width: 30
                spacing: 10

                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                    rightMargin: 50
                }
            }

            Row {
                // bottom_left
                id: bottomLeftButtons

                height: 30
                spacing: 10

                anchors {
                    bottom: parent.bottom
                    left: parent.left
                    bottomMargin: 50
                    leftMargin: 50
                }
            }

            Row {
                // bottom_center
                id: bottomCenterButtons

                height: 30
                spacing: 10

                anchors {
                    bottom: parent.bottom
                    horizontalCenter: parent.horizontalCenter
                    bottomMargin: 50
                }
            }

            Row {
                // bottom_right
                id: bottomRightButtons

                height: childrenRect.height
                spacing: 10

                anchors {
                    bottom: parent.bottom
                    right: parent.right
                    bottomMargin: 50
                    rightMargin: 50
                }
            }

            Component.onCompleted: {
                const menus = Config.sortMenuButtons();

                for (let i = 0; i < menus.length; i++) {
                    let pos;
                    switch (menus[i].position) {
                    case "top_left":
                        pos = topLeftButtons;
                        break;
                    case "top_center":
                        pos = topCenterButtons;
                        break;
                    case "top_right":
                        pos = topRightButtons;
                        break;
                    case "center_left":
                        pos = centerLeftButtons;
                        break;
                    case "center_right":
                        pos = centerRightButtons;
                        break;
                    case "bottom_left":
                        pos = bottomLeftButtons;
                        break;
                    case "bottom_center":
                        pos = bottomCenterButtons;
                        break;
                    case "bottom_right":
                        pos = bottomRightButtons;
                        break;
                    }

                    if (menus[i].name === "session")
                        sessionMenuComponent.createObject(pos, {});
                    else if (menus[i].name === "language")
                        languageMenuComponent.createObject(pos, {});
                    else if (menus[i].name === "keyboard")
                        keyboardMenuComponent.createObject(pos, {});
                    else if (menus[i].name === "power")
                        powerMenuComponent.createObject(pos, {});
                }
            }
        }

        MouseArea {
            anchors.fill: parent
            enabled: loginFrame.activePopup !== null || isAuthorizing
            visible: loginFrame.activePopup !== null || isAuthorizing
            hoverEnabled: true
            onClicked: {
                if (isAuthorizing)
                    return;

                // Prevent weird inconsistence with multiple monitors where the loginButton is still reachable when a popup is open.
                loginFrame.activePopup.close();
                loginFrame.activePopup = null;
            }
        }
    }
}
