import QtQuick 2.15
import QtGraphicalEffects 1.0
import SddmComponents 2.0

Item {
	id: root
	width: 1920
	height: 1080

	state: "stateLock"

	states: [
		State {
			name: "stateLock"
			PropertyChanges { target: lockFrame; opacity: 1}
			PropertyChanges { target: loginFrame; opacity: 0}
            PropertyChanges { target: bgBlur; radius: 0}
		},
		State {
			name: "stateLogin"
			PropertyChanges { target: lockFrame; opacity: 0}
            PropertyChanges { target: loginFrame; opacity: 1}
            PropertyChanges { target: bgBlur; radius: config.blur}
		}
	]

	transitions: Transition {
        PropertyAnimation { duration: 100; properties: "opacity";  }
        PropertyAnimation { duration: 300; properties: "radius"; }
    }
	
	readonly property color textColor: config.textColor
	property string notificationMessage

	LayoutMirroring.enabled: Qt.application.layoutDirection === Qt.RightToLeft
	LayoutMirroring.childrenInherit: True

	Item {
		id: wallpaper
		anchors.fill: parent

		Repeater {
			model: screenModel
			Background {
				x: geometry.x; y: geometry.y; width: geometry.width; height: geometry.height
				source: config.background
			}
		}
	}

	Item {
		id: mainFrame
        property variant geometry: screenModel.geometry(screenModel.primary)
        x: geometry.x; y: geometry.y; width: geometry.width; height: geometry.height

		Image {
			id: mainBackground
			anchors.fill: parent
			source: config.background
		}

		FastBlur {
            id: bgBlur
            anchors.fill: mainFrameBackground
            source: mainFrameBackground
            radius: 0
        }
		
		Item {
			id: centerArea
			width: parent.width
            height: parent.height / 3
            anchors.top: parent.top
            anchors.topMargin: parent.height / 5

			LockScreen {
				id: lockFrame
				focus: true
				anchors.fill: parent
				enabled: root.state == "stateLock"
				transformOrigin: Item.top
				onNeedLogin: {
					root.state = "stateLogin"
				}
			}

			LoginScreen {
				id: login
				anchors.fill: parent
				enabled: root.state == "stateLogin"
				onNeedClose: {
					root.state = "stateLock"
				}
			}
		}
		
	}

	MouseArea {
            z: -1
            anchors.fill: parent
            onClicked: {
                root.state = "stateLogin"
                loginFrame.input.forceActiveFocus()
            }
        }
}
