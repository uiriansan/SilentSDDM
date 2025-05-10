import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Item {
    id: labelButton
    property string icon: ""
    property string label: ""
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

    height: iconSize * 2
    width: childrenRect.width + 10

    Rectangle {
        id: buttonBackground
        anchors.fill: parent
        color: pressed ? labelButton.hoverBackgroundColor : (mouseArea.pressed ? labelButton.hoverBackgroundColor : (mouseArea.containsMouse ? labelButton.hoverBackgroundColor : labelButton.backgroundColor))
        radius: 10
        opacity: pressed ? labelButton.hoverBackgroundOpacity : (mouseArea.pressed ? labelButton.hoverBackgroundOpacity : (mouseArea.containsMouse ? labelButton.hoverBackgroundOpacity : labelButton.backgroundOpacity))

        Behavior on opacity {
            NumberAnimation {
                duration: 250
            }
        }
    }

    Image {
        id: buttonIcon
        source: labelButton.icon
        anchors {
            left: parent.left
            leftMargin: 10
            verticalCenter: parent.verticalCenter
        }
        width: labelButton.iconSize
        height: labelButton.iconSize
        sourceSize: Qt.size(width, height)
        fillMode: Image.PreserveAspectFit
    }

    MultiEffect {
        source: buttonIcon
        anchors.fill: buttonIcon
        colorization: 1
        colorizationColor: mouseArea.pressed ? labelButton.hoverIconColor : (mouseArea.containsMouse ? labelButton.hoverIconColor : labelButton.iconColor)
    }

    Text {
        id: buttonLabel
        text: labelButton.label
        visible: labelButton.label !== ""
        font.pointSize: 8
        color: mouseArea.pressed ? labelButton.hoverIconColor : (mouseArea.containsMouse ? labelButton.hoverIconColor : labelButton.iconColor)
        anchors {
            left: buttonIcon.right
            leftMargin: 5
            verticalCenter: parent.verticalCenter
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: labelButton.clicked()
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
            labelButton.clicked();
        }
    }
}
