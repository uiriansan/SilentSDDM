import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import QtQuick.Layouts

Item {
    id: iconButton

    signal clicked

    property bool active: false
    readonly property bool isActive: active || focus || mouseArea.pressed || mouseArea.containsMouse
    property string icon: ""
    property int iconSize: 16
    property color iconColor: "#FFFFFF"
    property color activeIconColor: "#FFFFFF"
    property string label: ""
    property bool showLabel: true
    property string fontFamily: "RedHatDisplay"
    property int fontWeight: 400
    property int fontSize: 12
    property color backgroundColor: "#FFFFFF"
    property double backgroundOpacity: 0.0
    property color activeBackgroundColor: "#FFFFFF"
    property double activeBackgroundOpacity: 0.15
    property string tooltipText: ""
    property int borderRadius: 10
    property int borderRadiusLeft: borderRadius
    property int borderRadiusRight: borderRadius
    property int borderSize: 0
    property color borderColor: isActive ? iconButton.activeIconColor : iconButton.iconColor

    width: buttonContentRow.width // childrenRect doesn't update for some reason\
    height: iconSize * 2

    Rectangle {
        id: buttonBackground
        anchors.fill: parent
        color: iconButton.isActive ? iconButton.activeBackgroundColor : iconButton.backgroundColor
        opacity: iconButton.isActive ? iconButton.activeBackgroundOpacity : iconButton.backgroundOpacity
        topLeftRadius: iconButton.borderRadiusLeft
        topRightRadius: iconButton.borderRadiusRight
        bottomLeftRadius: iconButton.borderRadiusLeft
        bottomRightRadius: iconButton.borderRadiusRight

        Behavior on opacity {
            enabled: Config.enableAnimations
            NumberAnimation {
                duration: 250
            }
        }
    }

    Rectangle {
        id: buttonBorder
        color: "transparent"
        topLeftRadius: iconButton.borderRadiusLeft
        topRightRadius: iconButton.borderRadiusRight
        bottomLeftRadius: iconButton.borderRadiusLeft
        bottomRightRadius: iconButton.borderRadiusRight
        anchors.fill: parent
        visible: iconButton.borderSize > 0 || iconButton.focus
        border {
            color: iconButton.borderColor
            width: iconButton.focus ? iconButton.borderSize || 2 : (iconButton.borderSize > 0 ? iconButton.borderSize : 0)
        }
    }

    RowLayout {
        id: buttonContentRow
        height: parent.height
        spacing: 0

        Rectangle {
            id: iconContainer
            color: "transparent"
            Layout.preferredWidth: parent.height
            Layout.preferredHeight: parent.height

            Image {
                id: buttonIcon
                source: iconButton.icon
                anchors.centerIn: parent
                width: iconButton.iconSize
                height: width
                sourceSize: Qt.size(width, height)
                fillMode: Image.PreserveAspectFit
                opacity: iconButton.enabled ? 1.0 : 0.3
                Behavior on opacity {
                    enabled: Config.enableAnimations
                    NumberAnimation {
                        duration: 250
                    }
                }

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
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            text: iconButton.label
            visible: iconButton.showLabel && text !== ""
            font.family: iconButton.fontFamily
            font.pixelSize: iconButton.fontSize
            font.weight: iconButton.fontWeight
            rightPadding: 10
            color: iconButton.isActive ? iconButton.activeIconColor : iconButton.iconColor
            opacity: iconButton.enabled ? 1.0 : 0.5
            Behavior on opacity {
                enabled: Config.enableAnimations
                NumberAnimation {
                    duration: 250
                }
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
            enabled: Config.tooltipsEnable
            visible: enabled && mouseArea.containsMouse && iconButton.tooltipText !== "" || enabled && iconButton.focus && iconButton.tooltipText !== ""
            delay: 300
            contentItem: Text {
                font.family: Config.tooltipsFontFamily
                font.pixelSize: Config.tooltipsFontSize
                text: iconButton.tooltipText
                color: Config.tooltipsContentColor
            }
            background: Rectangle {
                color: Config.tooltipsBackgroundColor
                opacity: Config.tooltipsBackgroundOpacity
                border.width: 0
                radius: Config.tooltipsBorderRadius
            }
        }
    }
    Keys.onPressed: event => {
        if (event.key == Qt.Key_Return || event.key == Qt.Key_Enter || event.key === Qt.Key_Space) {
            iconButton.clicked();
        }
    }
}
