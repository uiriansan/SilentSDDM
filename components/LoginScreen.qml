import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.VirtualKeyboard
import QtQuick.VirtualKeyboard.Settings
import SddmComponents

Item {
    id: screen
    signal closeRequested

    readonly property alias password: password
    readonly property alias loginButton: loginButton
    readonly property alias loginContainer: loginContainer

    property bool showKeyboard: !Config.virtualKeyboardStartHidden

    // Login info
    property int sessionIndex: sessionModel ? sessionModel.lastIndex : 0
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
            loginArea.visible = false;
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
            isAuthenticating = false;
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

    GridLayout {
        id: loginPositioner
        anchors.fill: parent
        rows: 1
        columns: 1
        rowSpacing: 0
        columnSpacing: 0

        Item {
            Layout.preferredWidth: childrenRect.width
            Layout.preferredHeight: childrenRect.height

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

            GridLayout {
                id: loginContainer
                property string loginOrientation: Config.loginAreaPosition === "left" || Config.loginAreaPosition === "right" ? "horizontal" : "vertical"

                rows: loginOrientation === "vertical" ? 2 : 1
                columns: loginOrientation === "vertical" ? 1 : 2
                layoutDirection: (Config.loginAreaPosition === "left" && Config.loginAreaAlign === "right") || (Config.loginAreaPosition === "right" && Config.loginAreaAlign === "right") ? Qt.RightToLeft : Qt.LeftToRight
                rowSpacing: 10
                columnSpacing: 10
                scale: 0.5 // Initial animation

                Behavior on scale {
                    enabled: Config.enableAnimations
                    NumberAnimation {
                        duration: 200
                    }
                }

                Keys.onEscapePressed: () => {
                    // if (screen.activePopup !== null) {
                    //     screen.activePopup.close();
                    //     screen.activePopup = null;
                    //     password.input.forceActiveFocus();
                    //     return;
                    // }
                    if (screen.isAuthenticating)
                        return;

                    if (screen.isSelectingUser) {
                        screen.isSelectingUser = false;
                        return;
                    }

                    if (Config.lockScreenDisplay)
                        screen.closeRequested();

                    password.text = "";
                }
                Keys.onPressed: event => {
                    // TODO: Move this to the Main
                    if (event.key == Qt.Key_CapsLock && !screen.isAuthenticating) {
                        root.capsLockOn = !root.capsLockOn;
                        // if (root.capsLockOn)
                        //     loginMessage.warn(textConstants.capslockWarning, "warning");
                        // else
                        //     loginMessage.clear();
                    }
                }

                Item {
                    // Alignment of the login area. left | center | right
                    Layout.alignment: Config.loginAreaAlign === "left" && Config.loginAreaPosition !== "center" ? Qt.AlignLeft : (Config.loginAreaAlign === "right" && Config.loginAreaPosition !== "center" ? Qt.AlignRight : Qt.AlignCenter)
                    Layout.preferredWidth: childrenRect.width
                    Layout.preferredHeight: childrenRect.height

                    UserSelector {
                        id: userSelector
                        listUsers: screen.isSelectingUser
                        enabled: !screen.isAuthenticating
                        activeFocusOnTab: true
                        orientation: loginContainer.loginOrientation

                        onOpenUserList: {
                            screen.isSelectingUser = true;
                        }
                        onCloseUserList: {
                            screen.isSelectingUser = false;
                            if (screen.userNeedsPassword)
                                password.input.forceActiveFocus();
                            else
                                loginButton.forceActiveFocus();
                        }
                        onUserChanged: (index, name, realName, icon, needsPassword) => {
                            screen.userIndex = index;
                            screen.userName = name;
                            screen.userRealName = realName;
                            screen.userIcon = icon;
                            screen.userNeedsPassword = needsPassword;
                        }
                        width: orientation === "vertical" ? screen.width - Config.loginScreenPaddingLeft - Config.loginScreenPaddingRight : Config.avatarActiveSize
                        height: orientation === "vertical" ? Config.avatarActiveSize : screen.height - Config.loginScreenPaddingTop - Config.loginScreenPaddingBottom
                    }
                }

                ColumnLayout {
                    // Alignment of the login area. left | center | right
                    Layout.alignment: Config.loginAreaAlign === "left" && Config.loginAreaPosition !== "center" ? Qt.AlignLeft : (Config.loginAreaAlign === "right" && Config.loginAreaPosition !== "center" ? Qt.AlignRight : Qt.AlignCenter)
                    Layout.preferredWidth: childrenRect.width
                    Layout.preferredHeight: childrenRect.height

                    spacing: 10

                    Text {
                        id: activeUserName
                        // User name
                        Layout.alignment: Config.loginAreaAlign === "left" && Config.loginAreaPosition !== "center" ? Qt.AlignLeft : (Config.loginAreaAlign === "right" && Config.loginAreaPosition !== "center" ? Qt.AlignRight : Qt.AlignCenter)
                        // horizontalAlignment: Qt.AlignRight

                        font.weight: Config.usernameFontWeight
                        font.pixelSize: Config.usernameFontSize
                        color: Config.usernameColor
                        text: screen.userRealName
                    }

                    RowLayout {
                        id: loginArea
                        Layout.alignment: Config.loginAreaAlign === "left" && Config.loginAreaPosition !== "center" ? Qt.AlignLeft : (Config.loginAreaAlign === "right" && Config.loginAreaPosition !== "center" ? Qt.AlignRight : Qt.AlignCenter)
                        Layout.preferredWidth: childrenRect.width
                        Layout.preferredHeight: childrenRect.height
                        spacing: 5

                        PasswordInput {
                            id: password
                            Layout.alignment: Qt.AlignHCenter
                            enabled: !screen.isSelectingUser && !screen.isAuthenticating
                            visible: screen.userNeedsPassword
                            focus: enabled && visible
                            onAccepted: {
                                screen.login();
                            }
                        }

                        IconButton {
                            id: loginButton
                            Layout.alignment: Qt.AlignHCenter
                            Layout.preferredWidth: width // Fix button not resizing when label updates
                            height: password.height
                            enabled: !screen.isSelectingUser
                            activeFocusOnTab: true
                            focus: !screen.userNeedsPassword && !screen.isSelectingUser
                            icon: "icons/arrow-right.svg"
                            label: textConstants.login.toUpperCase()
                            showLabel: Config.loginButtonShowTextIfNoPassword && !screen.userNeedsPassword
                            tooltipText: !Config.loginButtonShowTextIfNoPassword || screen.userNeedsPassword ? textConstants.login : ""
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
                                screen.login();
                            }
                        }
                    }
                }
            }
        }
    }

    // FIX: Virtual keyboard not working on the second screen.
    InputPanel {
        // TODO: Keep keyboard visible.
        id: inputPanel
        z: 99
        width: Math.min(screen.width / 2, loginArea.width * 3) * Config.virtualKeyboardScale
        visible: screen.showKeyboard
        externalLanguageSwitchEnabled: true
        onExternalLanguageSwitch: {
            return;
        }
        // TODO: Open lang popup
        // onActiveChanged: {
        //     if (showKeyboard)
        //         showKeyboard = false;
        // }
        Component.onCompleted: {
            VirtualKeyboardSettings.styleName = "tstyle";
            VirtualKeyboardSettings.layout = "symbols";
        }

        property string pos: Config.virtualKeyboardPosition
        anchors {
            top: pos === "top" ? screen.top : undefined
            topMargin: pos === "top" ? Config.loginScreenPaddingTop : undefined
            bottom: pos === "bottom" ? screen.bottom : undefined
            bottomMargin: pos === "bottom" ? Config.loginScreenPaddingBottom : undefined
            left: pos === "left" ? parent.left : undefined
            leftMargin: pos === "left" ? Config.loginScreenPaddingLeft : undefined
            right: pos === "right" ? parent.right : undefined
            rightMargin: pos === "right" ? Config.loginScreenPaddingRight : undefined
            horizontalCenter: pos === "top" || pos === "bottom" ? parent.horizontalCenter : undefined
            verticalCenter: pos === "left" || pos === "right" ? parent.verticalCenter : undefined
        }
    }

    MouseArea {
        id: closeUserSelectorMouseArea
        z: -1
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            if (screen.isSelectingUser) {
                screen.isSelectingUser = false;
            }
            if (!screen.isAuthenticating) {
                password.input.forceActiveFocus();
            }
        }
    }
}
