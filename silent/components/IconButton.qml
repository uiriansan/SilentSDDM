import QtQuick 2.5
import QtQuick.Controls 2.5
import QtQuick.Effects

// import QtGraphicalEffects 1.12

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
    property string tooltip_text: ""
    property bool pressed: false
    signal clicked

    width: iconSize * 2
    height: iconSize * 2

    Rectangle {
        id: buttonBackground
        anchors.fill: parent
        color: pressed ? iconButton.hoverBackgroundColor : (mouseArea.pressed ? iconButton.hoverBackgroundColor : (mouseArea.containsMouse ? iconButton.hoverBackgroundColor : iconButton.backgroundColor))
        radius: 10
        opacity: pressed ? iconButton.hoverBackgroundOpacity : (mouseArea.pressed ? iconButton.hoverBackgroundOpacity : (mouseArea.containsMouse ? iconButton.hoverBackgroundOpacity : iconButton.backgroundOpacity))

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

    // ColorOverlay {
    //     anchors.fill: buttonIcon
    //     source: buttonIcon
    //     color: mouseArea.pressed ? iconButton.hoverIconColor : (mouseArea.containsMouse ? iconButton.hoverIconColor : iconButton.iconColor)
    // }

    MultiEffect {
        source: buttonIcon
        anchors.fill: buttonIcon
        colorization: 1
        colorizationColor: mouseArea.pressed ? iconButton.hoverIconColor : (mouseArea.containsMouse ? iconButton.hoverIconColor : iconButton.iconColor)
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: iconButton.clicked()
        cursorShape: Qt.PointingHandCursor
        ToolTip {
            parent: mouseArea
            visible: mouseArea.containsMouse && tooltip_text !== ""
            delay: 300
            text: tooltip_text
            contentItem: Text {
                text: tooltip_text
                color: "#FFFFFF"
            }
            background: Rectangle {
                color: "#FFFFFF"
                opacity: 0.15
                border.width: 0
                radius: 5
            }
        }
    }
    Keys.onPressed: event => {
        if (event.key == Qt.Key_Return || event.key == Qt.Key_Enter) {
            iconButton.clicked();
        }
    }
}
