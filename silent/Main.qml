import QtQuick 2.2
import QtGraphicalEffects 1.0
import SddmComponents 2.0

Rectangle {
	id: root
	width: 1920
	height: 1080
	state: (config.lockScreen === "false" ? false : true) ? "lockState" : "loginState"

	function shouldUseDarkMode() {
		let useDarkMode = false
		const autoColorMode = config.autoColorMode === "true" ? true : false

		if(autoColorMode) {
			const hours = new Date().getHours()
			const isNight = (b >= 0 && b <= 7) || (b >= 19 && b <= 23)
			useDarkMode = isNight
		} else
			useDarkMode = config.colorMode === "dark" ? true : false

		return useDarkMode
	}

	TextConstants { id: textConstants }

	readonly property bool darkMode: shouldUseDarkMode()
	readonly property color fontColor: darkMode ? config.darkModeFontColor || "#fff" : config.lightModeFontColor || "#000"
	readonly property color bgColor: darkMode ? config.darkModeBgColor || "#000" : config.lightModeBgColor || "#fff"
	readonly property real bgOpacity: darkMode ? Number(config.darkModeBgOpacity || 0.15) : Number(config.lightModeBgOpacity || 0.15)
	readonly property real focusBgOpacity: Number(config.focusBgOpacity || 0.30)
	readonly property string loginPosition: config.loginPosition || "center"
	readonly property string lockPosition: config.lockPosition || "center"
	property string background: config.background
	readonly property bool showClock: config.showClock === "false" ? false : true
	readonly property bool showDate: config.showDate === "false" ? false : true
	readonly property bool showLangButton: config.showLangButton === "false" ? false : true
	readonly property bool showSessionButton: config.showSessionButton === "false" ? false : true
	readonly property bool showPowerButton: config.showPowerButton === "false" ? false : true
	readonly property int iconSize: Number(config.iconSize || 18)
	readonly property int overallUiScale: Number(config.overallUiScale || 1)
	readonly property int borderRadius: Number(config.borderRadius || 8)
	readonly property int iconButtonFontSize: Number(config.buttonFontSize || 12)
	readonly property int iconButtonSize: iconButtonFontSize + 5
	readonly property string avatarShape: config.avatarShape || "circle"

	states: [
		State {
			name: "lockState"
			PropertyChanges { target: lockScreen; opacity: 1 }
			PropertyChanges { target: loginScreen; opacity: 0 }
			PropertyChanges { target: loginScreen; scale: 0.5 }
			PropertyChanges { target: blur; radius: 0 }
		},
		State {
			name: "loginState"
			PropertyChanges { target: lockScreen; opacity: 0 }
			PropertyChanges { target: loginScreen; opacity: 1 }
			PropertyChanges { target: loginScreen; scale: 1 }
			PropertyChanges { target: blur; radius: Number(config.blur || 50) }
		}
	]

	transitions: Transition {
		enabled: config.animations === "false" ? false : true
        PropertyAnimation { duration: 150; properties: "opacity"; }
        PropertyAnimation { duration: 400; properties: "radius"; }
		PropertyAnimation { duration: 200; properties: "scale"; }
    }

	Repeater {
		model: screenModel
		Background {
			x: geometry.x; y: geometry.y; width: geometry.width; height:geometry.height
            source: background
            fillMode: Image.Tile
            onStatusChanged: {
                if (status == Image.Error && source !== config.defaultBackground) {
                    source = "wallpapers/default.jpg"
					background = "wallpapers/default.jpg"
                }
            }
		}
	}

	Item {
		id: container
		property variant geometry: screenModel.geometry(screenModel.primary)
        x: geometry.x; y: geometry.y; width: geometry.width; height: geometry.height

		Image {
			id: containerBackground
			anchors.fill: parent
			source: background
		}

		FastBlur {
			id: blur
			anchors.fill: containerBackground
			radius: 0
		}

		Lock {
			id: lockScreen
			enabled: root.state == "lockState"
			focus: true
			anchors.fill: parent
			anchors.centerIn: parent
			onLoginRequested: {
				root.state = "loginState"
				loginScreen.passwdInput.forceActiveFocus()
			}
		}

		Login {
			id: loginScreen
			enabled: root.state == "loginState"
			opacity: 0
			anchors.fill: parent
			anchors.centerIn: parent
			onCloseRequested: {
				root.state = "lockState"
				lockScreen.focus = true
			}
		}

		MouseArea {
			z: -1
			anchors.fill: parent
			onClicked: {
				root.state = "loginState"
				loginScreen.passwdInput.forceActiveFocus()
			}
		}
	}
}
