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
    property alias loginArea: loginSection
    property bool showKeyboard: !Config.virtualKeyboardStartHidden
    property string activeMenu: ""
    property bool isAuthorizing: false
    property bool needsPassword: true

    property var activePopup: null
    onActivePopupChanged: {
        if (needsPassword) {
            passwdInput.input.forceActiveFocus();
        } else {
            loginButton.forceActiveFocus();
        }
    }

    // Break property binding so it doesn't update when `keyboard.capsLock` changes.
    property bool capsLockOn: {
        capsLockOn = keyboard ? keyboard.capsLock : false;
    }

    signal needClose

    function login() {
        if (passwdInput.text.length > 0 || !loginFrame.needsPassword) {
            spinner.visible = true;
            loginArea.visible = false;
            isAuthorizing = true;
            sddm.login(userName, passwdInput.text, sessionIndex);
        }
    }

    Connections {
        function onLoginSucceeded() {
            spinner.visible = false;
            loginSection.scale = 0.0;
        }

        function onLoginFailed() {
            isAuthorizing = false;
            spinner.visible = false;
            loginMessage.warn(textConstants.loginFailed, "error");
            passwdInput.text = "";
            passwdInput.input.forceActiveFocus();
            loginArea.visible = true;
        }

        function onInformationMessage(message) {
            loginMessage.warn(message, "error");
        }

        target: sddm
    }

    Item {
        id: loginItem

        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        Component.onCompleted: {
            // It probably defaults to the system language or something if empty/wrong
            VirtualKeyboardSettings.locale = keyboard.layouts[keyboard.currentLayout] ? Languages.getKBCodeFor(keyboard.layouts[keyboard.currentLayout].shortName) : "";
        }

        Item {
            id: loginSection
            z: 2
            width: parent.width
            height: childrenRect.height
            scale: 0.5
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }

            Behavior on scale {
                enabled: Config.enableAnimations
                NumberAnimation {
                    duration: 200
                }
            }

            focus: loginFrame.activePopup !== null
            Keys.onEscapePressed: () => {
                if (loginFrame.activePopup !== null) {
                    loginFrame.activePopup.close();
                    loginFrame.activePopup = null;
                    passwdInput.input.forceActiveFocus();
                    return;
                }
                if (loginFrame.isAuthorizing)
                    return;

                if (config.showLockScreen !== "false")
                    loginFrame.needClose();

                passwdInput.text = "";
            }
            Keys.onPressed: event => {
                // TODO: Move this to the Main
                if (event.key == Qt.Key_CapsLock && !loginFrame.isAuthorizing) {
                    loginFrame.capsLockOn = !loginFrame.capsLockOn;
                    if (loginFrame.capsLockOn)
                        loginMessage.warn(textConstants.capslockWarning, "warning");
                    else
                        loginMessage.clear();
                }
            }

            User {
                id: userListContainer
                width: parent.width
                height: config.selectedAvatarSize || 120
                listUsers: loginFrame.activePopup == userListContainer
                enabled: !loginFrame.isAuthorizing
                activeFocusOnTab: true
                focus: false
                onClick: {
                    loginFrame.activePopup = userListContainer;
                }
                onUserChanged: (index, needsPasswd) => {
                    userIndex = index;
                    loginFrame.needsPassword = needsPasswd;
                }
                onCloseUserList: {
                    loginFrame.activePopup = null;
                }

                anchors {
                    top: parent.top
                    // topMargin: parent.height / 3
                    topMargin: 0
                    horizontalCenter: parent.horizontalCenter
                }

                function close() {
                    return;
                }
            }

            Text {
                id: userNameText

                text: userName
                font.bold: true
                font.family: Config.fontFamily
                color: Config.usernameColor
                font.pixelSize: Config.usernameFontSize

                anchors {
                    top: userListContainer.bottom
                    topMargin: Config.usernameMarginTop // 10
                    horizontalCenter: parent.horizontalCenter
                }
            }

            Spinner {
                id: spinner

                anchors.top: userNameText.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: Config.spinnerMarginTop // 10
                visible: false
            }

            Row {
                id: loginArea
                anchors.top: userNameText.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.topMargin: Config.passwordInputMarginTop // 20
                spacing: Config.loginButtonMarginLeft

                PasswordInput {
                    id: passwdInput
                    enabled: loginFrame.activePopup === null
                    visible: loginFrame.needsPassword
                    onAccepted: {
                        loginFrame.login();
                    }
                }

                IconButton {
                    id: loginButton

                    height: passwdInput.height
                    enabled: activePopup === null
                    activeFocusOnTab: true
                    focus: loginFrame.needsPassword ? false : (loginFrame.activePopup !== null ? false : true)
                    icon: "icons/arrow-right.svg"
                    label: loginFrame.needsPassword ? "" : (Config.loginButtonShowTextIfNoPassword ? textConstants.login.toUpperCase() : "")
                    tooltip_text: loginFrame.needsPassword ? textConstants.login : (Config.loginButtonShowTextIfNoPassword ? "" : textConstants.login)
                    boldLabel: true
                    iconSize: Config.loginButtonIconSize
                    fontSize: Config.loginButtonFontSize
                    iconColor: Config.loginButtonContentColor
                    hoverIconColor: Config.loginButtonActiveContentColor
                    backgroundColor: Config.loginButtonBackgroundColor
                    backgroundOpacity: Config.loginButtonBackgroundOpacity
                    hoverBackgroundColor: Config.loginButtonActiveBackgroundColor
                    hoverBackgroundOpacity: Config.loginButtonActiveBackgroundOpacity
                    onClicked: {
                        loginFrame.login();
                    }
                }
            }

            Text {
                id: loginMessage
                font.pixelSize: Config.warningMessageFontSize
                font.family: Config.fontFamily
                font.bold: Config.warningMessageBold
                color: Config.warningMessageNormalColor
                visible: false
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: loginArea.bottom
                    topMargin: Config.warningMessageMarginTop // 50
                }
                Component.onCompleted: {
                    if (loginFrame.capsLockOn)
                        loginMessage.warn("CapsLock on", "warning");
                }

                function warn(message, type) {
                    text = message;
                    color = type === "error" ? Config.warningMessageErrorColor : (type === "warning" ? Config.warningMessageWarningColor : Config.warningMessageNormalColor);
                    visible = true;
                }

                function clear() {
                    visible = false;
                    text = "";
                }
            }
        }

        MouseArea {
            z: 1
            anchors.fill: parent
            enabled: loginFrame.activePopup !== null || loginFrame.isAuthorizing
            visible: loginFrame.activePopup !== null || loginFrame.isAuthorizing
            hoverEnabled: true
            onClicked: {
                if (loginFrame.isAuthorizing)
                    return;

                // Prevent weird inconsistence with multiple monitors where the loginButton is still reachable when a popup is open.
                loginFrame.activePopup.close();
                loginFrame.activePopup = null;
            }
        }

        // FIX: Virtual keyboard not working on the second screen.
        InputPanel {
            // TODO: Keep keyboard visible.
            id: inputPanel
            z: 99
            width: Math.min(parent.width / 2, loginArea.width * 3) * Config.virtualKeyboardScale
            visible: showKeyboard
            externalLanguageSwitchEnabled: true
            onExternalLanguageSwitch: {
                return;
            }
            // TODO: Open lang popup
            // onActiveChanged: {
            //     if (showKeyboard)
            //         showKeyboard = false;
            // }
            Component.onCompleted: {
                VirtualKeyboardSettings.styleName = "tstyle";
                VirtualKeyboardSettings.layout = "symbols";
            }

            property string pos: Config.virtualKeyboardPosition
            anchors {
                top: pos === "top" ? parent.top : (pos === "bottom" ? loginSection.bottom : undefined)
                topMargin: pos === "top" ? Config.menuAreaMarginTop : (pos === "bottom" ? (!loginMessage.visible ? loginMessage.anchors.topMargin : loginMessage.anchors.topMargin + 10) : undefined)
                left: pos === "left" ? parent.left : undefined
                leftMargin: pos === "left" ? Config.menuAreaMarginLeft : undefined
                right: pos === "right" ? parent.right : undefined
                rightMargin: pos === "right" ? Config.menuAreaMarginRight : undefined
                horizontalCenter: pos === "top" || pos === "bottom" ? parent.horizontalCenter : undefined
                verticalCenter: pos === "left" || pos === "right" ? parent.verticalCenter : undefined
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
                    property bool showLabel: Config.sessionButtonDisplaySessionName
                    width: showLabel ? Config.sessionButonMaxWidth : Config.menuAreaButtonsSize
                    height: Config.menuAreaButtonsSize
                    iconSize: Config.sessionButtonIconSize
                    fontSize: Config.sessionButtonFontSize
                    pressed: popup.visible
                    iconColor: Config.sessionButtonContentColor
                    hoverIconColor: Config.sessionButtonActiveContentColor
                    borderRadius: Config.menuAreaButtonsBorderRadius
                    backgroundColor: Config.sessionButtonBackgroundColor
                    backgroundOpacity: Config.sessionButtonBackgroundOpacity
                    hoverBackgroundColor: Config.sessionButtonBackgroundColor
                    hoverBackgroundOpacity: Config.sessionButtonActiveBackgroundOpacity
                    activeFocusOnTab: true
                    focus: false
                    onClicked: {
                        popup.open();
                        activePopup = popup;
                    }
                    tooltip_text: "Change session"

                    Popup {
                        id: popup
                        property int popupMargin: 5
                        parent: sessionButton
                        padding: 0
                        background: Rectangle {
                            color: "transparent"
                        }
                        dim: true
                        Overlay.modal: Rectangle {
                            color: "transparent"  // Use whatever color/opacity you like
                        }

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
                            [x, y] = menuArea.calculatePopupPos(Config.sessionPopupDirection, width, height, parent.width, parent.height, parent.parent.x);
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

                    property bool showLabel: Config.languageButtonDisplayLanguageName

                    height: Config.menuAreaButtonsSize
                    icon: "icons/language.svg"
                    pressed: popup.visible
                    borderRadius: Config.menuAreaButtonsBorderRadius
                    iconSize: Config.languageButtonIconSize
                    fontSize: Config.languageButtonFontSize
                    backgroundColor: Config.languageButtonBackgroundColor
                    backgroundOpacity: Config.languageButtonBackgroundOpacity
                    hoverBackgroundColor: Config.languageButtonBackgroundColor
                    hoverBackgroundOpacity: Config.languageButtonActiveBackgroundOpacity
                    iconColor: Config.languageButtonContentColor
                    hoverIconColor: Config.languageButtonActiveContentColor
                    activeFocusOnTab: true
                    focus: false
                    onClicked: {
                        popup.open();
                        activePopup = popup;
                    }
                    tooltip_text: "Change keyboard layout"
                    label: showLabel ? (keyboard.layouts[keyboard.currentLayout] ? keyboard.layouts[keyboard.currentLayout].shortName.toUpperCase() : "") : ""

                    Popup {
                        id: popup
                        property int popupMargin: 5
                        parent: languageButton
                        padding: 0
                        background: Rectangle {
                            color: "transparent"
                        }
                        dim: true
                        Overlay.modal: Rectangle {
                            color: "transparent"  // Use whatever color/opacity you like
                        }

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
                            [x, y] = menuArea.calculatePopupPos(Config.languagePopupDirection, width, height, parent.width, parent.height, parent.parent.x);
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

                    height: Config.menuAreaButtonsSize
                    width: Config.menuAreaButtonsSize
                    icon: "icons/keyboard.svg"
                    iconSize: Config.keyboardButtonIconSize
                    backgroundColor: Config.keyboardButtonBackgroundColor
                    backgroundOpacity: Config.keyboardButtonBackgroundOpacity
                    hoverBackgroundColor: Config.keyboardButtonBackgroundColor
                    hoverBackgroundOpacity: Config.keyboardButtonActiveBackgroundOpacity
                    iconColor: Config.keyboardButtonContentColor
                    hoverIconColor: Config.keyboardButtonActiveContentColor
                    pressed: showKeyboard
                    borderRadius: Config.menuAreaButtonsBorderRadius
                    activeFocusOnTab: true
                    focus: false
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

                    height: Config.menuAreaButtonsSize
                    width: Config.menuAreaButtonsSize
                    icon: "icons/power.svg"
                    iconSize: Config.powerButtonIconSize
                    iconColor: Config.powerButtonContentColor
                    hoverIconColor: Config.powerButtonActiveContentColor
                    pressed: popup.visible
                    borderRadius: Config.menuAreaButtonsBorderRadius
                    backgroundColor: Config.powerButtonBackgroundColor
                    backgroundOpacity: Config.powerButtonBackgroundOpacity
                    hoverBackgroundColor: Config.powerButtonBackgroundColor
                    hoverBackgroundOpacity: Config.powerButtonActiveBackgroundOpacity
                    activeFocusOnTab: true
                    focus: false
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
                        padding: 0
                        Overlay.modal: Rectangle {
                            color: "transparent"  // Use whatever color/opacity you like
                        }

                        modal: true
                        popupType: Popup.Item
                        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside

                        StackLayout {
                            Power {
                                visible: true
                            }
                        }

                        Component.onCompleted: {
                            [x, y] = menuArea.calculatePopupPos(Config.powerPopupDirection, width, height, parent.width, parent.height, parent.parent.x);
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
                spacing: Config.menuAreaSpacing // 10

                anchors {
                    top: parent.top
                    left: parent.left
                    topMargin: Config.menuAreaMarginTop
                    leftMargin: Config.menuAreaMarginLeft
                }
            }

            Row {
                // top_center
                id: topCenterButtons

                height: 30
                spacing: Config.menuAreaSpacing // 10

                anchors {
                    top: parent.top
                    horizontalCenter: parent.horizontalCenter
                    topMargin: Config.menuAreaMarginTop
                }
            }

            Row {
                // top_right
                id: topRightButtons

                height: 30
                spacing: Config.menuAreaSpacing // 10

                anchors {
                    top: parent.top
                    right: parent.right
                    topMargin: Config.menuAreaMarginTop
                    rightMargin: Config.menuAreaMarginRight
                }
            }

            Column {
                // center_left
                id: centerLeftButtons

                width: 30
                spacing: Config.menuAreaSpacing // 10

                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                    leftMargin: Config.menuAreaMarginLeft
                }
            }

            Column {
                // center_right
                id: centerRightButtons

                width: 30
                spacing: Config.menuAreaSpacing // 10

                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                    rightMargin: Config.menuAreaMarginRight
                }
            }

            Row {
                // bottom_left
                id: bottomLeftButtons

                height: 30
                spacing: Config.menuAreaSpacing // 10

                anchors {
                    bottom: parent.bottom
                    left: parent.left
                    bottomMargin: Config.menuAreaMarginBottom
                    leftMargin: Config.menuAreaMarginLeft
                }
            }

            Row {
                // bottom_center
                id: bottomCenterButtons

                height: 30
                spacing: Config.menuAreaSpacing // 10

                anchors {
                    bottom: parent.bottom
                    horizontalCenter: parent.horizontalCenter
                    bottomMargin: Config.menuAreaMarginBottom
                }
            }

            Row {
                // bottom_right
                id: bottomRightButtons

                height: childrenRect.height
                spacing: Config.menuAreaSpacing // 10

                anchors {
                    bottom: parent.bottom
                    right: parent.right
                    bottomMargin: Config.menuAreaMarginBottom
                    rightMargin: Config.menuAreaMarginRight
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
    }
}
