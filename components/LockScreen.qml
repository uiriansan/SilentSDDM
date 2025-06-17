import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick.Controls

Item {
    id: lockScreen
    signal loginRequested

    // TODO: Support for weather info?
    ColumnLayout {
        id: timePositioner
        spacing: Config.dateMarginTop
        Text {
            id: time
            visible: Config.clockDisplay
            font.pixelSize: Config.clockFontSize
            font.weight: Config.clockFontWeight
            font.family: Config.clockFontFamily
            color: Config.clockColor
            Layout.alignment: Config.clockAlign === "left" ? Qt.AlignLeft : (Config.clockAlign === "right" ? Qt.AlignRight : Qt.AlignHCenter)

            function updateTime() {
                text = new Date().toLocaleString(Qt.locale(""), Config.clockFormat);
            }
        }

        Text {
            id: date
            Layout.alignment: Config.clockAlign === "left" ? Qt.AlignLeft : (Config.clockAlign === "right" ? Qt.AlignRight : Qt.AlignHCenter)
            visible: Config.dateDisplay
            font.pixelSize: Config.dateFontSize
            font.family: Config.dateFontFamily
            font.weight: Config.dateFontWeight
            color: Config.dateColor

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

        anchors {
            topMargin: Config.lockScreenPaddingTop || (lockScreen.height > 0 ? lockScreen.height / 10 : 50)
            rightMargin: Config.lockScreenPaddingRight || (lockScreen.height > 0 ? lockScreen.height / 10 : 50)
            bottomMargin: Config.lockScreenPaddingBottom || (lockScreen.height > 0 ? lockScreen.height / 10 : 50)
            leftMargin: Config.lockScreenPaddingLeft || (lockScreen.height > 0 ? lockScreen.height / 10 : 50)
        }
        Component.onCompleted: {
            lockScreen.alignItem(timePositioner, Config.clockPosition);
            time.updateTime();
            date.updateDate();
        }
    }

    ColumnLayout {
        id: messagePositioner
        visible: Config.lockMessageDisplay
        spacing: Config.lockMessageSpacing
        Image {
            id: lockIcon
            source: Config.getIcon(Config.lockMessageIcon)
            Layout.alignment: Config.lockMessageAlign === "left" ? Qt.AlignLeft : (Config.lockMessageAlign === "right" ? Qt.AlignRight : Qt.AlignHCenter)
            visible: Config.lockMessageDisplayIcon

            Layout.preferredWidth: Config.lockMessageIconSize
            Layout.preferredHeight: Config.lockMessageIconSize
            sourceSize: Qt.size(width, height)
            fillMode: Image.PreserveAspectFit

            MultiEffect {
                source: lockIcon
                anchors.fill: lockIcon
                colorization: Config.lockMessagePaintIcon ? 1 : 0
                colorizationColor: Config.lockMessageColor
            }
        }
        Text {
            id: lockMessage
            Layout.alignment: Config.lockMessageAlign === "left" ? Qt.AlignLeft : (Config.lockMessageAlign === "right" ? Qt.AlignRight : Qt.AlignHCenter)
            font.pixelSize: Config.lockMessageFontSize
            font.family: Config.lockMessageFontFamily
            font.weight: Config.lockMessageFontWeight
            color: Config.lockMessageColor
            text: Config.lockMessageText
        }

        anchors {
            topMargin: Config.lockScreenPaddingTop || (lockScreen.height > 0 ? lockScreen.height / 10 : 50)
            rightMargin: Config.lockScreenPaddingRight || (lockScreen.height > 0 ? lockScreen.height / 10 : 50)
            bottomMargin: Config.lockScreenPaddingBottom || (lockScreen.height > 0 ? lockScreen.height / 10 : 50)
            leftMargin: Config.lockScreenPaddingLeft || (lockScreen.height > 0 ? lockScreen.height / 10 : 50)
        }
        Component.onCompleted: lockScreen.alignItem(messagePositioner, Config.lockMessagePosition)
    }

    function alignItem(item, pos) {
        switch (pos) {
        case "top-left":
            item.anchors.top = lockScreen.top;
            item.anchors.left = lockScreen.left;
            break;
        case "top-center":
            item.anchors.top = lockScreen.top;
            item.anchors.horizontalCenter = lockScreen.horizontalCenter;
            break;
        case "top-right":
            item.anchors.top = lockScreen.top;
            item.anchors.right = lockScreen.right;
            break;
        case "center-left":
            item.anchors.verticalCenter = lockScreen.verticalCenter;
            item.anchors.left = lockScreen.left;
            break;
        case "center":
            item.anchors.verticalCenter = lockScreen.verticalCenter;
            item.anchors.horizontalCenter = lockScreen.horizontalCenter;
            break;
        case "center-right":
            item.anchors.verticalCenter = lockScreen.verticalCenter;
            item.anchors.right = lockScreen.right;
            break;
        case "bottom-left":
            item.anchors.bottom = lockScreen.bottom;
            item.anchors.left = lockScreen.left;
            break;
        case "bottom-center":
            item.anchors.bottom = lockScreen.bottom;
            item.anchors.horizontalCenter = lockScreen.horizontalCenter;
            break;
        default:
            item.anchors.bottom = lockScreen.bottom;
            item.anchors.right = lockScreen.right;
        }
    }

    MouseArea {
        id: lockScreenMouseArea
        hoverEnabled: true
        z: -1
        anchors.fill: lockScreen
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
