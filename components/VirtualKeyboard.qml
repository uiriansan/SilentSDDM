import QtQuick
import QtQuick.VirtualKeyboard
import QtQuick.VirtualKeyboard.Settings

// FIX: Virtual keyboard not working on the second loginScreen.
InputPanel {
    id: inputPanel

    // FIX: Scope violation fixes - proper parent scope access
    width: Math.min(loginScreen && loginScreen.width ? loginScreen.width / 2 : 800, 600) * Config.virtualKeyboardScale
    active: Qt.inputMethod.visible
    visible: loginScreen && loginScreen.showKeyboard && loginScreen.state !== "selectingUser" && loginScreen.state !== "authenticating"
    opacity: visible ? 1.0 : 0.0
    externalLanguageSwitchEnabled: true
    onExternalLanguageSwitch: {
        // FIX: Scope violation fixes - safe parent method call
        if (loginScreen && loginScreen.toggleLayoutPopup) {
            loginScreen.toggleLayoutPopup();
        }
    }

    Component.onCompleted: {
        VirtualKeyboardSettings.styleName = "vkeyboardStyle";
        VirtualKeyboardSettings.layout = "symbols";
    }

    property string pos: Config.virtualKeyboardPosition
    // FIX: Scope violation fixes - safe parent object access
    property point loginLayoutPosition: loginContainer && loginLayout ? loginContainer.mapToGlobal(loginLayout.x, loginLayout.y) : Qt.point(0, 0)
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
            // pos === "login"
            if (!vKeyboardMoved) {
                // FIX: Scope violation fixes - safe parent object access
                if (loginMessage && loginMessage.visible && Config.loginAreaPosition !== "right" && Config.loginAreaPosition !== "left") {
                    return loginLayoutPosition.y + (loginLayout ? loginLayout.height : 0) + (loginMessage ? loginMessage.height * 2 : 0) + Config.warningMessageMarginTop + Config.warningMessageMarginTop;
                } else {
                    return loginLayoutPosition.y + (loginLayout ? loginLayout.height : 0) + (loginMessage ? loginMessage.height * 2 : 0) + Config.warningMessageMarginTop;
                }
            }
            return y;
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
        // FIX: Scope violation fixes - safe parent property access
        cursorShape: loginScreen && loginScreen.userNeedsPassword ? Qt.ArrowCursor : Qt.ForbiddenCursor
        drag.target: inputPanel
        // FIX: Scope violation fixes - safe parent property access
        acceptedButtons: loginScreen && loginScreen.userNeedsPassword ? Qt.MiddleButton : Qt.MiddleButton
        onPressed: event => {
            cursorShape = Qt.ClosedHandCursor;
            initialPosition = Qt.point(event.x, event.y);
        }
        onReleased: event => {
            // FIX: Scope violation fixes - safe parent property access
            cursorShape = loginScreen && loginScreen.userNeedsPassword ? Qt.ArrowCursor : Qt.ForbiddenCursor;
            if (initialPosition !== Qt.point(event.x, event.y) && !inputPanel.vKeyboardMoved) {
                inputPanel.vKeyboardMoved = true;
            }
        }
    }
}
