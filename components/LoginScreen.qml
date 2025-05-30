import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.VirtualKeyboard
import QtQuick.VirtualKeyboard.Settings
import SddmComponents

Item {
    id: screen
    signal closeRequested

    // readonly property alias password: passwdInput
    // readonly property alias loginButton: loginButton
    // readonly property alias loginArea: loginArea

    property bool showKeyboard: !Config.virtualKeyboardStartHidden

    // Login info
    property int sessionIndex: sessionModel ? sessionModel.lastIndex : 0
    property int userIndex: userList.currentIndex
    property string userName: userList.currentItem.name
    property string userIcon: userList.currentItem.iconPath
    property bool userNeedsPassword: false
    property bool isAuthenticating: false

    function login() {
    // if (passwdInput.text.length > 0 || !userNeedsPassword) {
    //     spinner.visible = true;
    //     loginArea.visible = false;
    //     isAuthenticating = true;
    //     sddm.login(userName, password.text, sessionIndex);
    // }
    }
    Connections {
        function onLoginSucceeded() {
        // spinner.visible = false;
        // loginContainer.scale = 0.0;
        }
        function onLoginFailed() {
        // isAuthenticating = false;
        // spinner.visible = false;
        // loginMessage.warn(textConstants.loginFailed, "error");
        // password.text = "";
        // password.input.forceActiveFocus();
        // loginArea.visible = true;
        }
        function onInformationMessage(message) {
        // loginMessage.warn(message, "error");
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
            property string loginPos: Config.loginAreaPosition
            property bool loginAlignVCenter: Config.loginAreaCenterVertically

            Layout.bottomMargin: Config.menuAreaMarginBottom
            Layout.preferredWidth: childrenRect.width
            Layout.preferredHeight: childrenRect.height

            // Position of the login area. left | center | right
            // There's probably a better way
            Component.onCompleted: {
                if (loginPos === "left") {
                    if (loginAlignVCenter) {
                        Layout.alignment = Qt.AlignLeft | Qt.AlignVCenter;
                    } else {
                        Layout.alignment = Qt.AlignLeft | Qt.AlignTop;
                        Layout.topMargin = Config.loginAreaMarginTop;
                    }
                    Layout.leftMargin = Config.menuAreaMarginLeft;
                } else if (loginPos === "right") {
                    if (loginAlignVCenter) {
                        Layout.alignment = Qt.AlignRight | Qt.AlignVCenter;
                    } else {
                        Layout.alignment = Qt.AlignRight | Qt.AlignTop;
                        Layout.topMargin = Config.loginAreaMarginTop;
                    }
                    Layout.rightMargin = Config.menuAreaMarginRight;
                } else {
                    if (loginAlignVCenter) {
                        Layout.alignment = Qt.AlignHCenter | Qt.AlignVCenter;
                    } else {
                        Layout.alignment = Qt.AlignHCenter | Qt.AlignTop;
                        Layout.topMargin = Config.loginAreaMarginTop;
                    }
                }
            }

            // TODO: Implement login area orientation with a vertical user selector and the username/password input to the right.
            // Use Flow layout or something idk
            GridLayout {
                id: loginContainer
                property string loginAlign: Config.loginAreaAlign
                property string loginOrientation: Config.loginAreaOrientation

                rows: 1
                columns: 3
                layoutDirection: loginOrientation === "vertical" && loginAlign === "right" ? Qt.RightToLeft : Qt.LeftToRight
                rowSpacing: 10
                columnSpacing: 10

                Item {
                    // Alignment of the login area. left | center | right
                    Layout.alignment: parent.loginAlign === "left" ? Qt.AlignLeft : (parent.logingAlign === "right" ? Qt.AlignRight : Qt.AlignCenter)
                    Layout.preferredWidth: childrenRect.width
                    Layout.preferredHeight: childrenRect.height

                    Rectangle {
                        // User selector
                        width: 100
                        height: 100
                        color: "blue"
                    }
                }

                ColumnLayout {
                    // Alignment of the login area. left | center | right
                    Layout.alignment: parent.loginAlign === "left" ? Qt.AlignLeft : (parent.loginAlign === "right" ? Qt.AlignRight : Qt.AlignCenter)
                    Layout.preferredWidth: childrenRect.width
                    Layout.preferredHeight: childrenRect.height

                    spacing: 10

                    Text {
                        // User name
                        Layout.alignment: parent.parent.loginAlign === "left" ? Qt.AlignLeft : (parent.parent.loginAlign === "right" ? Qt.AlignRight : Qt.AlignCenter)
                        // horizontalAlignment: Qt.AlignRight
                        text: "Willian Santos"
                    }

                    Row {
                        id: loginArea
                        Layout.alignment: parent.parent.loginAlign === "left" ? Qt.AlignLeft : (parent.parent.loginAlign === "right" ? Qt.AlignRight : Qt.AlignCenter)
                        Layout.preferredWidth: childrenRect.width
                        Layout.preferredHeight: childrenRect.height

                        Rectangle {
                            // Login input
                            width: 100
                            height: 100
                            color: "red"
                        }
                    }
                }
            }
        }
    }
}
