import QtQuick
import QtQuick.VirtualKeyboard
import QtQuick.VirtualKeyboard.Settings

// FIX: Virtual keyboard not working on the second loginScreen.
InputPanel {
    id: inputPanel

    width: Math.min(loginScreen.width / 2, loginArea.width * 3) * Config.virtualKeyboardScale
    active: Qt.inputMethod.visible
    visible: loginScreen.showKeyboard && !loginScreen.isSelectingUser && !loginScreen.isAuthenticating
    externalLanguageSwitchEnabled: true
    onExternalLanguageSwitch: {
        loginScreen.toggleLayoutPopup();
    }

    Component.onCompleted: {
        VirtualKeyboardSettings.styleName = "tstyle";
        VirtualKeyboardSettings.layout = "symbols";
    }

    property string pos: Config.virtualKeyboardPosition

    x: {
        if (pos === "top" || pos === "bottom")
            return (parent.width - inputPanel.width) / 2;
        else if (pos === "left")
            return Config.loginAreaMargin;
        else
            return parent.width - inputPanel.width - Config.loginAreaMargin;
    }
    y: {
        if (pos === "top")
            return Config.loginAreaMargin;
        else if (pos === "bottom")
            return loginMessage.visible ? (loginContainerContainer.mapToGlobal(loginMessage.x, loginMessage.y).y + 25) : loginContainerContainer.mapToGlobal(loginMessage.x, loginMessage.y).y;
        else
            return (parent.height - inputPanel.height) / 2;
    }
    Behavior on y {
        enabled: Config.enableAnimations
        NumberAnimation {
            duration: 150
        }
    }

    MouseArea {
        id: vKeyboardDragArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.ArrowCursor
        drag.target: inputPanel
        acceptedButtons: Qt.MiddleButton
        onPressed: cursorShape = Qt.ClosedHandCursor
        onReleased: cursorShape = Qt.ArrowCursor
    }
}
