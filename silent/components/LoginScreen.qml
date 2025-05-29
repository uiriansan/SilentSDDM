import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.VirtualKeyboard
import QtQuick.VirtualKeyboard.Settings
import SddmComponents

Item {
    id: screen
    signal closeRequested

    readonly property alias password: passwdInput
    readonly property alias loginButton: loginButton
    readonly property alias loginArea: loginArea

    property bool showKeyboard: !Config.virtualKeyboardStartHidden

    // Login info
    property int sessionIndex: sessionModel ? sessionModel.lastIndex : 0
    property int userIndex: userList.currentIndex
    property string userName: userList.currentItem.name
    property string userIcon: userList.currentItem.iconPath
    property bool userNeedsPassword: false
    property bool isAuthenticating: false

    function login() {
        if (passwdInput.text.length > 0 || !userNeedsPassword) {
            spinner.visible = true;
            loginArea.visible = false;
            isAuthenticating = true;
            sddm.login(userName, password.text, sessionIndex);
        }
    }
    Connections {
        function onLoginSucceeded() {
            spinner.visible = false;
            loginArea.scale = 0.0;
        }
        function onLoginFailed() {
            isAuthenticating = false;
            spinner.visible = false;
            loginMessage.warn(textConstants.loginFailed, "error");
            password.text = "";
            password.input.forceActiveFocus();
            loginArea.visible = true;
        }
        function onInformationMessage(message) {
            loginMessage.warn(message, "error");
        }
        target: sddm
    }

    Text {
        id: passwdInput
    }
    Item {
        id: loginButton
    }
    Item {
        id: loginArea
    }
}
