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
    
    // Lockout properties
    property int failedAttempts: 0
    property int lockoutDuration: 0
    property bool isLockedOut: false

    function login() {
        if (password.text.length > 0 || !userNeedsPassword) {
            // Clear any existing errors
            password.clearError();
            loginMessage.clear();
            
            loginScreen.state = "authenticating";
            sddm.login(userName, password.text, sessionIndex);
        } else if (userNeedsPassword) {
            // Trigger password field error for empty password
            password.triggerError("Password required");
            loginMessage.warn("Please enter your password", "error");
        }
    }
    
    Connections {
        function onLoginSucceeded() {
            loginContainer.scale = 0.0;
            // Reset failed attempts on successful login
            failedAttempts = 0;
        }
        function onLoginFailed() {
            loginScreen.state = "normal";
            failedAttempts++;
            
            // Enhanced error feedback
            password.triggerError("Invalid password");
            
            // Check if lockout should be triggered
            if (failedAttempts >= 3) {
                isLockedOut = true;
                lockoutDuration = 600; // 10 minutes in seconds
                lockoutTimer.start();
                loginMessage.warn("Too many failed attempts. Locked for 10:00", "error");
            } else {
                var attemptText = textConstants.loginFailed + " (" + failedAttempts + "/3)";
                loginMessage.warn(attemptText, "error");
            }
            
            // Clear password after a delay to allow user to see the error
            clearPasswordTimer.start();
        }
        function onInformationMessage(message) {
            loginMessage.warn(message, "error");
        }
        target: sddm
    }
    
    // Timer to clear password after login failure
    Timer {
        id: clearPasswordTimer
        interval: 1500
        onTriggered: {
            password.text = "";
        }
    }
    
    // Lockout countdown timer
    Timer {
        id: lockoutTimer
        interval: 1000 // Update every second
        repeat: true
        onTriggered: {
            lockoutDuration--;
            if (lockoutDuration <= 0) {
                // Lockout expired
                isLockedOut = false;
                failedAttempts = 0;
                stop();
                loginMessage.clear();
            } else {
                // Update countdown display
                var minutes = lockoutDuration > 0 ? Math.floor(lockoutDuration / 60) : 0;
                var seconds = lockoutDuration > 0 ? lockoutDuration % 60 : 0;
                var secondsStr = seconds < 10 ? "0" + seconds : seconds;
                var timeString = minutes + ":" + secondsStr;
                loginMessage.warn("Account locked. Try again in " + timeString, "error");
            }
        }
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

                PasswordInput {
                    id: password
                    Layout.alignment: Qt.AlignHCenter
                    enabled: loginScreen.state !== "selectingUser" && loginScreen.state !== "authenticating" && loginScreen.state === "normal" && !isLockedOut
                    visible: loginScreen.userNeedsPassword
                    onAccepted: {
                        loginScreen.login();
                    }
                    onErrorOccurred: function(message) {
                        // Additional error handling if needed
                        console.log("Password error:", message);
                    }
                }

                IconButton {
                    id: loginButton
                    Layout.alignment: Qt.AlignHCenter
                    Layout.preferredWidth: width // Fix button not resizing when label updates
                    height: password.height
                    visible: !Config.loginButtonHideIfNotNeeded || !loginScreen.userNeedsPassword
                    enabled: loginScreen.state !== "selectingUser" && loginScreen.state !== "authenticating" && !isLockedOut
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
                font.pixelSize: Config.warningMessageFontSize
                font.family: Config.warningMessageFontFamily
                font.weight: Config.warningMessageFontWeight
                color: Config.warningMessageNormalColor
                visible: text !== "" && loginScreen.state !== "authenticating" && (capslockWarning ? loginScreen.userNeedsPassword : true)
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
