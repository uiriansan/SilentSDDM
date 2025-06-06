import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.VirtualKeyboard
import QtQuick.VirtualKeyboard.Settings
import SddmComponents

Item {
    id: loginScreen
    signal closeRequested
    signal toggleLayoutPopup

    state: "normal"
    states: [
        State {
            name: "normal"
            PropertyChanges {
                target: password.input
                focus: true
            }
        },
        State {
            name: "popup"
        },
        State {
            name: "user"
        }
    ]

    readonly property alias password: password
    readonly property alias loginButton: loginButton
    readonly property alias loginContainer: loginContainer

    property bool showKeyboard: !Config.virtualKeyboardStartHidden

    // Login info
    property int sessionIndex: 0
    property int userIndex: 0
    property string userName: ""
    property string userRealName: ""
    property string userIcon: ""
    property bool userNeedsPassword: false
    property bool isAuthenticating: false
    property bool isSelectingUser: false

    function login() {
        if (password.text.length > 0 || !userNeedsPassword) {
            spinner.visible = true;
            isAuthenticating = true;
            sddm.login(userName, password.text, sessionIndex);
        }
    }
    Connections {
        function onLoginSucceeded() {
            spinner.visible = false;
            loginContainer.scale = 0.0;
        }
        function onLoginFailed() {
            loginScreen.isAuthenticating = false;
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

    function updateCapsLock() {
        if (root.capsLockOn && !loginScreen.isAuthenticating) {
            loginMessage.warn(textConstants.capslockWarning, "warning");
        } else {
            loginMessage.clear();
        }
    }

    function resetFocus() {
        // TODO: ...
        if (userNeedsPassword) {
            password.input.forceActiveFocus();
        } else {
            loginButton.focus = true;
        }
        return;
    }

    GridLayout {
        id: loginPositioner
        anchors.fill: parent
        rows: 1
        columns: 1
        rowSpacing: 0
        columnSpacing: 0

        Item {
            id: loginContainerContainer
            Layout.preferredWidth: loginLayout.width
            Layout.preferredHeight: loginLayout.height

            // Position of the login area. left | center | right
            // There's probably a better way...
            Component.onCompleted: {
                if (Config.loginAreaPosition === "left") {
                    Layout.leftMargin = Config.loginScreenPaddingLeft;
                    Layout.alignment = Qt.AlignLeft | Qt.AlignVCenter;
                } else if (Config.loginAreaPosition === "right") {
                    Layout.rightMargin = Config.loginScreenPaddingRight;
                    Layout.alignment = Qt.AlignRight | Qt.AlignVCenter;
                } else {
                    Layout.alignment = Qt.AlignHCenter | Qt.AlignVCenter;
                }
            }

            Item {
                id: loginContainer
                width: childrenRect.width
                height: childrenRect.height
                scale: 0.5 // Initial animation

                Behavior on scale {
                    enabled: Config.enableAnimations
                    NumberAnimation {
                        duration: 200
                    }
                }

                GridLayout {
                    id: loginLayout
                    property string loginOrientation: Config.loginAreaPosition === "left" || Config.loginAreaPosition === "right" ? "horizontal" : "vertical"

                    rows: loginOrientation === "vertical" ? 2 : 1
                    columns: loginOrientation === "vertical" ? 1 : 2
                    layoutDirection: (Config.loginAreaPosition === "left" && Config.loginAreaAlign === "right") || (Config.loginAreaPosition === "right" && Config.loginAreaAlign === "right") ? Qt.RightToLeft : Qt.LeftToRight
                    rowSpacing: 10
                    columnSpacing: 10

                    Keys.onPressed: event => {
                        if (event.key === Qt.Key_Escape) {
                            if (loginScreen.isAuthenticating) {
                                event.accepted = false;
                                return;
                            }
                            if (Config.lockScreenDisplay) {
                                loginScreen.closeRequested();
                            }
                            password.text = "";
                        } else if (event.key === Qt.Key_CapsLock) {
                            root.capsLockOn = !root.capsLockOn;
                        }
                        event.accepted = true;
                    }

                    Item {
                        // Alignment of the login area. left | center | right
                        Layout.alignment: Config.loginAreaAlign === "left" && Config.loginAreaPosition !== "center" ? Qt.AlignLeft : (Config.loginAreaAlign === "right" && Config.loginAreaPosition !== "center" ? Qt.AlignRight : Qt.AlignCenter)
                        Layout.preferredWidth: childrenRect.width
                        Layout.preferredHeight: childrenRect.height

                        UserSelector {
                            id: userSelector
                            listUsers: loginScreen.isSelectingUser
                            enabled: !loginScreen.isAuthenticating
                            activeFocusOnTab: true
                            layoutOrientation: loginLayout.loginOrientation
                            width: layoutOrientation === "vertical" ? loginScreen.width - Config.loginScreenPaddingLeft - Config.loginScreenPaddingRight : Config.avatarActiveSize
                            height: layoutOrientation === "vertical" ? Config.avatarActiveSize : loginScreen.height - Config.loginScreenPaddingTop - Config.loginScreenPaddingBottom
                            onFocusChanged: {
                                if (!focus && loginScreen.isSelectingUser) {
                                    loginScreen.isSelectingUser = false;
                                    password.input.forceActiveFocus();
                                }
                            }

                            onOpenUserList: {
                                loginScreen.isSelectingUser = true;
                            }
                            onCloseUserList: {
                                loginScreen.isSelectingUser = false;
                                if (loginScreen.userNeedsPassword)
                                    password.input.forceActiveFocus();
                                else
                                    loginButton.forceActiveFocus();
                            }
                            onUserChanged: (index, name, realName, icon, needsPassword) => {
                                loginScreen.userIndex = index;
                                loginScreen.userName = name;
                                loginScreen.userRealName = realName;
                                loginScreen.userIcon = icon;
                                loginScreen.userNeedsPassword = needsPassword;
                            }
                        }
                    }

                    ColumnLayout {
                        // Alignment of the login area. left | center | right
                        Layout.alignment: Config.loginAreaAlign === "left" && Config.loginAreaPosition !== "center" ? Qt.AlignLeft : (Config.loginAreaAlign === "right" && Config.loginAreaPosition !== "center" ? Qt.AlignRight : Qt.AlignCenter)
                        // Layout.preferredWidth: childrenRect.width
                        // Layout.preferredHeight: childrenRect.height

                        spacing: 10

                        Text {
                            id: activeUserName
                            // User name
                            Layout.alignment: Config.loginAreaAlign === "left" && Config.loginAreaPosition !== "center" ? Qt.AlignLeft : (Config.loginAreaAlign === "right" && Config.loginAreaPosition !== "center" ? Qt.AlignRight : Qt.AlignCenter)
                            // horizontalAlignment: Qt.AlignRight

                            font.weight: Config.usernameFontWeight
                            font.pixelSize: Config.usernameFontSize
                            color: Config.usernameColor
                            text: loginScreen.userRealName
                        }

                        StackLayout {
                            id: loginAreaStack
                            Layout.alignment: Config.loginAreaAlign === "left" && Config.loginAreaPosition !== "center" ? Qt.AlignLeft : (Config.loginAreaAlign === "right" && Config.loginAreaPosition !== "center" ? Qt.AlignRight : Qt.AlignCenter)
                            Layout.preferredWidth: loginArea.width
                            Layout.preferredHeight: loginArea.height
                            Layout.fillWidth: false
                            currentIndex: loginScreen.isAuthenticating ? 1 : 0

                            RowLayout {
                                id: loginArea
                                spacing: 5
                                Layout.preferredWidth: childrenRect.width
                                Layout.preferredHeight: childrenRect.height
                                Layout.fillWidth: false

                                PasswordInput {
                                    id: password
                                    Layout.alignment: Qt.AlignHCenter
                                    enabled: !loginScreen.isSelectingUser && !loginScreen.isAuthenticating && loginScreen.state === "normal"
                                    visible: loginScreen.userNeedsPassword
                                    focus: enabled && visible
                                    onAccepted: {
                                        loginScreen.login();
                                    }
                                }

                                IconButton {
                                    id: loginButton
                                    Layout.alignment: Qt.AlignHCenter
                                    Layout.preferredWidth: width // Fix button not resizing when label updates
                                    height: password.height
                                    enabled: !loginScreen.isSelectingUser && !loginScreen.isAuthenticating
                                    activeFocusOnTab: true
                                    focus: !loginScreen.userNeedsPassword && !loginScreen.isSelectingUser
                                    icon: "icons/arrow-right.svg"
                                    label: textConstants.login.toUpperCase()
                                    showLabel: Config.loginButtonShowTextIfNoPassword && !loginScreen.userNeedsPassword
                                    tooltipText: !Config.loginButtonShowTextIfNoPassword || loginScreen.userNeedsPassword ? textConstants.login : ""
                                    boldLabel: true
                                    iconSize: Config.loginButtonIconSize
                                    fontSize: Config.loginButtonFontSize
                                    iconColor: Config.loginButtonContentColor
                                    activeIconColor: Config.loginButtonActiveContentColor
                                    backgroundColor: Config.loginButtonBackgroundColor
                                    backgroundOpacity: Config.loginButtonBackgroundOpacity
                                    activeBackgroundColor: Config.loginButtonActiveBackgroundColor
                                    activeBackgroundOpacity: Config.loginButtonActiveBackgroundOpacity
                                    onClicked: {
                                        loginScreen.login();
                                    }
                                }
                            }

                            Rectangle {
                                Layout.preferredWidth: parent.width
                                Layout.preferredHeight: parent.height
                                color: "transparent"

                                Spinner {
                                    id: spinner
                                    anchors.centerIn: parent
                                }
                            }
                        }
                    }
                }
            }

            Text {
                id: loginMessage
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    top: loginContainer.bottom
                    topMargin: 20
                }
                font.pixelSize: Config.warningMessageFontSize
                font.family: Config.fontFamily
                font.bold: Config.warningMessageBold
                color: Config.warningMessageNormalColor
                visible: false
                opacity: visible ? 1.0 : 0.0
                Component.onCompleted: {
                    if (root.capsLockOn)
                        loginMessage.warn(textConstants.capslockWarning, "warning");
                }

                Behavior on opacity {
                    enabled: Config.enableAnimations
                    NumberAnimation {
                        duration: 150
                    }
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
    }

    Item {
        id: menuArea
        anchors.fill: parent

        function calculatePopupPos(dir, popup_w, popup_h, parent_w, parent_h, parent_x, parent_y) {
            let x = 0, y = 0;
            const popup_margin = 5;

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
                property bool showLabel: Config.sessionButtonDisplaySessionName
                width: showLabel ? Config.sessionButonMaxWidth : Config.menuAreaButtonsSize
                height: Config.menuAreaButtonsSize
                iconSize: Config.sessionButtonIconSize
                fontSize: Config.sessionButtonFontSize
                enabled: !loginScreen.isSelectingUser && !loginScreen.isAuthenticating
                active: popup.visible
                iconColor: Config.sessionButtonContentColor
                activeIconColor: Config.sessionButtonActiveContentColor
                borderRadius: Config.menuAreaButtonsBorderRadius
                backgroundColor: Config.sessionButtonBackgroundColor
                backgroundOpacity: Config.sessionButtonBackgroundOpacity
                activeBackgroundColor: Config.sessionButtonBackgroundColor
                activeBackgroundOpacity: Config.sessionButtonActiveBackgroundOpacity
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
                    property int popupMargin: 5
                    parent: sessionButton
                    padding: 5
                    rightPadding: 0 // For the scrollbar
                    background: Rectangle {
                        color: Config.menuAreaPopupBackgroundColor
                        opacity: Config.menuAreaPopupBackgroundOpacity
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

                property bool showLabel: Config.languageButtonDisplayLanguageName

                height: Config.menuAreaButtonsSize
                icon: "icons/language.svg"
                active: popup.visible
                borderRadius: Config.menuAreaButtonsBorderRadius
                iconSize: Config.languageButtonIconSize
                fontSize: Config.languageButtonFontSize
                backgroundColor: Config.languageButtonBackgroundColor
                backgroundOpacity: Config.languageButtonBackgroundOpacity
                activeBackgroundColor: Config.languageButtonBackgroundColor
                activeBackgroundOpacity: Config.languageButtonActiveBackgroundOpacity
                iconColor: Config.languageButtonContentColor
                activeIconColor: Config.languageButtonActiveContentColor
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
                    property int popupMargin: 5
                    parent: languageButton
                    padding: 5
                    background: Rectangle {
                        color: Config.menuAreaPopupBackgroundColor
                        opacity: Config.menuAreaPopupBackgroundOpacity
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
                        [x, y] = menuArea.calculatePopupPos(Config.languagePopupDirection, width, height, parent.width, parent.height, parent.parent.x, parent.parent.y);
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
                activeBackgroundColor: Config.keyboardButtonBackgroundColor
                activeBackgroundOpacity: Config.keyboardButtonActiveBackgroundOpacity
                iconColor: Config.keyboardButtonContentColor
                activeIconColor: Config.keyboardButtonActiveContentColor
                active: showKeyboard
                borderRadius: Config.menuAreaButtonsBorderRadius
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
                icon: "icons/power.svg"
                iconSize: Config.powerButtonIconSize
                iconColor: Config.powerButtonContentColor
                activeIconColor: Config.powerButtonActiveContentColor
                active: popup.visible
                borderRadius: Config.menuAreaButtonsBorderRadius
                backgroundColor: Config.powerButtonBackgroundColor
                backgroundOpacity: Config.powerButtonBackgroundOpacity
                activeBackgroundColor: Config.powerButtonBackgroundColor
                activeBackgroundOpacity: Config.powerButtonActiveBackgroundOpacity
                enabled: !loginScreen.isSelectingUser && !loginScreen.isAuthenticating
                activeFocusOnTab: true
                focus: false
                onClicked: {
                    popup.open();
                }
                tooltipText: "Power options"

                Popup {
                    id: popup
                    property int popupMargin: 5
                    parent: powerButton
                    background: Rectangle {
                        color: Config.menuAreaPopupBackgroundColor
                        opacity: Config.menuAreaPopupBackgroundOpacity
                        radius: 5
                    }
                    dim: true
                    padding: 5
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
            spacing: Config.menuAreaSpacing // 10

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
            spacing: Config.menuAreaSpacing // 10

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
            spacing: Config.menuAreaSpacing // 10

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
            spacing: Config.menuAreaSpacing // 10

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
            spacing: Config.menuAreaSpacing // 10

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
            spacing: Config.menuAreaSpacing // 10

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
            spacing: Config.menuAreaSpacing // 10

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
            spacing: Config.menuAreaSpacing // 10

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

    // FIX: Virtual keyboard not working on the second loginScreen.
    InputPanel {
        // TODO: Keep keyboard visible.
        id: inputPanel
        // z: 99
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
                return Config.loginScreenPaddingLeft;
            else
                return parent.width - inputPanel.width - Config.loginScreenPaddingRight;
        }
        y: {
            if (pos === "top")
                return Config.loginScreenPaddingTop;
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

    MouseArea {
        id: closeUserSelectorMouseArea
        z: -1
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            if (loginScreen.isSelectingUser) {
                loginScreen.isSelectingUser = false;
            }
            if (!loginScreen.isAuthenticating) {
                password.input.forceActiveFocus();
            }
        }
        onWheel: event => {
            if (loginScreen.isSelectingUser) {
                if (event.angleDelta.y < 0) {
                    userSelector.nextUser();
                } else {
                    userSelector.prevUser();
                }
            }
        }
    }
}
