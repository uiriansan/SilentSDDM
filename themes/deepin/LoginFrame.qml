import QtQuick 2.2
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0
import SddmComponents 2.0

import "."

Item {
	signal needClose()

    id: frame
    property int sessionIndex: sessionModel.lastIndex
    property string userName: userModel.lastUser
    property bool isProcessing: glowAnimation.running
    property alias input: passwdInput
    property alias button: loginButton

	function onLoginSucceeded() {
	    glowAnimation.running = false
	    Qt.quit()
	}

	function onLoginFailed() {
		passwdInput.echoMode = TextInput.Normal
	    passwdInput.text = textConstants.loginFailed
	    passwdInput.focus = false
	    passwdInput.color = "#e7b222"
	    glowAnimation.running = false
	}

    //Connections {
    //    target: sddm
    //    onLoginSucceeded: {
    //        glowAnimation.running = false
    //        Qt.quit()
    //    }
    //    onLoginFailed: {
    //        passwdInput.echoMode = TextInput.Normal
    //        passwdInput.text = textConstants.loginFailed
    //        passwdInput.focus = false
    //        passwdInput.color = "#e7b222"
    //        glowAnimation.running = false
    //    }
    //}

    Item {
        id: loginItem
        anchors.centerIn: parent
        width: parent.width
        height: parent.height

        UserAvatar {
            id: userIconRec
            anchors {
                top: parent.top
                topMargin: parent.height / 4
                horizontalCenter: parent.horizontalCenter
            }
            width: 120
            height: 120
            source: userFrame.currentIconPath
            onClicked: {
                root.state = "stateUser"
                userFrame.focus = true
            }
        }

        Glow {
            id: avatarGlow
            anchors.fill: userIconRec
            radius: 0
            samples: 17
            color: "#99ffffff"
            source: userIconRec

            SequentialAnimation on radius {
                id: glowAnimation
                running: false
                alwaysRunToEnd: true
                loops: Animation.Infinite
                PropertyAnimation { to: 20 ; duration: 1000}
                PropertyAnimation { to: 0 ; duration: 1000}
            }
        }

        Text {
            id: userNameText
            anchors {
                top: userIconRec.bottom
                topMargin: 10
                horizontalCenter: parent.horizontalCenter
            }

            text: userName
            color: textColor
            font.pointSize: 15
        }
		Item {
			width: childrenRect.width
			anchors.top: userNameText.bottom
			anchors.horizontalCenter: parent.horizontalCenter

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
				font.pointSize: 9
				background: Rectangle {
					color: "#fff"
					opacity: 0.15
					radius: 8
					width: parent.width
					height: parent.height
					anchors.centerIn: parent
				}
				selectByMouse: true
				onAccepted: {
					glowAnimation.running = true
					sddm.login(userNameText.text, passwdInput.text, sessionIndex)
				}
			}
			ImgButton {
				id: loginButton
				height: passwdInput.height
				width: height
				anchors.left: (passwdInput.right)
				anchors.leftMargin: 5
				normalImg: Icons.arrowRight
				//normalImg: "icons/login_normal.png"
				//hoverImg: "icons/login_normal.png"
				//pressImg: "icons/login_press.png"
				onClicked: {
			    	glowAnimation.running = true
			        sddm.login(userNameText.text, passwdInput.text, sessionIndex)

					console.log(keyboard.capsLock)
				}
				//KeyNavigation.tab: shutdownButton
				//KeyNavigation.backtab: passwdInput
			}
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
			//                 glowAnimation.running = true
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
    Keys.onEscapePressed: needClose()
}
