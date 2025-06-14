import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import SddmComponents

Item {
    id: loginScreen
    signal close
    signal toggleLayoutPopup

    state: "normal"
    onStateChanged: {
        if (state === "normal") {
            resetFocus();
        }
    }

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

    function login() {
        if (password.text.length > 0 || !userNeedsPassword) {
            loginMessage.visible = false;
            spinner.visible = true;
            loginScreen.state = "authenticating";
            sddm.login(userName, password.text, sessionIndex);
        }
    }
    Connections {
        function onLoginSucceeded() {
            spinner.visible = false;
            loginContainer.scale = 0.0;
        }
        function onLoginFailed() {
            loginScreen.state === "normal";
            spinner.visible = false;
            loginMessage.warn(textConstants.loginFailed, "error");
            password.text = "";
            loginArea.visible = true;
        }
        function onInformationMessage(message) {
            loginMessage.warn(message, "error");
        }
        target: sddm
    }

    function updateCapsLock() {
        if (root.capsLockOn && loginScreen.state !== "authenticating") {
            loginMessage.warn(textConstants.capslockWarning, "warning");
        } else {
            loginMessage.clear();
        }
    }

    function resetFocus() {
        if (loginScreen.userNeedsPassword) {
            password.input.forceActiveFocus();
        } else {
            loginButton.forceActiveFocus();
        }
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
                    Layout.leftMargin = Config.loginAreaMargin !== -1 ? Config.loginAreaMargin : 0;
                    Layout.alignment = Config.loginAreaMargin !== -1 ? Qt.AlignLeft | Qt.AlignVCenter : Qt.AlignCenter;
                } else if (Config.loginAreaPosition === "right") {
                    Layout.rightMargin = Config.loginAreaMargin !== -1 ? Config.loginAreaMargin : 0;
                    Layout.alignment = Config.loginAreaMargin !== -1 ? Qt.AlignRight | Qt.AlignVCenter : Qt.AlignCenter;
                } else {
                    Layout.alignment = Config.loginAreaMargin === -1 ? Qt.AlignCenter : Qt.AlignHCenter | Qt.AlignTop;
                    Layout.topMargin = Config.loginAreaMargin !== -1 ? Config.loginAreaMargin : 0;
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
                    rowSpacing: Config.usernameMargin
                    columnSpacing: Config.usernameMargin

                    Keys.onPressed: event => {
                        if (event.key === Qt.Key_Escape) {
                            if (loginScreen.state === "authenticating") {
                                event.accepted = false;
                                return;
                            }
                            if (Config.lockScreenDisplay) {
                                loginScreen.close();
                            }
                            password.text = "";
                        } else if (event.key === Qt.Key_CapsLock) {
                            root.capsLockOn = !root.capsLockOn;
                        }
                        event.accepted = true;
                    }

                    Item {
                        // Alignment of the login area. left | center | right
                        Layout.alignment: Config.loginAreaAlign === "left" && Config.loginAreaPosition !== "center" ? Qt.AlignLeft | Qt.AlignVCenter : (Config.loginAreaAlign === "right" && Config.loginAreaPosition !== "center" ? Qt.AlignRight | Qt.AlignVCenter : Qt.AlignCenter)
                        Layout.preferredWidth: childrenRect.width
                        Layout.preferredHeight: childrenRect.height

                        UserSelector {
                            id: userSelector
                            listUsers: loginScreen.state === "selectingUser"
                            enabled: loginScreen.state !== "authenticating"
                            activeFocusOnTab: true
                            orientation: loginLayout.loginOrientation === "horizontal" ? "vertical" : "horizontal"
                            width: orientation === "horizontal" ? loginScreen.width - Config.loginAreaMargin * 2 : Config.avatarActiveSize
                            height: orientation === "horizontal" ? Config.avatarActiveSize : loginScreen.height - Config.loginAreaMargin * 2
                            onOpenUserList: {
                                loginScreen.state = "selectingUser";
                            }
                            onCloseUserList: {
                                loginScreen.state = "normal";
                                loginScreen.resetFocus(); // resetFocus with escape even if the selector is not open
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
                        Layout.alignment: Config.loginAreaAlign === "left" && Config.loginAreaPosition !== "center" ? Qt.AlignLeft | Qt.AlignVCenter : (Config.loginAreaAlign === "right" && Config.loginAreaPosition !== "center" ? Qt.AlignRight | Qt.AlignVCenter : Qt.AlignCenter)
                        Layout.preferredWidth: childrenRect.width
                        Layout.preferredHeight: childrenRect.height - loginMessage.implicitHeight
                        Layout.fillHeight: false

                        spacing: Config.passwordInputMarginTop

                        Text {
                            id: activeUserName
                            Layout.alignment: Config.loginAreaAlign === "left" && Config.loginAreaPosition !== "center" ? Qt.AlignLeft : (Config.loginAreaAlign === "right" && Config.loginAreaPosition !== "center" ? Qt.AlignRight : Qt.AlignCenter)

                            font.family: Config.usernameFontFamily
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
                            currentIndex: loginScreen.state === "authenticating" ? 1 : 0

                            RowLayout {
                                id: loginArea
                                spacing: Config.loginButtonMarginLeft
                                Layout.preferredWidth: childrenRect.width
                                Layout.preferredHeight: childrenRect.height
                                Layout.fillWidth: false

                                PasswordInput {
                                    id: password
                                    Layout.alignment: Qt.AlignHCenter
                                    enabled: loginScreen.state !== "selectingUser" && loginScreen.state !== "authenticating" && loginScreen.state === "normal"
                                    visible: loginScreen.userNeedsPassword
                                    onAccepted: {
                                        loginScreen.login();
                                    }
                                }

                                IconButton {
                                    id: loginButton
                                    Layout.alignment: Qt.AlignHCenter
                                    Layout.preferredWidth: width // Fix button not resizing when label updates
                                    height: password.height
                                    visible: !Config.loginButtonHideIfNotNeeded || !loginScreen.userNeedsPassword
                                    enabled: loginScreen.state !== "selectingUser" && loginScreen.state !== "authenticating"
                                    activeFocusOnTab: true
                                    icon: Config.getIcon(Config.loginButtonIcon)
                                    label: textConstants.login.toUpperCase()
                                    showLabel: Config.loginButtonShowTextIfNoPassword && !loginScreen.userNeedsPassword
                                    tooltipText: !Config.tooltipsDisableLoginButton && (!Config.loginButtonShowTextIfNoPassword || loginScreen.userNeedsPassword) ? textConstants.login : ""
                                    iconSize: Config.loginButtonIconSize
                                    fontFamily: Config.loginButtonFontFamily
                                    fontSize: Config.loginButtonFontSize
                                    fontWeight: Config.loginButtonFontWeight
                                    contentColor: Config.loginButtonContentColor
                                    activeContentColor: Config.loginButtonActiveContentColor
                                    backgroundColor: Config.loginButtonBackgroundColor
                                    backgroundOpacity: Config.loginButtonBackgroundOpacity
                                    activeBackgroundColor: Config.loginButtonActiveBackgroundColor
                                    activeBackgroundOpacity: Config.loginButtonActiveBackgroundOpacity
                                    borderSize: Config.loginButtonBorderSize
                                    borderColor: Config.loginButtonBorderColor
                                    borderRadiusLeft: Config.loginButtonBorderRadiusLeft
                                    borderRadiusRight: Config.loginButtonBorderRadiusRight
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
        }
    }

    Text {
        id: loginMessage
        font.pixelSize: Config.warningMessageFontSize
        font.family: Config.warningMessageFontFamily
        font.weight: Config.warningMessageFontWeight
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

    MenuArea {}
    VirtualKeyboard {}

    MouseArea {
        id: closeUserSelectorMouseArea
        z: -1
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            if (loginScreen.state === "selectingUser") {
                loginScreen.state = "normal";
            }
            if (loginScreen.state !== "authenticating") {}
        }
        onWheel: event => {
            if (loginScreen.state === "selectingUser") {
                if (event.angleDelta.y < 0) {
                    userSelector.nextUser();
                } else {
                    userSelector.prevUser();
                }
            }
        }
    }
}
