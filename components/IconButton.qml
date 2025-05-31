import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Item {
    id: iconButton

    signal clicked

    property string icon: ""
    property int iconSize: 16
    property color iconColor: "#FFFFFF"
    property color activeIconColor: "#FFFFFF"
    property string label: ""
    property bool showLabel: true
    property int fontSize: 12
    property bool boldLabel: false
    property color backgroundColor: "#FFFFFF"
    property real backgroundOpacity: 0.0
    property color activeBackgroundColor: "#FFFFFF"
    property real activeBackgroundOpacity: 0.15
    property string tooltipText: ""
    property int borderRadius: 10
    property bool active: false
    readonly property bool isActive: active || focus || mouseArea.pressed || mouseArea.containsMouse

    width: buttonContentRow.width // childrenRect doesn't update for some reason\
    height: iconSize * 2

    Rectangle {
        id: buttonBackground
        anchors.fill: parent
        color: iconButton.isActive ? iconButton.activeBackgroundColor : iconButton.backgroundColor
        opacity: iconButton.isActive ? iconButton.activeBackgroundOpacity : iconButton.backgroundOpacity
        radius: iconButton.borderRadius
        border {
            color: iconButton.isActive ? iconButton.activeIconColor : iconButton.iconColor
            width: iconButton.focus ? Config.passwordInputBorderSize : 0
        }

        Behavior on opacity {
            enabled: Config.enableAnimations
            NumberAnimation {
                duration: 250
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
                height: width
                sourceSize: Qt.size(width, height)
                fillMode: Image.PreserveAspectFit
                opacity: iconButton.enabled ? 1.0 : 0.3

                MultiEffect {
                    source: buttonIcon
                    anchors.fill: buttonIcon
                    colorization: 1
                    colorizationColor: iconButton.isActive ? iconButton.activeIconColor : iconButton.iconColor
                }
            }
        }

        Text {
            id: buttonLabel
            text: iconButton.label
            visible: iconButton.showLabel && text !== ""
            font.family: Config.fontFamily
            font.pixelSize: iconButton.fontSize
            font.bold: iconButton.boldLabel
            rightPadding: 10
            color: iconButton.isActive ? iconButton.activeIconColor : iconButton.iconColor
            opacity: iconButton.enabled ? 1.0 : 0.5
            anchors.verticalCenter: parent.verticalCenter
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
            visible: mouseArea.containsMouse && iconButton.tooltipText !== "" || iconButton.focus && iconButton.tooltipText !== ""
            delay: 300
            contentItem: Text {
                font.family: Config.fontFamily
                text: iconButton.tooltipText
                color: iconButton.activeIconColor
            }
            background: Rectangle {
                color: iconButton.activeBackgroundColor
                opacity: iconButton.activeBackgroundOpacity
                border.width: 0
                radius: 5
            }
        }
    }
    Keys.onPressed: event => {
        if (event.key == Qt.Key_Return || event.key == Qt.Key_Enter || event.key === Qt.Key_Space) {
            iconButton.clicked();
        }
    }
}
