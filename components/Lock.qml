import QtQuick
import QtQuick.Effects
import QtQuick.Controls

Item {
    id: frame
    signal needLogin

    Item {
        id: timeArea
        visible: !loginFrame.isProcessing
        height: parent.height
        anchors {
            horizontalCenter: parent.horizontalCenter
        }
        Text {
            id: timeText
            visible: config.showClock === "false" ? false : true
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: parent.height / 8
            }
            font.pointSize: config.clockFontSize || 60
            font.bold: true
            font.family: config.font || "RedHatDisplay"
            color: config.clockColor || "#FFFFFF"

            function updateTime() {
                text = new Date().toLocaleString(Qt.locale("en_US"), config.clockFormat || "hh:mm");
            }
        }

        Text {
            id: dateText
            visible: config.showDate === "false" ? false : true
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: timeText.bottom
                topMargin: -15
            }

            font.pointSize: config.dateFontSize || 12
            font.family: config.font || "RedHatDisplay"
            color: config.dateColor || "#FFFFFF"

            function updateDate() {
                text = new Date().toLocaleString(Qt.locale("en_US"), config.dateFormat || "dddd, MMMM dd, yyyy");
            }
        }

        Item {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: lockBottomMessage.top
            anchors.bottomMargin: 5
            width: config.pressAnyKeyIconSize || 18
            height: config.pressAnyKeyIconSize || 18

            Image {
                id: lockIcon
                visible: config.showPressAnyKey === "false" ? false : true
                source: "icons/enter.svg"

                width: config.pressAnyKeyIconSize || 18
                height: config.pressAnyKeyIconSize || 18
                sourceSize: Qt.size(width, height)
                fillMode: Image.PreserveAspectFit
            }

            MultiEffect {
                source: lockIcon
                anchors.fill: lockIcon
                colorization: 1
                colorizationColor: config.pressAnyKeyColor || "#FFFFFF"
            }
        }
        Text {
            id: lockBottomMessage
            visible: config.showPressAnyKey === "false" ? false : true
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: parent.height / 10
            }
            font.pointSize: config.pressAnyKeyFontSize || 9
            font.family: config.font || "RedHatDisplay"
            color: config.pressAnyKeyColor || "#FFFFFF"
            text: "Press any key"
        }

        Timer {
            interval: 1000
            repeat: true
            running: true
            onTriggered: {
                timeText.updateTime();
                dateText.updateDate();
            }
        }

        Component.onCompleted: {
            timeText.updateTime();
            dateText.updateDate();
        }
    }

    MouseArea {
        id: lockScreenMouseArea
        z: -1
        anchors.fill: parent
        onClicked: needLogin()
    }

    Keys.onPressed: event => {
        if (event.key == Qt.Key_Escape) {
            event.accepted = false;
            return;
        } else {
            event.accepted = true;
            needLogin();
        }
    }
}
