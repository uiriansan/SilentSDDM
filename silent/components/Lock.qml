import QtQuick 2.2
import QtGraphicalEffects 1.0

Item {
	id: screen
	signal loginRequested()

	Item {
		id: timeContainer

		anchors.horizontalCenter: parent.horizontalCenter
		anchors.verticalCenter: parent.verticalCenter

		Text {
			id: clock
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.bottomMargin: 5
			font.pointSize: Number(config.clockFontSize || 70)
			font.bold: true
			color: fontColor
			
			function updateClock() {
				text = new Date().toLocaleString(Qt.locale("en_US"), config.clockFormat || "hh:mm")
			}
		}

		Text {
			id: calendar
			anchors.horizontalCenter: parent.horizontalCenter
			anchors.top: clock.bottom
			font.pointSize: Number(config.dateFontSize || 12)
			color: fontColor

			function updateDate() {
				text = new Date().toLocaleString(Qt.locale("en_US"), config.dateFormat || "dddd, MMMM dd, yyyy")
			}
		}

		Timer {
			interval: 1000
			repeat: true
			running: true
			onTriggered: {
				clock.updateClock()
				calendar.updateDate()
			}
		}

		Component.onCompleted: {
			clock.updateClock()
			calendar.updateDate()
		}
	}

	Keys.onPressed: (event) => {
		if(event.key == Qt.Key_Escape) {
			event.accepted = false
			return
		}
		event.accepted = true
		loginRequested()
	}
}
