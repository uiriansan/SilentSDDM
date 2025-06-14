import QtQuick
import QtQuick.VirtualKeyboard
import QtQuick.VirtualKeyboard.Settings

// FIX: Virtual keyboard not working on the second loginScreen.
InputPanel {
    id: inputPanel

    width: Math.min(loginScreen.width / 2, 600) * Config.virtualKeyboardScale
    active: Qt.inputMethod.visible
    visible: loginScreen.showKeyboard && loginScreen.userNeedsPassword && loginScreen.state !== "selectingUser" && loginScreen.state !== "authenticating"
    externalLanguageSwitchEnabled: true
    onExternalLanguageSwitch: {
        loginScreen.toggleLayoutPopup();
    }

    Component.onCompleted: {
        VirtualKeyboardSettings.styleName = "tstyle";
        VirtualKeyboardSettings.layout = "symbols";
    }

    property string pos: Config.virtualKeyboardPosition
    property point loginLayoutPosition: loginContainer.mapToGlobal(loginLayout.x, loginLayout.y)

    x: {
        if (pos === "top" || pos === "bottom") {
            return (parent.width - inputPanel.width) / 2;
        } else if (pos === "left") {
            return Config.menuAreaButtonsMarginLeft;
        } else if (pos === "right") {
            return parent.width - inputPanel.width - Config.menuAreaButtonsMarginRight;
        } else {
            // pos === "login"
            if (Config.loginAreaPosition === "left") {
                // return loginLayoutPosition.x;
                return Config.loginAreaMargin + Config.avatarActiveSize + Config.usernameMargin;
            } else if (Config.loginAreaPosition === "right") {
                return parent.width - inputPanel.width - Config.loginAreaMargin;
            } else {
                return (parent.width - inputPanel.width) / 2;
            }
        }
    }
    y: {
        if (pos === "top") {
            return Config.menuAreaButtonsMarginTop;
        } else if (pos === "bottom") {
            return parent.height - inputPanel.height - Config.menuAreaButtonsMarginBottom;
        } else if (pos === "right" || pos === "left") {
            return (parent.height - inputPanel.height) / 2;
        } else {
            // pos === "login"
            return loginMessage.visible ? (loginLayoutPosition.y + loginLayout.height + loginMessage.height + Config.warningMessageMarginTop * 2) : (loginLayoutPosition.y + loginLayout.height + Config.warningMessageMarginTop * 2);
        }
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
