import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Qt5Compat.GraphicalEffects

Item {
    id: iconButton

    signal clicked

    property bool active: false
    readonly property bool isActive: active || focus || mouseArea.pressed || mouseArea.containsMouse
    readonly property bool isHovered: mouseArea.containsMouse
    property string icon: ""
    property int iconSize: 16
    property color contentColor: "#FFFFFF"
    property color activeContentColor: "#FFFFFF"
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
    property color borderColor: isActive ? iconButton.activeContentColor : iconButton.contentColor
    property var preferredWidth: undefined

    width: preferredWidth ? preferredWidth : buttonContentRow.width
    height: iconSize * 2

    // Enhanced scale animation for hover and press
    scale: mouseArea.pressed ? 0.95 : (mouseArea.containsMouse ? 1.05 : 1.0)
    Behavior on scale {
        enabled: Config.enableAnimations
        NumberAnimation {
            duration: 100
            easing.type: Easing.OutCubic
        }
    }

    Rectangle {
        id: buttonBackground
        anchors.fill: parent
        color: iconButton.isActive ? iconButton.activeBackgroundColor : iconButton.backgroundColor
        opacity: iconButton.isActive ? iconButton.activeBackgroundOpacity : iconButton.backgroundOpacity
        topLeftRadius: iconButton.borderRadiusLeft
        topRightRadius: iconButton.borderRadiusRight
        bottomLeftRadius: iconButton.borderRadiusLeft
        bottomRightRadius: iconButton.borderRadiusRight

        // Enhanced transitions
        Behavior on opacity {
            enabled: Config.enableAnimations
            NumberAnimation {
                duration: 200
                easing.type: Easing.OutCubic
            }
        }
        Behavior on color {
            enabled: Config.enableAnimations
            ColorAnimation {
                duration: 200
                easing.type: Easing.OutCubic
            }
        }

        // Simple glow effect when hovered
        border.width: iconButton.isHovered ? 1 : 0
        border.color: iconButton.activeContentColor
        
        Behavior on border.width {
            enabled: Config.enableAnimations
            NumberAnimation {
                duration: 200
                easing.type: Easing.OutCubic
            }
        }
    }

    // Ripple effect on click
    Rectangle {
        id: rippleEffect
        anchors.centerIn: parent
        width: 0
        height: 0
        radius: width / 2
        color: iconButton.activeContentColor
        opacity: 0
        topLeftRadius: iconButton.borderRadiusLeft
        topRightRadius: iconButton.borderRadiusRight
        bottomLeftRadius: iconButton.borderRadiusLeft
        bottomRightRadius: iconButton.borderRadiusRight

        SequentialAnimation {
            id: rippleAnimation
            running: false
            ParallelAnimation {
                NumberAnimation {
                    target: rippleEffect
                    property: "width"
                    to: Math.max(iconButton.width, iconButton.height) * 2
                    duration: 300
                    easing.type: Easing.OutCubic
                }
                NumberAnimation {
                    target: rippleEffect
                    property: "height"
                    to: Math.max(iconButton.width, iconButton.height) * 2
                    duration: 300
                    easing.type: Easing.OutCubic
                }
                SequentialAnimation {
                    NumberAnimation {
                        target: rippleEffect
                        property: "opacity"
                        to: 0.3
                        duration: 100
                    }
                    NumberAnimation {
                        target: rippleEffect
                        property: "opacity"
                        to: 0
                        duration: 200
                    }
                }
            }
            onFinished: {
                rippleEffect.width = 0;
                rippleEffect.height = 0;
                rippleEffect.opacity = 0;
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
                
                // Enhanced scale animation for icon
                scale: iconButton.isHovered ? 1.1 : 1.0
                
                Behavior on opacity {
                    enabled: Config.enableAnimations
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.OutCubic
                    }
                }
                Behavior on scale {
                    enabled: Config.enableAnimations
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.OutCubic
                    }
                }

                ColorOverlay {
                    source: buttonIcon
                    anchors.fill: buttonIcon
                    color: iconButton.isActive ? iconButton.activeContentColor : iconButton.contentColor
                    
                    // Smooth color transitions
                    Behavior on color {
                        enabled: Config.enableAnimations
                        ColorAnimation {
                            duration: 200
                            easing.type: Easing.OutCubic
                        }
                    }
                }
            }
        }

        Text {
            id: buttonLabel
            Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
            Layout.fillWidth: true
            elide: Text.ElideRight
            text: iconButton.label
            visible: iconButton.showLabel && text !== ""
            font.family: iconButton.fontFamily
            font.pixelSize: iconButton.fontSize
            font.weight: iconButton.fontWeight
            rightPadding: 10
            color: iconButton.isActive ? iconButton.activeContentColor : iconButton.contentColor
            opacity: iconButton.enabled ? 1.0 : 0.5
            Behavior on opacity {
                enabled: Config.enableAnimations
                NumberAnimation {
                    duration: 250
                }
            }
            Component.onCompleted: {
                if (iconButton.preferredWidth && iconButton.preferredWidth !== -1) {
                    Layout.preferredWidth = iconButton.width - iconContainer.width;
                }
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: parent.enabled
        onClicked: {
            if (Config.enableAnimations) {
                rippleAnimation.start();
            }
            iconButton.clicked();
        }
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
