//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                          https://doc.qt.io/qt-6/qml-qtquick-controls-popup.html                          //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

import "."
import QtQuick
import QtQuick.Controls
import QtQuick.VirtualKeyboard
import QtQuick.VirtualKeyboard.Settings
import SddmComponents

Item {
    id: loginFrame

    property int sessionIndex: sessionModel.lastIndex
    property string userIndex: userList.currentIndex
    property string userName: userModel.lastUser
    property string userIcon: userList.currentItem.iconPath
    property alias input: passwdInput
    property alias button: loginButton
    property bool showKeyboard: false
    property bool returnKeyboard: false
    property string activeMenu: ""
    property bool isAuthorizing: false

    signal needClose

    function delay(delayTime, cb) {
        loginTimer.interval = delayTime;
        loginTimer.repeat = false;
        loginTimer.triggered.connect(cb);
        loginTimer.start();
    }

    onActiveMenuChanged: {
        if (returnKeyboard) {
            showKeyboard = true;
            returnKeyboard = false;
        }
        passwdInput.forceActiveFocus();
    }

    Connections {
        function onLoginSucceeded() {
            spinner.visible = false;
        }

        function onLoginFailed() {
            isAuthorizing = false;
            spinner.visible = false;
            loginMessage.warn("Wrong password", "error");
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
            VirtualKeyboardSettings.locale = Languages.getKBCodeFor(keyboard.layouts[keyboard.currentLayout].shortName);
        }
        focus: activeMenu !== ""
        Keys.onEscapePressed: () => {
            if (loginFrame.activeMenu !== "") {
                loginFrame.activeMenu = "";
                passwdInput.forceActiveFocus();
                return;
            }
            if (isAuthorizing)
                return;

            if (config.showLockScreen !== "false")
                needClose();

            passwdInput.text = "";
        }
        Keys.onPressed: event => {
            if (event.key == Qt.Key_CapsLock && !isAuthorizing) {
                if (keyboard.capsLock)
                    loginMessage.warn("CapsLock on", "warning");
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
                enabled: loginFrame.activeMenu === ""
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
                anchors.left: (passwdInput.right)
                anchors.leftMargin: config.loginButtonMarginLeft || 5
                icon: "icons/arrow-right.svg"
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

            function warn(message, type) {
                text = message;
                enabled = true;
            }

            function clear() {
                enabled = false;
                text = "";
            }

            font.pointSize: config.warningMessageSize || 9
            font.family: config.font || "RedHatDisplay"
            color: config.warningMessageColor || "#FFFFFF"
            enabled: false
            Component.onCompleted: {
                if (keyboard.capsLock)
                    loginMessage.warn("CapsLock on", "warning");
            }

            anchors {
                horizontalCenter: parent.horizontalCenter
                top: loginArea.bottom
                topMargin: 50
            }
        }

        Session {
            id: sessionButton

            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.bottomMargin: 50
            anchors.leftMargin: 50
            visible: config.showSessionButton === "false" ? false : true
            popupVisible: loginFrame.activeMenu === "session"
            onClick: {
                loginFrame.activeMenu = "session";
                if (showKeyboard) {
                    showKeyboard = false;
                    returnKeyboard = true;
                }
            }
            onSessionChanged: newSessionIndex => {
                sessionIndex = newSessionIndex;
                loginFrame.activeMenu = "";
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

            IconButton {
                id: languageButton

                height: 30
                icon: "icons/language.svg"
                iconSize: 15
                onClicked: {
                    loginFrame.activeMenu = "language";
                }
                tooltip_text: "Change keyboard layout"
                label: keyboard.layouts[keyboard.currentLayout].shortName.toUpperCase()

                Language {
                    anchors.bottom: parent.top
                    anchors.horizontalCenter: parent.horizontalCenter
                    visible: loginFrame.activeMenu === "language"
                    onLanguageChanged: index => {
                        languageButton.label = keyboard.layouts[keyboard.currentLayout].shortName.toUpperCase();
                        VirtualKeyboardSettings.locale = Languages.getKBCodeFor(keyboard.layouts[keyboard.currentLayout].shortName);
                    }
                }
            }

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

            function calculatePopupDir(dir, popup_w, popup_h, parent_w, parent_h) {
                var x = 0, y = 0;
                const popup_margin = 5;
                if (dir === "up") {
                    x = (parent_w - popup_w) / 2;
                    y = -popup_h - popup_margin;
                } else if (dir === "down") {
                    x = (parent_w - popup_w) / 2;
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
                id: powerMenuComponent

                IconButton {
                    id: powerButton

                    height: 30
                    width: 30
                    icon: "icons/power.svg"
                    iconSize: 15
                    onClicked: {
                        popup.open();
                    }
                    tooltip_text: "Power options"

                    Popup {
                        id: popup
                        property int popupMargin: 5
                        width: contentItem.width
                        height: contentItem.height
                        parent: powerButton

                        focus: true
                        modal: true
                        popupType: Popup.Item
                        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
                        contentItem: Power {
                            visible: true
                            anchors {
                                top: parent.top
                                left: parent.left
                            }
                            onOptionSelected: index => {
                                languageButton.label = keyboard.layouts[keyboard.currentLayout].shortName.toUpperCase();
                            }
                        }
                        Component.onCompleted: {
                            [x, y] = bottomRightButtons.calculatePopupDir("up", width, height, parent.width, parent.height);
                        }
                    }
                }
            }

            Component.onCompleted: {
                var btn = powerMenuComponent.createObject(bottomRightButtons, {});
            }
        }

        MouseArea {
            anchors.fill: parent
            enabled: loginFrame.activeMenu !== "" || isAuthorizing
            visible: loginFrame.activeMenu !== "" || isAuthorizing
            hoverEnabled: true
            onClicked: {
                if (isAuthorizing)
                    return;

                loginFrame.activeMenu = "";
            }
        }
    }
}
