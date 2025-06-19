import QtQuick
import QtQuick.Controls

Item {
    id: menuArea
    anchors.fill: parent

    Component {
        id: sessionMenuComponent

        IconButton {
            id: sessionButton
            property bool showLabel: Config.sessionDisplaySessionName
            preferredWidth: showLabel ? (Config.sessionButtonWidth === -1 ? undefined : Config.sessionButtonWidth) : Config.menuAreaButtonsSize
            height: Config.menuAreaButtonsSize
            iconSize: Config.sessionIconSize
            fontSize: Config.sessionFontSize
            enabled: loginScreen.state === "normal" || popup.visible
            active: popup.visible
            contentColor: Config.sessionContentColor
            activeContentColor: Config.sessionActiveContentColor
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
                background: Rectangle {
                    color: Config.menuAreaPopupsBackgroundColor
                    opacity: Config.menuAreaPopupsBackgroundOpacity
                    radius: Config.menuAreaButtonsBorderRadius

                    Rectangle {
                        anchors.fill: parent
                        visible: Config.menuAreaPopupsBorderSize > 0
                        radius: parent.radius
                        color: "transparent"
                        border {
                            color: Config.menuAreaPopupsBorderColor
                            width: Config.menuAreaPopupsBorderSize
                        }
                    }
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
                    [x, y] = menuArea.calculatePopupPos(Config.sessionPopupDirection, Config.sessionPopupAlign, popup, sessionButton);
                }
            }
        }
    }

    Component {
        id: layoutMenuComponent

        IconButton {
            id: layoutButton

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
            contentColor: Config.layoutContentColor
            activeContentColor: Config.layoutActiveContentColor
            fontFamily: Config.menuAreaButtonsFontFamily
            activeFocusOnTab: true
            enabled: loginScreen.state === "normal" || popup.visible
            focus: false
            onClicked: {
                if (loginScreen.isSelectingUser) {
                    loginScreen.isSelectingUser = false;
                } else {
                    popup.open();
                }
            }
            tooltipText: "Change keyboard layout"
            // FIX: Array bounds checking for keyboard layouts
            label: showLabel ? (keyboard && keyboard.layouts && keyboard.currentLayout >= 0 && keyboard.currentLayout < keyboard.layouts.length ? keyboard.layouts[keyboard.currentLayout].shortName.toUpperCase() : "") : ""

            Connections {
                target: loginScreen
                function onToggleLayoutPopup() {
                    if (popup.visible) {
                        popup.close();
                    } else {
                        popup.open();
                    }
                }
            }

            Popup {
                id: popup
                parent: layoutButton
                padding: Config.menuAreaPopupsPadding
                background: Rectangle {
                    color: Config.menuAreaPopupsBackgroundColor
                    opacity: Config.menuAreaPopupsBackgroundOpacity
                    radius: Config.menuAreaButtonsBorderRadius

                    Rectangle {
                        anchors.fill: parent
                        visible: Config.menuAreaPopupsBorderSize > 0
                        radius: parent.radius
                        color: "transparent"
                        border {
                            color: Config.menuAreaPopupsBorderColor
                            width: Config.menuAreaPopupsBorderSize
                        }
                    }
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
                        // FIX: Array bounds checking for keyboard layouts
                        layoutButton.label = showLabel ? (keyboard && keyboard.layouts && keyboard.currentLayout >= 0 && keyboard.currentLayout < keyboard.layouts.length ? keyboard.layouts[keyboard.currentLayout].shortName.toUpperCase() : "") : "";
                        // FIX: Array bounds checking for keyboard layouts
                        VirtualKeyboardSettings.locale = Languages.getKBCodeFor(keyboard && keyboard.layouts && keyboard.currentLayout >= 0 && keyboard.currentLayout < keyboard.layouts.length ? keyboard.layouts[keyboard.currentLayout].shortName : "");
                    }
                    onClose: {
                        popup.close();
                    }
                }

                Component.onCompleted: {
                    [x, y] = menuArea.calculatePopupPos(Config.layoutPopupDirection, Config.layoutPopupAlign, popup, layoutButton);
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
            contentColor: Config.keyboardContentColor
            activeContentColor: Config.keyboardActiveContentColor
            active: showKeyboard
            fontFamily: Config.menuAreaButtonsFontFamily
            borderRadius: Config.menuAreaButtonsBorderRadius
            borderSize: Config.keyboardBorderSize
            enabled: loginScreen.showKeyboard || loginScreen.state === "normal"
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
            contentColor: Config.powerContentColor
            activeContentColor: Config.powerActiveContentColor
            fontFamily: Config.menuAreaButtonsFontFamily
            active: popup.visible
            borderRadius: Config.menuAreaButtonsBorderRadius
            borderSize: Config.powerBorderSize
            backgroundColor: Config.powerBackgroundColor
            backgroundOpacity: Config.powerBackgroundOpacity
            activeBackgroundColor: Config.powerBackgroundColor
            activeBackgroundOpacity: Config.powerActiveBackgroundOpacity
            enabled: loginScreen.state === "normal" || popup.visible
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
                    radius: Config.menuAreaButtonsBorderRadius

                    Rectangle {
                        anchors.fill: parent
                        visible: Config.menuAreaPopupsBorderSize > 0
                        radius: parent.radius
                        color: "transparent"
                        border {
                            color: Config.menuAreaPopupsBorderColor
                            width: Config.menuAreaPopupsBorderSize
                        }
                    }
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
                    onClose: {
                        popup.close();
                    }
                }

                Component.onCompleted: {
                    [x, y] = menuArea.calculatePopupPos(Config.powerPopupDirection, Config.powerPopupAlign, popup, powerButton);
                }
            }
        }
    }

    Row {
        // top_left
        id: topLeftButtons

        height: childrenRect.height
        width: childrenRect.width
        spacing: Config.menuAreaButtonsSpacing // 10

        anchors {
            top: parent.top
            left: parent.left
            topMargin: Config.menuAreaButtonsMarginTop
            leftMargin: Config.menuAreaButtonsMarginLeft
        }
    }

    Row {
        // top_center
        id: topCenterButtons

        height: childrenRect.height
        width: childrenRect.width
        spacing: Config.menuAreaButtonsSpacing // 10

        anchors {
            top: parent.top
            horizontalCenter: parent.horizontalCenter
            topMargin: Config.menuAreaButtonsMarginTop
        }
    }

    Row {
        // top_right
        id: topRightButtons

        height: childrenRect.height
        width: childrenRect.width
        spacing: Config.menuAreaButtonsSpacing // 10

        anchors {
            top: parent.top
            right: parent.right
            topMargin: Config.menuAreaButtonsMarginTop
            rightMargin: Config.menuAreaButtonsMarginRight
        }
    }

    Column {
        // center_left
        id: centerLeftButtons

        height: childrenRect.height
        width: childrenRect.width
        spacing: Config.menuAreaButtonsSpacing // 10

        anchors {
            left: parent.left
            verticalCenter: parent.verticalCenter
            leftMargin: Config.menuAreaButtonsMarginLeft
        }
    }

    Column {
        // center_right
        id: centerRightButtons

        height: childrenRect.height
        width: childrenRect.width
        spacing: Config.menuAreaButtonsSpacing // 10

        anchors {
            right: parent.right
            verticalCenter: parent.verticalCenter
            rightMargin: Config.menuAreaButtonsMarginRight
        }
    }

    Row {
        // bottom_left
        id: bottomLeftButtons

        height: childrenRect.height
        width: childrenRect.width
        spacing: Config.menuAreaButtonsSpacing // 10

        anchors {
            bottom: parent.bottom
            left: parent.left
            bottomMargin: Config.menuAreaButtonsMarginBottom
            leftMargin: Config.menuAreaButtonsMarginLeft
        }
    }

    Row {
        // bottom_center
        id: bottomCenterButtons

        height: childrenRect.height
        width: childrenRect.width
        spacing: Config.menuAreaButtonsSpacing // 10

        anchors {
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
            bottomMargin: Config.menuAreaButtonsMarginBottom
        }
    }

    Row {
        // bottom_right
        id: bottomRightButtons

        height: childrenRect.height
        width: childrenRect.width
        spacing: Config.menuAreaButtonsSpacing // 10

        anchors {
            bottom: parent.bottom
            right: parent.right
            bottomMargin: Config.menuAreaButtonsMarginBottom
            rightMargin: Config.menuAreaButtonsMarginRight
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
            else if (menus[i].name === "layout")
                layoutMenuComponent.createObject(pos, {});
            else if (menus[i].name === "keyboard")
                keyboardMenuComponent.createObject(pos, {});
            else if (menus[i].name === "power")
                powerMenuComponent.createObject(pos, {});
        }
    }

    function calculatePopupPos(direction, align, popup, button) {
        const popupMargin = Config.menuAreaPopupsMargin;
        let x = 0, y = 0;

        if (direction === "up") {
            y = -popup.height - popupMargin;
            if (align === "start") {
                x = 0;
            } else if (align === "end") {
                x = -popup.width + button.width;
            } else {
                x = (button.width - popup.width) / 2;
            }
        } else if (direction === "down") {
            y = button.height + popupMargin;
            if (align === "start") {
                x = 0;
            } else if (align === "end") {
                x = -popup.width + button.width;
            } else {
                x = (button.width - popup.width) / 2;
            }
        } else if (direction === "left") {
            x = -popup.width - popupMargin;
            if (align === "start") {
                y = 0;
            } else if (align === "end") {
                y = -popup.height + button.height;
            } else {
                y = (button.height - popup.height) / 2;
            }
        } else {
            x = button.width + popupMargin;
            if (align === "start") {
                y = 0;
            } else if (align === "end") {
                y = -popup.height + button.height;
            } else {
                y = (button.height - popup.height) / 2;
            }
        }
        return [x, y];
    }
}
