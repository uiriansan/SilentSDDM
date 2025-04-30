import QtQuick 2.5
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.12

Item {
    id: iconButton
    property string icon: ""
    property int iconSize: 24
    property double backgroundOpacity: 0.0
    property color backgroundColor: "#FFFFFF"
    property color hoverBackgroundColor: "#FFFFFF"
    property double hoverBackgroundOpacity: 0.15
    property color iconColor: "#FFFFFF"
    property color hoverIconColor: "#FFFFFF"
    signal clicked

    width: iconSize * 2
    height: iconSize * 2

    Rectangle {
        id: buttonBackground
        anchors.fill: parent
        color: mouseArea.pressed ? iconButton.hoverBackgroundColor : (mouseArea.containsMouse ? iconButton.hoverBackgroundColor : iconButton.backgroundColor)
        radius: 10
        opacity: mouseArea.pressed ? iconButton.hoverBackgroundOpacity : (mouseArea.containsMouse ? iconButton.hoverBackgroundOpacity : iconButton.backgroundOpacity)

        Behavior on opacity {
            NumberAnimation {
                duration: 250
            }
        }
    }

    Image {
        id: buttonIcon
        source: iconButton.icon
        anchors.centerIn: parent
        width: iconButton.iconSize
        height: iconButton.iconSize
        sourceSize: Qt.size(width, height)
        fillMode: Image.PreserveAspectFit
    }

    ColorOverlay {
        anchors.fill: buttonIcon
        source: buttonIcon
        color: mouseArea.pressed ? iconButton.hoverIconColor : (mouseArea.containsMouse ? iconButton.hoverIconColor : iconButton.iconColor)
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: iconButton.clicked()
        cursorShape: Qt.PointingHandCursor
    }
    Keys.onPressed: event => {
        if (event.key == Qt.Key_Return || event.key == Qt.Key_Enter) {
            iconButton.clicked();
        }
    }
}
