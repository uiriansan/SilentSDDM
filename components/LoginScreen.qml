import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import SddmComponents

Item {
    id: loginScreen
    signal close
    signal toggleLayoutPopup

    state: "normal"
    property bool stateChanging: false
    function safeStateChange(newState) { // This is probably overkill, but whatever
        if (!stateChanging) {
            stateChanging = true;
            state = newState;
            stateChanging = false;
        }
    }
    onStateChanged: {
        if (state === "normal") {
            resetFocus();
        }
    }

    readonly property alias password: password
    readonly property alias loginButton: loginButton
    readonly property alias loginContainer: loginContainer

    property bool showKeyboard: !Config.virtualKeyboardStartHidden

    property bool foundUsers: userModel.count > 0

    // Login info
    property int sessionIndex: 0
    property int userIndex: 0
    property string userName: ""
    property string userRealName: ""
    property string userIcon: ""
    property bool userNeedsPassword: true

    function login() {
        var user = foundUsers ? userName : userInput.text;
        if (user && user !== "") {
            safeStateChange("authenticating");
            sddm.login(user, password.text, sessionIndex);
        } else {
            loginMessage.warn(textConstants.promptUser || "Enter your user!", "error");
        }
    }
    Connections {
        function onLoginSucceeded() {
            loginContainer.scale = 0.0;
        }
        function onLoginFailed() {
            safeStateChange("normal");
            loginMessage.warn(textConstants.loginFailed || "Login failed", "error");
            password.text = "";
        }
        function onInformationMessage(message) {
            loginMessage.warn(message, "error");
        }
        target: sddm
    }

    // FIX: Critical connections memory leak prevention?
    Component.onDestruction: {
        if (typeof connections !== 'undefined') {
            connections.target = null;
        }
    }

    function updateCapsLock() {
        if (root.capsLockOn && loginScreen.state !== "authenticating") {
            loginMessage.warn(textConstants.capslockWarning || "Caps Lock is on", "warning");
        } else {
            loginMessage.clear();
        }
    }

    function resetFocus() {
        if (!loginScreen.foundUsers) {
            userInput.input.forceActiveFocus();
        } else {
            if (loginScreen.userNeedsPassword) {
                password.input.forceActiveFocus();
            } else {
                loginButton.forceActiveFocus();
            }
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

            if (!loginScreen.foundUsers) {
                userSelector.visible = false;
                noUsersLoginArea.visible = true;
            }
        }

        Item {
            id: noUsersLoginArea
            width: Config.passwordInputWidth * Config.generalScale + (loginButton.visible ? Config.passwordInputHeight * Config.generalScale + Config.loginButtonMarginLeft : 0)
            height: childrenRect.height
            visible: false

            Text {
                id: noUsersMessage
                anchors {
                    top: parent.top
                }
                width: parent.width
                text: "SDDM could not find any user. Type your username below:"
                wrapMode: Text.Wrap
                horizontalAlignment: {
                    if (Config.loginAreaPosition === "left") {
                        horizontalAlignment: Text.AlignLeft;
                    } else if (Config.loginAreaPosition === "right") {
                        horizontalAlignment: Text.AlignRight;
                    } else {
                        horizontalAlignment: Text.AlignHCenter;
                    }
                }
                color: Config.warningMessageErrorColor
                font.pixelSize: Math.max(8, Config.passwordInputFontSize * Config.generalScale)
                font.family: Config.passwordInputFontFamily
            }

            Input {
                id: userInput
                anchors {
                    top: noUsersMessage.bottom
                    topMargin: Config.usernameMargin
                }
                width: parent.width
                icon: Config.getIcon("user-default")
                placeholder: (textConstants && textConstants.userName) ? textConstants.userName : "Password"
                isPassword: false
                splitBorderRadius: false
                enabled: loginScreen.state !== "authenticating"
                onAccepted: {
                    loginScreen.login();
                }
            }

            Component.onCompleted: {
                anchors.bottom = loginLayout.top;
                if (Config.loginAreaPosition === "left") {
                    anchors.left = parent.left;
                } else if (Config.loginAreaPosition === "right") {
                    anchors.right = parent.right;
                } else {
                    anchors.horizontalCenter = parent.horizontalCenter;
                }
            }
        }

        UserSelector {
            id: userSelector
            listUsers: loginScreen.state === "selectingUser"
            enabled: loginScreen.state !== "authenticating"
            visible: true
            activeFocusOnTab: true
            orientation: Config.loginAreaPosition === "left" || Config.loginAreaPosition === "right" ? "vertical" : "horizontal"
            width: orientation === "horizontal" ? loginScreen.width - Config.loginAreaMargin * 2 : (Config.avatarActiveSize * Config.generalScale)
            height: orientation === "horizontal" ? (Config.avatarActiveSize * Config.generalScale) : loginScreen.height - Config.loginAreaMargin * 2
            onOpenUserList: {
                safeStateChange("selectingUser");
            }
            onCloseUserList: {
                safeStateChange("normal");
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
                    if (userSelector.visible) {
                        anchors.left = userSelector.right;
                        anchors.leftMargin = Config.usernameMargin;
                    } else {
                        anchors.left = parent.left;
                    }
                } else if (Config.loginAreaPosition === "right") {
                    anchors.verticalCenter = parent.verticalCenter;
                    if (userSelector.visible) {
                        anchors.right = userSelector.left;
                        anchors.rightMargin = Config.usernameMargin;
                    } else {
                        anchors.right = parent.right;
                    }
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
                font.pixelSize: Config.usernameFontSize * Config.generalScale
                color: Config.usernameColor
                text: loginScreen.userRealName || loginScreen.userName || ""
                visible: loginScreen.foundUsers

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
                height: Config.passwordInputHeight * Config.generalScale
                spacing: Config.loginButtonMarginLeft
                visible: loginScreen.state !== "authenticating"

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

                Input {
                    id: password
                    Layout.alignment: Qt.AlignHCenter
                    enabled: loginScreen.state === "normal"
                    visible: loginScreen.userNeedsPassword || !loginScreen.foundUsers
                    icon: Config.getIcon(Config.passwordInputIcon)
                    placeholder: (textConstants && textConstants.password) ? textConstants.password : "Password"
                    isPassword: true
                    splitBorderRadius: true
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
                    label: textConstants.login ? textConstants.login.toUpperCase() : "LOGIN"
                    showLabel: Config.loginButtonShowTextIfNoPassword && !loginScreen.userNeedsPassword
                    tooltipText: !Config.tooltipsDisableLoginButton && (!Config.loginButtonShowTextIfNoPassword || loginScreen.userNeedsPassword) ? (textConstants.login || "Login") : ""
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
                    borderRadiusLeft: password.visible ? Config.loginButtonBorderRadiusLeft : Config.loginButtonBorderRadiusRight
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

            Spinner {
                id: spinner
                visible: loginScreen.state === "authenticating"
                opacity: visible ? 1.0 : 0.0

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
            }

            Text {
                id: loginMessage
                property bool capslockWarning: false
                font.pixelSize: Config.warningMessageFontSize * Config.generalScale
                font.family: Config.warningMessageFontFamily
                font.weight: Config.warningMessageFontWeight
                color: Config.warningMessageNormalColor
                visible: text !== "" && loginScreen.state !== "authenticating" && (capslockWarning ? loginScreen.userNeedsPassword : true)
                opacity: visible ? 1.0 : 0.0
                anchors.top: loginArea.bottom
                anchors.topMargin: visible ? Config.warningMessageMarginTop : 0

                Component.onCompleted: {
                    if (root.capsLockOn)
                        loginMessage.warn(textConstants.capslockWarning || "Caps Lock is on", "warning");

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
                    if (message === (textConstants.capslockWarning || "Caps Lock is on"))
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

    Keys.onPressed: function (event) {
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
                safeStateChange("normal");
            }
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
