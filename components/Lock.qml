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
            visible: Config.clockDisplay
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                topMargin: parent.height / 8 + Config.clockMarginTop
            }
            font.pixelSize: Config.clockFontSize
            font.bold: true
            font.family: Config.fontFamily
            color: Config.clockColor

            function updateTime() {
                text = new Date().toLocaleString(Qt.locale("en_US"), Config.clockFormat);
            }
        }

        Text {
            id: dateText
            visible: Config.dateDisplay
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: timeText.bottom
                topMargin: -15 + Config.dateMarginTop
            }

            font.pixelSize: Config.dateFontSize
            font.family: Config.fontFamily
            color: Config.dateColor

            function updateDate() {
                text = new Date().toLocaleString(Qt.locale("en_US"), Config.dateFormat);
            }
        }

        Item {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: lockBottomMessage.top
            anchors.bottomMargin: 5
            width: Config.pressAnyKeyIconSize
            height: Config.pressAnyKeyIconSize

            Image {
                id: lockIcon
                visible: Config.pressAnyKeyDisplay
                source: "icons/enter.svg"

                width: Config.pressAnyKeyIconSize
                height: Config.pressAnyKeyIconSize
                sourceSize: Qt.size(width, height)
                fillMode: Image.PreserveAspectFit
            }

            MultiEffect {
                source: lockIcon
                anchors.fill: lockIcon
                colorization: 1
                colorizationColor: Config.pressAnyKeyColor
            }
        }
        Text {
            id: lockBottomMessage
            visible: Config.pressAnyKeyDisplay
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.bottom
                bottomMargin: parent.height / 10 + Config.pressAnyKeyMarginBottom
            }
            font.pixelSize: Config.pressAnyKeyFontSize
            font.family: Config.fontFamily
            color: Config.pressAnyKeyColor
            text: Config.pressAnyKeyText
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
