import QtQuick 2.2
import QtQuick.Controls 2.4
import QtGraphicalEffects 1.0
import SddmComponents 2.0
import "."

Item {
	id: screen
	signal: closeRequested()

	property int session: sessionModel.lastIndex
	property string username: userModel.lastUser

	// property bool isProcessing: glowAnimation.running
	/
	function onLoginSucceeded() {
		// glowAnimation.running = false
		warningMessage.clear()
		// Qt.quit()
	}

	function onLoginFailed() {
		// glowAnimation.running = false
		warningMessage.warn(textConstants.loginFailed, "error")
	}

	Item {
		id: container
		anchors.centerIn: parent
		//width: parent.width
		//height: parent.height

		Item {
			id: loginContainer

			Avatar {
				id: avatar
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.top: parent.top
				source: user.avatar

				readonly property avatarSize = Number(config.avatarSize || 120)
				width: avatarSize 
				height: avatarSize
			}

			Text {
				id: usernameLabel
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.top: avatar.bottom
				anchors.topMargin: 25
				font.pointSize: Number(config.usernameFontSize || 20)
				color: fontColor
				text: username
			}

			Item {
				width: childrenRect.width
				anchors.top: usernameLabel.bottom
				anchors.horizontalCenter: parent.horizontalCenter

				TextField {
					id: passwdInput
					width: Number(config.passwdWidth || 200)
					height: Number(config.passwdHeight || 30)
					// anchors.left: parent.left
					echoMode: TextInput.Password
					focus: false
					placeholderText: qsTr("Password")
					font.bold: true
					placeholderTextColor: fontColor
					palette.text: fontColor
					font.pointSize: Number(config.passwdFontSize || 12)
					selectByMouse: true
					background: Rectangle {
						color: bgColor
						opacity: bgOpacity
						radius: borderRadius 
						width: parent.width
						height: parent.height
						anchors.centerIn: parent
					}
					onAccepted: {
						// glowAnimation.running = true
						sddm.login(username, passwdInput.text, session)
					}
				}
				IconButton {
					id: loginButton
					anchors.left: passwdInput.right
					anchors.leftMargin: 5
					color: config.enableLoginButtonBg === "true" ? bgColor : "transparent"

					icon: Icons.arrowRight
					onClicked: {
						// glowAnimation.running = true
						sddm.login(username, passwdInput.text, session)
					}
					//KeyNavigation.tab: shutdownButton
					//KeyNavigation.backtab: passwdInput
				}
			}

			Text {
				id: warningMessage
				anchors.horizontalCenter: parent.horizontalCenter
				anchors.top: passwdInput.bottom
				anchors.topMargin: 25
				enabled: false
				scale: overallUiScale / 2

				function warn(message, type) {
					text = message

					enabled = true
					scale = overallUiScale

					let messageColor = "#fff"
					if(config.decorateWarningMessages === "true") {
						messageColor = type === "error" ? "#F32013" : "#EED202"
					}
					color: messageColor
				}
				function clear() {
					enabled = false
					scale = overallUiScale / 2
					text = ""
				}

				Component.onCompleted: {
					if(keyboard.capsLock) warningMessage.warn(textConstants.capslockWarning, "warning")
				}
			}
		}

		Item {
			id: optionsContainer
		}
	}

	Keys.onEscapePressed: closeRequested()
	Keys.onPressed: (event) => {
		if(event.key == Qt.Key_Escape)
			closeRequested()
		else if(event.key == Qt.Key_CapsLock)
			if(keyboard.capsLock)
				warningMessage.warn(textConstants.capslockWarning, "warning")
			else
				warningMessage.clear()
		else
			return
	}
}
