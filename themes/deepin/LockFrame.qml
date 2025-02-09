import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
	id: frame
	signal needLogin()

	Item {
        id: timeArea
        visible: ! loginFrame.isProcessing
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
        Text {
        	id: timeText
        	anchors {
				horizontalCenter: parent.horizontalCenter
				leftMargin: hMargin
            	bottom: dateText.top
            	bottomMargin: 5
        	}
        	font.pointSize: 70
			font.bold: true
            color: textColor

            function updateTime() {
            	text = new Date().toLocaleString(Qt.locale("en_US"), config.clockFormat)
            }
        }

        Text {
        	id: dateText
            anchors {
				horizontalCenter: parent.horizontalCenter
                leftMargin: hMargin
                bottom: parent.bottom
                bottomMargin: vMargin
            }

            font.pointSize: 12
            color: textColor

            function updateDate() {
                text = new Date().toLocaleString(Qt.locale("en_US"), config.dateFormat)
            }
        }

        Timer {
            interval: 1000
            repeat: true
            running: true
            onTriggered: {
                timeText.updateTime()
                dateText.updateDate()
            }
        }

        Component.onCompleted: {
            timeText.updateTime()
            dateText.updateDate()
        }
    }

    MouseArea {
        z: -1
        anchors.fill: parent
        onClicked: needLogin()
    }

	Keys.onPressed: (event) => {
		if (event.key == Qt.Key_Escape) {
			event.accepted = false;
			return;
		} else {
			event.accepted = true;
			needLogin();
		}
	}
}
