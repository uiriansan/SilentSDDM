import QtQuick 2.5
import QtQuick.Controls 2.5
// import QtGraphicalEffects 1.12
import QtQuick.VirtualKeyboard 2.15
import QtQuick.VirtualKeyboard.Settings 2.15
import SddmComponents 2.0

import "."

Item {
    id: loginFrame
    signal needClose
    property int sessionIndex: sessionModel.lastIndex
    property string userIndex: userList.currentIndex
    property string userName: userModel.lastUser
    property string userIcon: userList.currentItem.iconPath
    property alias input: passwdInput
    property alias button: loginButton
    property bool showKeyboard: false
    property bool returnKeyboard: false

    property string activeMenu: ""
    onActiveMenuChanged: {
        if (returnKeyboard) {
            showKeyboard = true;
            returnKeyboard = false;
        }

        passwdInput.forceActiveFocus();
    }

    property bool isAuthorizing: false

    Connections {
        target: sddm
        function onLoginSucceeded() {
            spinner.visible = false;
            Qt.quit();
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
    }

    Item {
        id: loginItem
        anchors.centerIn: parent
        width: parent.width
        height: parent.height

        User {
            id: userListContainer
            width: parent.width
            height: config.selectedAvatarSize || 120
            listUsers: loginFrame.activeMenu === "user"
            enabled: loginFrame.activeMenu === "user" || loginFrame.activeMenu === ""
            anchors {
                top: parent.top
                topMargin: parent.height / 3
                horizontalCenter: parent.horizontalCenter
            }
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
        }

        Text {
            id: userNameText
            anchors {
                top: userListContainer.bottom
                topMargin: 10
                horizontalCenter: parent.horizontalCenter
            }

            text: userName
            font.bold: true
            font.family: config.font || "RedHatDisplay"
            color: config.userNameColor || "#FFFFFF"
            font.pointSize: config.userNameFontSize || 15
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

            TextField {
                id: passwdInput
                width: config.passwordInputWidth || 200
                height: config.passwordInputHeight || 30
                anchors.left: parent.left
                echoMode: TextInput.Password
                enabled: loginFrame.activeMenu === ""
                focus: false
                placeholderText: qsTr("Password")
                placeholderTextColor: config.passwordInputTextColor || "#FFFFFF"
                palette.text: config.passwordInputTextColor || "#FFFFFF"
                font.family: config.font || "RedHatDisplay"
                font.pointSize: config.passwordInputFontSize || 8
                font.italic: true
                background: Rectangle {
                    color: config.passwordInputBackgroundColor || "#FFFFFF"
                    opacity: config.passwordInputBackgroundOpacity || 0.15
                    radius: 10
                    width: parent.width
                    height: parent.height
                    anchors.centerIn: parent
                }
                selectByMouse: true
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
                hoverBackgroundOpacity: config.loginButtonHoverBackgroundOpacity || 0.30
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

        // TODO: Virtual keyboard not working on the second screen.
        InputPanel {
            id: inputPanel
            z: 99
            width: Math.min(parent.width / 2, loginArea.width * 3)
            anchors {
                top: loginArea.bottom
                horizontalCenter: parent.horizontalCenter
                topMargin: loginMessage.text === "" ? 50 : 80
            }
            visible: showKeyboard
            externalLanguageSwitchEnabled: true
            onExternalLanguageSwitch: {
                activeMenu = "language";
            }
            Component.onCompleted: {
                VirtualKeyboardSettings.styleName = "tstyle";
                VirtualKeyboardSettings.activeLocales = ["pt_BR"];
                VirtualKeyboardSettings.layout = "symbols";

                print(JSON.stringify(keyboard.currentLayout));
            }
        }

        Text {
            id: loginMessage
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: loginArea.bottom
                topMargin: 50
            }
            font.pointSize: config.warningMessageSize || 9
            font.family: config.font || "RedHatDisplay"
            color: config.warningMessageColor || "#FFFFFF"
            enabled: false

            function warn(message, type) {
                text = message;
                enabled = true;
            }
            function clear() {
                enabled = false;
                text = "";
            }

            Component.onCompleted: {
                if (keyboard.capsLock)
                    loginMessage.warn("CapsLock on", "warning");
            }
        }

        Session {
            id: sessionButton
            anchors.bottom: parent.bottom
            z: 2
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

        Item {
            id: rightButtons
            height: childrenRect.height
            anchors {
                bottom: parent.bottom
                right: parent.right
                bottomMargin: 50
                rightMargin: 50
            }

            IconButton {
                id: keyboardButton
                height: 30
                width: 30
                anchors.right: languageButton.left
                anchors.rightMargin: 10
                icon: "icons/keyboard.svg"
                iconSize: 15
                pressed: showKeyboard
                onClicked: {
                    showKeyboard = !showKeyboard;
                }
                tooltip_text: "Toggle virtual keyboard"
            }

            IconButton {
                id: languageButton
                height: 30
                width: 30
                anchors.right: powerButton.left
                anchors.rightMargin: 10
                icon: "icons/language.svg"
                iconSize: 15
                onClicked: {}
                tooltip_text: "Change keyboard layout"
            }

            IconButton {
                id: powerButton
                height: 30
                width: 30
                anchors.right: parent.right
                icon: "icons/power.svg"
                iconSize: 15
                onClicked: {}
                tooltip_text: "Power options"
            }
        }

        MouseArea {
            anchors.fill: parent
            z: 1
            enabled: loginFrame.activeMenu !== "" || isAuthorizing
            visible: loginFrame.activeMenu !== "" || isAuthorizing
            hoverEnabled: true
            onClicked: {
                if (isAuthorizing)
                    return;
                loginFrame.activeMenu = "";
            }
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
    }
}
