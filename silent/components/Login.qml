import QtQuick 2.5
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0
import SddmComponents 2.0

import "."

Item {
    id: frame
    signal needClose
    property int sessionIndex: sessionModel.lastIndex
    property string userIndex: userList.currentIndex
    property string userName: userModel.lastUser
    property string userIcon: userList.currentItem.iconPath
    property alias input: passwdInput
    property alias button: loginButton

    property bool isAuthorizing: false

    function onLoginSucceeded() {
        spinner.visible = false;
        Qt.quit();
    }

    function onLoginFailed() {
        isAuthorizing = false;
        spinner.visible = false;
        loginMessage.warn(textConstants.loginFailed, "error");
        passwdInput.text = "";
        passwdInput.focus = true;
        loginArea.visible = true;
    }

    //Connections {
    //    target: sddm
    //    onLoginSucceeded: {
    //        Qt.quit()
    //    }
    //    onLoginFailed: {
    //        passwdInput.echoMode = TextInput.Normal
    //        passwdInput.text = textConstants.loginFailed
    //        passwdInput.focus = false
    //        passwdInput.color = "#e7b222"
    //    }
    //}

    Item {
        id: loginItem
        anchors.centerIn: parent
        width: parent.width
        height: parent.height

        User {
            id: userListContainer
            width: parent.width
            height: config.selectedAvatarSize || 120
            anchors {
                top: parent.top
                topMargin: parent.height / 3
                horizontalCenter: parent.horizontalCenter
            }
        }

        Text {
            id: userNameText
            anchors {
                top: userListContainer.bottom
                topMargin: 10
                horizontalCenter: parent.horizontalCenter
            }

            text: userName
            font.bold: true
            font.family: config.font || "RedHatDisplay"
            color: textColor
            font.pointSize: 15
        }

        Spinner {
            id: spinner
            anchors.top: userNameText.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            visible: false
        }

        Item {
            id: loginArea
            width: childrenRect.width
            anchors.top: userNameText.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.topMargin: 20

            TextField {
                id: passwdInput
                width: 200
                height: 30
                anchors.left: parent.left
                echoMode: TextInput.Password
                focus: false
                placeholderText: qsTr("Password")
                placeholderTextColor: "#fff"
                palette.text: "#fff"
                font.family: config.font || "RedHatDisplay"
                font.pointSize: 8
                font.italic: true
                background: Rectangle {
                    color: "#fff"
                    opacity: 0.15
                    radius: 10
                    width: parent.width
                    height: parent.height
                    anchors.centerIn: parent
                }
                selectByMouse: true
                onAccepted: {
                    spinner.visible = true;
                    loginArea.visible = false;
                    isAuthorizing = true;
                    sddm.login(userName, passwdInput.text, sessionIndex);
                }
            }
            IconButton {
                id: loginButton
                height: passwdInput.height
                width: height
                anchors.left: (passwdInput.right)
                anchors.leftMargin: 5
                icon: "icons/arrow-right.svg"
                onClicked: {
                    spinner.visible = true;
                    loginArea.visible = false;
                    isAuthorizing = true;
                    sddm.login(userName, passwdInput.text, sessionIndex);
                }
            }

            // ImgButton {
            // 	id: loginButton
            // 	height: passwdInput.height
            // 	width: height
            // 	anchors.left: (passwdInput.right)
            // 	anchors.leftMargin: 5
            // 	normalImg: Icons.arrowRight
            // 	//normalImg: "icons/login_normal.png"
            // 	//hoverImg: "icons/login_normal.png"
            // 	//pressImg: "icons/login_press.png"
            // 	onClicked: {

            // 		console.log(keyboard.capsLock)
            // 	}
            // 	//KeyNavigation.tab: shutdownButton
            // 	//KeyNavigation.backtab: passwdInput
            // }
        }

        Text {
            id: loginMessage
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: loginArea.bottom
                topMargin: 50
            }
            font.pointSize: 9
            font.family: config.font || "RedHatDisplay"
            color: textColor
            enabled: false

            function warn(message, type) {
                text = message;
                enabled = true;
            }
            function clear() {
                enabled = false;
                text = "";
            }

            Component.onCompleted: {
                if (keyboard.capsLock)
                    loginMessage.warn("CapsLock on", "warning");
            }
        }

        Session {
            id: sessionButton
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.bottomMargin: 50
            anchors.leftMargin: 50
        }

        Item {
            id: rightButtons
            height: childrenRect.height
            anchors {
                bottom: parent.bottom
                right: parent.right
                bottomMargin: 50
                rightMargin: 50
            }

            IconButton {
                id: languageButton
                height: 30
                width: 30
                anchors.right: keyboardButton.left
                anchors.rightMargin: 10
                icon: "icons/language.svg"
                icon_size: 15
                onClicked: {}
            }

            IconButton {
                id: keyboardButton
                height: 30
                width: 30
                anchors.right: powerButton.left
                anchors.rightMargin: 10
                icon: "icons/keyboard.svg"
                icon_size: 15
                onClicked: {}
            }

            IconButton {
                id: powerButton
                height: 30
                width: 30
                anchors.right: parent.right
                icon: "icons/power.svg"
                icon_size: 15
                onClicked: {}
            }
        }

        //     Rectangle {
        //         id: passwdInputRec
        //         visible: ! isProcessing
        //         anchors {
        //             top: userNameText.bottom
        //             topMargin: 10
        //             horizontalCenter: parent.horizontalCenter
        //         }
        //         width: 250
        //         height: 35
        //         radius: 8
        //color: "#fff"
        //opacity: 0.1
        //
        //         TextInput {
        //             id: passwdInput
        //             anchors.fill: parent
        //             anchors.leftMargin: 8
        //             anchors.rightMargin: 8 + 36
        //             clip: true
        //             focus: false
        //             color: textColor
        //             font.pointSize: 12
        //	selectByMouse: true
        //             selectionColor: "#a8d6ec"
        //             echoMode: TextInput.Password
        //             verticalAlignment: TextInput.AlignVCenter
        //             onFocusChanged: {
        //                 if (focus) {
        //                     color = textColor
        //                     echoMode = TextInput.Password
        //                     text = ""
        //                 }
        //             }
        //             onAccepted: {
        //                 sddm.login(userNameText.text, passwdInput.text, sessionIndex)
        //             }
        //             KeyNavigation.backtab: {
        //                 if (sessionButton.visible) {
        //                     return sessionButton
        //                 }
        //                 else if (userButton.visible) {
        //                     return userButton
        //                 }
        //                 else {
        //                     return shutdownButton
        //                 }
        //             }
        //             KeyNavigation.tab: loginButton
        //             //Timer {
        //             //    interval: 200
        //             //    running: true
        //             //    onTriggered: passwdInput.forceActiveFocus()
        //             //}
        //         }

        //     }

        Text {
            anchors {
                top: parent.top
                left: parent.left
                leftMargin: 20
                topMargin: 20
            }
            // text: JSON.stringify(sessionModel.data)
        }

        MouseArea {
            anchors.fill: parent
            enabled: userListContainer.listUsers
            z: -1  // Put behind everything else
            onClicked: {
                userListContainer.listUsers = false;
            }
        }

        Keys.onEscapePressed: () => {
            if (userListContainer.listUsers) {
                userListContainer.listUsers = false;
                return;
            } else if (sessionButton.popupVisible) {
                sessionButton.popupVisible = false;
                return;
            }
            if (isAuthorizing)
                return;

            if (config.showLockScreen !== "false")
                needClose();
            passwdInput.text = "";
        }
        Keys.onPressed: event => {
            if (event.key == Qt.Key_CapsLock && !isAuthorizing) {
                loginMessage.warn("CapsLock on", "warning");
            }
        }
    }
}
