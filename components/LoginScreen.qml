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
            loginScreen.state = "normal";
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

    Item {
        id: loginContainer
        width: Config.loginAreaPosition === "left" || Config.loginAreaPosition === "right" ? (Config.avatarActiveSize + Config.usernameMargin + loginArea.width) : userSelector.width
        height: childrenRect.height
        scale: 0.5 // Initial animation

        Behavior on scale {
            enabled: Config.enableAnimations
            NumberAnimation {
                duration: 200
            }
        }

        // LoginArea position
        Component.onCompleted: {
            if (Config.loginAreaPosition === "left") {
                anchors.verticalCenter = parent.verticalCenter;
                if (Config.loginAreaMargin === -1) {
                    anchors.horizontalCenter = parent.horizontalCenter;
                } else {
                    anchors.left = parent.left;
                    anchors.leftMargin = Config.loginAreaMargin;
                }
            } else if (Config.loginAreaPosition === "right") {
                anchors.verticalCenter = parent.verticalCenter;
                if (Config.loginAreaMargin === -1) {
                    anchors.horizontalCenter = parent.horizontalCenter;
                } else {
                    anchors.right = parent.right;
                    anchors.rightMargin = Config.loginAreaMargin;
                }
            } else {
                anchors.horizontalCenter = parent.horizontalCenter;
                if (Config.loginAreaMargin === -1) {
                    anchors.verticalCenter = parent.verticalCenter;
                } else {
                    anchors.top = parent.top;
                    anchors.topMargin = Config.loginAreaMargin;
                }
            }
        }

        UserSelector {
            id: userSelector
            listUsers: loginScreen.state === "selectingUser"
            enabled: loginScreen.state !== "authenticating"
            activeFocusOnTab: true
            orientation: Config.loginAreaPosition === "left" || Config.loginAreaPosition === "right" ? "vertical" : "horizontal"
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

            Component.onCompleted: {
                anchors.top = parent.top;
                if (Config.loginAreaPosition === "left") {
                    anchors.left = parent.left;
                } else if (Config.loginAreaPosition === "right") {
                    anchors.right = parent.right;
                }
            }
        }

        Item {
            id: loginLayout
            height: activeUserName.height + Config.passwordInputMarginTop + loginArea.height
            width: loginArea.width > activeUserName.width ? loginArea.width : activeUserName.width

            // LoginArea alignment
            Component.onCompleted: {
                if (Config.loginAreaPosition === "left") {
                    anchors.verticalCenter = parent.verticalCenter;
                    anchors.left = userSelector.right;
                    anchors.leftMargin = Config.usernameMargin;
                } else if (Config.loginAreaPosition === "right") {
                    anchors.verticalCenter = parent.verticalCenter;
                    anchors.right = userSelector.left;
                    anchors.rightMargin = Config.usernameMargin;
                } else {
                    anchors.top = userSelector.bottom;
                    anchors.topMargin = Config.usernameMargin;
                    anchors.horizontalCenter = parent.horizontalCenter;
                }
            }

            Text {
                id: activeUserName
                font.family: Config.usernameFontFamily
                font.weight: Config.usernameFontWeight
                font.pixelSize: Config.usernameFontSize
                color: Config.usernameColor
                text: loginScreen.userRealName

                Component.onCompleted: {
                    anchors.top = parent.top;
                    if (Config.loginAreaPosition === "left") {
                        anchors.left = parent.left;
                    } else if (Config.loginAreaPosition === "right") {
                        anchors.right = parent.right;
                    } else {
                        anchors.horizontalCenter = parent.horizontalCenter;
                    }
                }
            }

            RowLayout {
                id: loginArea
                height: Config.passwordInputHeight
                spacing: Config.loginButtonMarginLeft

                Component.onCompleted: {
                    anchors.top = activeUserName.bottom;
                    anchors.topMargin = Config.passwordInputMarginTop;
                    if (Config.loginAreaPosition === "left") {
                        anchors.left = parent.left;
                    } else if (Config.loginAreaPosition === "right") {
                        anchors.right = parent.right;
                    } else {
                        anchors.horizontalCenter = parent.horizontalCenter;
                    }
                }

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

                    Behavior on x {
                        enabled: Config.enableAnimations
                        NumberAnimation {
                            duration: 150
                        }
                    }
                }
            }

            Text {
                id: loginMessage
                property bool capslockWarning: false
                font.pixelSize: Config.warningMessageFontSize
                font.family: Config.warningMessageFontFamily
                font.weight: Config.warningMessageFontWeight
                color: Config.warningMessageNormalColor
                visible: text !== "" && (capslockWarning ? loginScreen.userNeedsPassword : true)
                opacity: visible ? 1.0 : 0.0
                anchors.top: loginArea.bottom
                anchors.topMargin: visible ? Config.warningMessageMarginTop : 0

                Component.onCompleted: {
                    if (root.capsLockOn)
                        loginMessage.warn(textConstants.capslockWarning, "warning");

                    if (Config.loginAreaPosition === "left") {
                        anchors.left = parent.left;
                    } else if (Config.loginAreaPosition === "right") {
                        anchors.right = parent.right;
                    } else {
                        anchors.horizontalCenter = parent.horizontalCenter;
                    }
                }

                Behavior on anchors.topMargin {
                    enabled: Config.enableAnimations
                    NumberAnimation {
                        duration: 150
                    }
                }
                Behavior on opacity {
                    enabled: Config.enableAnimations
                    NumberAnimation {
                        duration: 150
                    }
                }

                function warn(message, type) {
                    clear();
                    text = message;
                    color = type === "error" ? Config.warningMessageErrorColor : (type === "warning" ? Config.warningMessageWarningColor : Config.warningMessageNormalColor);
                    if (message === textConstants.capslockWarning)
                        capslockWarning = true;
                }

                function clear() {
                    text = "";
                    capslockWarning = false;
                }
            }
        }
    }

    MenuArea {}
    VirtualKeyboard {}

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
