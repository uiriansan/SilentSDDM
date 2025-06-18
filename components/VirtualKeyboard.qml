import QtQuick
import QtQuick.VirtualKeyboard
import QtQuick.VirtualKeyboard.Settings

// FIX: Virtual keyboard not working on the second loginScreen.
InputPanel {
    id: inputPanel

    width: Math.min(loginScreen.width / 2, 600) * Config.virtualKeyboardScale
    active: Qt.inputMethod.visible
    visible: loginScreen.showKeyboard && loginScreen.state !== "selectingUser" && loginScreen.state !== "authenticating"
    opacity: visible ? 1.0 : 0.0
    externalLanguageSwitchEnabled: true
    onExternalLanguageSwitch: {
        loginScreen.toggleLayoutPopup();
    }

    Component.onCompleted: {
        VirtualKeyboardSettings.styleName = "vkeyboardStyle";
        VirtualKeyboardSettings.layout = "symbols";
    }

    property string pos: Config.virtualKeyboardPosition
    property bool vKeyboardMoved: false

    x: {
        if (pos === "top" || pos === "bottom") {
            return (parent.width - inputPanel.width) / 2;
        } else if (pos === "left") {
            return Config.menuAreaButtonsMarginLeft;
        } else if (pos === "right") {
            return parent.width - inputPanel.width - Config.menuAreaButtonsMarginRight;
        } else {
            // pos === "login"
            if (Config.loginAreaPosition === "left" && Config.loginAreaMargin !== -1) {
                // return loginLayoutPosition.x;
                return Config.loginAreaMargin;
            } else if (Config.loginAreaPosition === "right" && Config.loginAreaMargin !== -1) {
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
            // pos === "login" - position relative to login area
            if (loginScreen.loginContainer && loginScreen.loginContainer.y !== undefined) {
                return loginScreen.loginContainer.y + loginScreen.loginContainer.height + 20;
            } else {
                // Fallback to bottom positioning if login container not accessible
                return parent.height - inputPanel.height - Config.menuAreaButtonsMarginBottom;
            }
        }
    }
    Behavior on y {
        enabled: Config.enableAnimations
        NumberAnimation {
            duration: 150
        }
    }
    Behavior on x {
        enabled: Config.enableAnimations
        NumberAnimation {
            duration: 150
        }
    }
    Behavior on opacity {
        enabled: Config.enableAnimations
        NumberAnimation {
            duration: 250
        }
    }

    MouseArea {
        id: vKeyboardDragArea
        property point initialPosition: Qt.point(-1, -1)
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: loginScreen.userNeedsPassword ? Qt.ArrowCursor : Qt.ForbiddenCursor
        drag.target: inputPanel
        acceptedButtons: loginScreen.userNeedsPassword ? Qt.MiddleButton : Qt.MiddleButton
        onPressed: event => {
            cursorShape = Qt.ClosedHandCursor;
            initialPosition = Qt.point(event.x, event.y);
        }
        onReleased: event => {
            cursorShape = loginScreen.userNeedsPassword ? Qt.ArrowCursor : Qt.ForbiddenCursor;
            if (initialPosition !== Qt.point(event.x, event.y) && !inputPanel.vKeyboardMoved) {
                inputPanel.vKeyboardMoved = true;
            }
        }
    }
}
