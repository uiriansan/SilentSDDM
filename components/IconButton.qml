import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Item {
    id: iconButton
    property string icon: ""
    property string label: ""
    property bool boldLabel: false
    property int iconSize: 24
    property int fontSize: 8
    property double backgroundOpacity: 0.0
    property color backgroundColor: "#FFFFFF"
    property color hoverBackgroundColor: "#FFFFFF"
    property double hoverBackgroundOpacity: 0.15
    property color iconColor: "#FFFFFF"
    property color hoverIconColor: "#FFFFFF"
    property string tooltip_text: ""
    property bool pressed: false
    property int borderRadius: 10
    signal clicked

    height: iconSize * 2
    width: buttonContentRow.width // childrenRect doesn't update for some reason

    Rectangle {
        id: buttonBorder
        anchors.fill: parent
        color: "transparent"
        radius: iconButton.borderRadius
        border {
            color: "#FFFFFF"
            width: iconButton.focus ? 1 : 0
        }
        Rectangle {
            id: buttonBackground
            anchors.fill: parent
            color: pressed ? iconButton.hoverBackgroundColor : (mouseArea.pressed ? iconButton.hoverBackgroundColor : (mouseArea.containsMouse ? iconButton.hoverBackgroundColor : (iconButton.focus ? iconButton.hoverBackgroundColor : iconButton.backgroundColor)))
            radius: iconButton.borderRadius
            opacity: pressed ? iconButton.hoverBackgroundOpacity : (mouseArea.pressed ? iconButton.hoverBackgroundOpacity : (mouseArea.containsMouse ? iconButton.hoverBackgroundOpacity : (iconButton.focus ? iconButton.hoverBackgroundOpacity : iconButton.backgroundOpacity)))

            Behavior on opacity {
                enabled: Config.enableAnimations
                NumberAnimation {
                    duration: 250
                }
            }
        }
    }

    Row {
        id: buttonContentRow
        height: parent.height

        Rectangle {
            id: iconContainer
            color: "transparent"
            height: parent.height
            width: height

            Image {
                id: buttonIcon
                source: iconButton.icon
                anchors.centerIn: parent
                width: iconButton.iconSize
                height: iconButton.iconSize
                sourceSize: Qt.size(width, height)
                fillMode: Image.PreserveAspectFit
                opacity: iconButton.enabled ? 1.0 : 0.3

                MultiEffect {
                    source: buttonIcon
                    anchors.fill: buttonIcon
                    colorization: 1
                    colorizationColor: mouseArea.pressed ? iconButton.hoverIconColor : (mouseArea.containsMouse ? iconButton.hoverIconColor : iconButton.iconColor)
                }
            }
        }

        Text {
            id: buttonLabel
            text: iconButton.label
            visible: text !== ""
            font.family: Config.fontFamily
            font.pixelSize: iconButton.fontSize
            font.bold: iconButton.boldLabel
            rightPadding: 10
            color: mouseArea.pressed ? iconButton.hoverIconColor : (mouseArea.containsMouse ? iconButton.hoverIconColor : iconButton.iconColor)
            opacity: iconButton.enabled ? 1.0 : 0.5
            anchors {
                verticalCenter: parent.verticalCenter
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: parent.enabled
        onClicked: iconButton.clicked()
        cursorShape: Qt.PointingHandCursor
        ToolTip {
            parent: mouseArea
            visible: mouseArea.containsMouse && tooltip_text !== "" || iconButton.focus && tooltip_text !== ""
            delay: 300
            font.family: Config.fontFamily
            text: tooltip_text
            contentItem: Text {
                font.family: Config.fontFamily
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
