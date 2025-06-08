import QtQuick
import QtQuick.Controls

Item {
    id: menuArea
    anchors.fill: parent

    function calculatePopupPos(dir, popup_w, popup_h, parent_w, parent_h, parent_x, parent_y) {
        let x = 0, y = 0;
        const popup_margin = Config.menuAreaPopupsMargin;

        // TODO: This positioning is not working correctly
        print("parent_x: ", parent_x, "parent_w: ", parent_w, "popup_w: ", popup_w);
        if (dir === "up") {
            if (parent_x + (parent_w - popup_w) / 2 < 10) {
                // Align popup left
                x = 0;
            } else if (parent_x - (parent_w - popup_w) / 2 > loginScreen.width - 10) {
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
            } else if (parent_x - (parent_w - popup_w) / 2 > loginScreen.width - 10) {
                // Align popup right
                x = -popup_w + parent_w;
            } else {
                // Center popup
                x = (parent_w - popup_w) / 2;
            }
            y = parent_h + popup_margin;
        } else if (dir === "left") {
            x = -popup_w - popup_margin;
            if (parent_y + popup_h > loginScreen.height)
                y = -popup_h + parent_h;
            else
                y = 0;
        } else {
            x = parent_w + popup_margin;
            if (parent_y + popup_h > loginScreen.height)
                y = -popup_h + parent_h;
            else
                y = 0;
        }
        return [x, y];
    }

    Component {
        id: sessionMenuComponent

        IconButton {
            id: sessionButton
            property bool showLabel: Config.sessionDisplaySessionName
            width: showLabel ? popup.width : Config.menuAreaButtonsSize
            height: Config.menuAreaButtonsSize
            iconSize: Config.sessionIconSize
            fontSize: Config.sessionFontSize
            enabled: !loginScreen.isSelectingUser && !loginScreen.isAuthenticating
            active: popup.visible
            iconColor: Config.sessionContentColor
            activeIconColor: Config.sessionActiveContentColor
            borderRadius: Config.menuAreaButtonsBorderRadius
            borderSize: Config.sessionBorderSize
            backgroundColor: Config.sessionBackgroundColor
            backgroundOpacity: Config.sessionBackgroundOpacity
            activeBackgroundColor: Config.sessionBackgroundColor
            activeBackgroundOpacity: Config.sessionActiveBackgroundOpacity
            fontFamily: Config.menuAreaButtonsFontFamily
            activeFocusOnTab: true
            focus: false
            onClicked: {
                if (loginScreen.isSelectingUser) {
                    loginScreen.isSelectingUser = false;
                } else {
                    popup.open();
                }
            }
            tooltipText: "Change session"

            Popup {
                id: popup
                parent: sessionButton
                padding: Config.menuAreaPopupsPadding
                rightPadding: 0 // For the scrollbar
                background: Rectangle {
                    color: Config.menuAreaPopupsBackgroundColor
                    opacity: Config.menuAreaPopupsBackgroundOpacity
                    radius: 5 // Remove dim background (dim: false doesn't work here)
                }
                dim: true
                Overlay.modal: Rectangle {
                    color: "transparent"  // Use whatever color/opacity you like
                    MouseArea {
                        // Fix popup not closing sometimes
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: event => {
                            popup.close();
                            event.accepted = true;
                        }
                    }
                }

                onOpened: loginScreen.state = "popup"
                onClosed: loginScreen.state = "normal"

                modal: true
                popupType: Popup.Item
                closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
                focus: visible

                SessionSelector {
                    focus: popup.focus
                    onSessionChanged: (newSessionIndex, sessionIcon, sessionLabel) => {
                        loginScreen.sessionIndex = newSessionIndex;
                        sessionButton.icon = sessionIcon;
                        sessionButton.label = sessionButton.showLabel ? sessionLabel : "";
                    }
                    onClose: {
                        popup.close();
                    }
                }

                Component.onCompleted: {
                    [x, y] = menuArea.calculatePopupPos(Config.sessionPopupDirection, width, height, parent.width, parent.height, parent.parent.x, parent.parent.y);
                }
            }
        }
    }

    Component {
        id: languageMenuComponent

        IconButton {
            id: languageButton

            property bool showLabel: Config.layoutDisplayLayoutName

            height: Config.menuAreaButtonsSize
            icon: Config.getIcon(Config.layoutIcon)
            active: popup.visible
            borderRadius: Config.menuAreaButtonsBorderRadius
            borderSize: Config.layoutBorderSize
            iconSize: Config.layoutIconSize
            fontSize: Config.layoutFontSize
            backgroundColor: Config.layoutBackgroundColor
            backgroundOpacity: Config.layoutBackgroundOpacity
            activeBackgroundColor: Config.layoutBackgroundColor
            activeBackgroundOpacity: Config.layoutActiveBackgroundOpacity
            iconColor: Config.layoutContentColor
            activeIconColor: Config.layoutActiveContentColor
            fontFamily: Config.menuAreaButtonsFontFamily
            activeFocusOnTab: true
            enabled: !loginScreen.isSelectingUser && !loginScreen.isAuthenticating
            focus: false
            onClicked: {
                if (loginScreen.isSelectingUser) {
                    loginScreen.isSelectingUser = false;
                } else {
                    popup.open();
                }
            }
            tooltipText: "Change keyboard layout"
            label: showLabel ? (keyboard.layouts[keyboard.currentLayout] ? keyboard.layouts[keyboard.currentLayout].shortName.toUpperCase() : "") : ""

            Connections {
                target: loginScreen
                function onToggleLayoutPopup() {
                    popup.visible ? popup.close() : popup.open();
                }
            }

            Popup {
                id: popup
                parent: languageButton
                padding: Config.menuAreaPopupsPadding
                background: Rectangle {
                    color: Config.menuAreaPopupsBackgroundColor
                    opacity: Config.menuAreaPopupsBackgroundOpacity
                    radius: 5 // Remove dim background (dim: false doesn't work here)
                }
                focus: visible
                dim: true
                Overlay.modal: Rectangle {
                    color: "transparent" // Remove dim background (dim: false doesn't work here)
                    MouseArea {
                        // Fix popup not closing sometimes
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: event => {
                            popup.close();
                            event.accepted = true;
                        }
                    }
                }

                onOpened: loginScreen.state = "popup"
                onClosed: loginScreen.state = "normal"

                modal: true
                popupType: Popup.Item
                closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
                LayoutSelector {
                    focus: popup.focus
                    onLayoutChanged: index => {
                        languageButton.label = keyboard.layouts[keyboard.currentLayout].shortName.toUpperCase();
                        VirtualKeyboardSettings.locale = Languages.getKBCodeFor(keyboard.layouts[keyboard.currentLayout].shortName);
                    }
                    onClose: {
                        popup.close();
                        password.input.forceActiveFocus();
                    }
                }

                Component.onCompleted: {
                    [x, y] = menuArea.calculatePopupPos(Config.layoutPopupDirection, width, height, parent.width, parent.height, parent.parent.x, parent.parent.y);
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
            icon: Config.getIcon(Config.keyboardIcon)
            iconSize: Config.keyboardIconSize
            backgroundColor: Config.keyboardBackgroundColor
            backgroundOpacity: Config.keyboardBackgroundOpacity
            activeBackgroundColor: Config.keyboardBackgroundColor
            activeBackgroundOpacity: Config.keyboardActiveBackgroundOpacity
            iconColor: Config.keyboardContentColor
            activeIconColor: Config.keyboardActiveContentColor
            active: showKeyboard
            fontFamily: Config.menuAreaButtonsFontFamily
            borderRadius: Config.menuAreaButtonsBorderRadius
            borderSize: Config.keyboardBorderSize
            enabled: !loginScreen.isSelectingUser && !loginScreen.isAuthenticating
            activeFocusOnTab: true
            focus: false
            onClicked: {
                loginScreen.showKeyboard = !loginScreen.showKeyboard;
            }
            tooltipText: "Toggle virtual keyboard"
        }
    }

    Component {
        id: powerMenuComponent

        IconButton {
            id: powerButton

            height: Config.menuAreaButtonsSize
            width: Config.menuAreaButtonsSize
            icon: Config.getIcon(Config.powerIcon)
            iconSize: Config.powerIconSize
            iconColor: Config.powerContentColor
            activeIconColor: Config.powerActiveContentColor
            fontFamily: Config.menuAreaButtonsFontFamily
            active: popup.visible
            borderRadius: Config.menuAreaButtonsBorderRadius
            borderSize: Config.powerBorderSize
            backgroundColor: Config.powerBackgroundColor
            backgroundOpacity: Config.powerBackgroundOpacity
            activeBackgroundColor: Config.powerBackgroundColor
            activeBackgroundOpacity: Config.powerActiveBackgroundOpacity
            enabled: !loginScreen.isSelectingUser && !loginScreen.isAuthenticating
            activeFocusOnTab: true
            focus: false
            onClicked: {
                popup.open();
            }
            tooltipText: "Power options"

            Popup {
                id: popup
                parent: powerButton
                background: Rectangle {
                    color: Config.menuAreaPopupsBackgroundColor
                    opacity: Config.menuAreaPopupsBackgroundOpacity
                    radius: 5
                }
                dim: true
                padding: Config.menuAreaPopupsPadding
                Overlay.modal: Rectangle {
                    color: "transparent"  // Remove dim background (dim: false doesn't work here)
                    MouseArea {
                        // Fix popup not closing sometimes
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: event => {
                            popup.close();
                            event.accepted = true;
                        }
                    }
                }

                onOpened: loginScreen.state = "popup"
                onClosed: loginScreen.state = "normal"

                modal: true
                popupType: Popup.Item
                closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
                focus: visible

                PowerMenu {
                    focus: popup.focus
                    onClose: popup.close()
                }

                Component.onCompleted: {
                    [x, y] = menuArea.calculatePopupPos(Config.powerPopupDirection, width, height, parent.width, parent.height, parent.parent.x, parent.parent.y);
                }
            }
        }
    }

    Row {
        // top_left
        id: topLeftButtons

        height: 30
        spacing: Config.menuAreaButtonsSpacing // 10

        anchors {
            top: parent.top
            left: parent.left
            topMargin: Config.loginScreenPaddingTop
            leftMargin: Config.loginScreenPaddingLeft
        }
    }

    Row {
        // top_center
        id: topCenterButtons

        height: 30
        spacing: Config.menuAreaButtonsSpacing // 10

        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            topMargin: Config.loginScreenPaddingTop
        }
    }

    Row {
        // top_right
        id: topRightButtons

        height: 30
        spacing: Config.menuAreaButtonsSpacing // 10

        anchors {
            top: parent.top
            right: parent.right
            topMargin: Config.loginScreenPaddingTop
            rightMargin: Config.loginScreenPaddingRight
        }
    }

    Column {
        // center_left
        id: centerLeftButtons

        width: 30
        spacing: Config.menuAreaButtonsSpacing // 10

        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
            leftMargin: Config.loginScreenPaddingLeft
        }
    }

    Column {
        // center_right
        id: centerRightButtons

        width: 30
        spacing: Config.menuAreaButtonsSpacing // 10

        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
            rightMargin: Config.loginScreenPaddingRight
        }
    }

    Row {
        // bottom_left
        id: bottomLeftButtons

        height: 30
        spacing: Config.menuAreaButtonsSpacing // 10

        anchors {
            bottom: parent.bottom
            left: parent.left
            bottomMargin: Config.loginScreenPaddingBottom
            leftMargin: Config.loginScreenPaddingLeft
        }
    }

    Row {
        // bottom_center
        id: bottomCenterButtons

        height: 30
        spacing: Config.menuAreaButtonsSpacing // 10

        anchors {
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
            bottomMargin: Config.loginScreenPaddingBottom
        }
    }

    Row {
        // bottom_right
        id: bottomRightButtons

        height: childrenRect.height
        spacing: Config.menuAreaButtonsSpacing // 10

        anchors {
            bottom: parent.bottom
            right: parent.right
            bottomMargin: Config.loginScreenPaddingBottom
            rightMargin: Config.loginScreenPaddingRight
        }
    }

    Component.onCompleted: {
        const menus = Config.sortMenuButtons();

        for (let i = 0; i < menus.length; i++) {
            let pos;
            switch (menus[i].position) {
            case "top-left":
                pos = topLeftButtons;
                break;
            case "top-center":
                pos = topCenterButtons;
                break;
            case "top-right":
                pos = topRightButtons;
                break;
            case "center-left":
                pos = centerLeftButtons;
                break;
            case "center-right":
                pos = centerRightButtons;
                break;
            case "bottom-left":
                pos = bottomLeftButtons;
                break;
            case "bottom-center":
                pos = bottomCenterButtons;
                break;
            case "bottom-right":
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
