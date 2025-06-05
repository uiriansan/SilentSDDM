import QtQuick
import QtQuick.Effects
import QtQuick.Controls
import QtQuick.Layouts

Item {
    id: lockScreen
    signal loginRequested

    ColumnLayout {
        id: timeArea
        anchors.fill: parent
        spacing: 0

        Item {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            Layout.topMargin: Config.lockScreenPadding || parent.height / 10
            Layout.leftMargin: Config.lockScreenPadding || parent.width / 10
            Layout.rightMargin: Config.lockScreenPadding || parent.width / 10
            Layout.bottomMargin: Config.lockScreenPadding || parent.height / 10

            // TODO: Support for weather info?
            Text {
                id: time
                anchors {
                    top: parent.top
                    horizontalCenter: parent.horizontalCenter
                }
                visible: Config.clockDisplay
                font.pixelSize: Config.clockFontSize
                font.weight: 900 // Create option here!
                font.family: Config.fontFamily
                color: Config.clockColor

                Layout.column: 1

                function updateTime() {
                    text = new Date().toLocaleString(Qt.locale(""), Config.clockFormat);
                }
            }

            Text {
                id: date
                anchors {
                    top: time.bottom
                    topMargin: -15
                    horizontalCenter: parent.horizontalCenter
                }
                visible: Config.dateDisplay
                font.pixelSize: Config.dateFontSize
                font.family: Config.fontFamily
                color: Config.dateColor
                Layout.column: 2

                function updateDate() {
                    text = new Date().toLocaleString(Qt.locale(""), Config.dateFormat);
                }
            }

            Timer {
                interval: 1000
                repeat: true
                running: true
                onTriggered: {
                    time.updateTime();
                    date.updateDate();
                }
            }

            Component.onCompleted: {
                time.updateTime();
                date.updateDate();
            }
        }

        Item {
            Layout.alignment: Qt.AlignHCenter | Qt.AlignBottom
            Layout.bottomMargin: Config.lockScreenPadding || parent.height / 10

            Image {
                id: lockIcon
                visible: Config.pressAnyKeyDisplay
                source: "icons/enter.svg"
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    bottom: lockBottomMessage.top
                }

                width: Config.pressAnyKeyIconSize
                height: Config.pressAnyKeyIconSize
                sourceSize: Qt.size(width, height)
                fillMode: Image.PreserveAspectFit

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
                }
                font.pixelSize: Config.pressAnyKeyFontSize
                font.family: Config.fontFamily
                color: Config.pressAnyKeyColor
                text: Config.pressAnyKeyText
            }
        }
    }

    MouseArea {
        id: lockScreenMouseArea
        hoverEnabled: true
        z: -1
        anchors.fill: parent
        onClicked: lockScreen.loginRequested()
    }

    Keys.onPressed: event => {
        if (event.key === Qt.Key_CapsLock) {
            root.capsLockOn = !root.capsLockOn;
        }

        if (event.key === Qt.Key_Escape) {
            event.accepted = false;
            return;
        } else {
            lockScreen.loginRequested();
        }
        event.accepted = true;
    }
}
