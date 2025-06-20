import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Item {
    id: spinnerContainer
    width: spinner.width + Config.spinnerSpacing + spinnerText.width
    height: childrenRect.height

    Behavior on opacity {
        enabled: Config.enableAnimations
        NumberAnimation {
            duration: 150
        }
    }
    Behavior on visible {
        enabled: Config.enableAnimations && Config.spinnerDisplayText
        ParallelAnimation {
            running: spinnerContainer.visible && Config.spinnerDisplayText
            NumberAnimation {
                target: spinnerText
                property: Config.loginAreaPosition === "left" ? "anchors.leftMargin" : (Config.loginAreaPosition === "right" ? "anchors.rightMargin" : "anchors.topMargin")
                from: -spinner.height
                to: Config.spinnerSpacing
                duration: 300
                easing.type: Easing.OutQuart
            }
            NumberAnimation {
                target: spinner
                property: "opacity"
                from: 0.0
                to: 1.0
                duration: 200
            }
        }
    }

    Image {
        id: spinner
        source: Config.getIcon(Config.spinnerIcon)
        width: Config.spinnerIconSize
        height: width
        sourceSize.width: width
        sourceSize.height: height
        opacity: Config.spinnerDisplayText ? 0.0 : 1.0

        RotationAnimation {
            target: spinner
            running: spinnerContainer.visible && Config.enableAnimations
            from: 0
            to: 360
            loops: Animation.Infinite
            duration: 1200
        }

        MultiEffect {
            source: spinner
            anchors.fill: spinner
            colorization: 1
            colorizationColor: Config.spinnerColor
        }

        Component.onCompleted: {
            if (Config.loginAreaPosition === "left") {
                anchors.left = parent.left;
                anchors.verticalCenter = parent.verticalCenter;
            } else if (Config.loginAreaPosition === "right") {
                anchors.right = parent.right;
                anchors.verticalCenter = parent.verticalCenter;
            } else {
                anchors.top = parent.top;
                anchors.horizontalCenter = parent.horizontalCenter;
            }
        }
    }

    Text {
        id: spinnerText
        visible: Config.spinnerDisplayText
        text: Config.spinnerText
        color: Config.spinnerColor
        font.pixelSize: Config.spinnerFontSize
        font.weight: Config.spinnerFontWeight
        font.family: Config.spinnerFontFamily

        Component.onCompleted: {
            if (Config.loginAreaPosition === "left") {
                anchors.left = spinner.right;
                anchors.leftMargin = Config.spinnerSpacing;
                anchors.verticalCenter = parent.verticalCenter;
            } else if (Config.loginAreaPosition === "right") {
                anchors.right = spinner.left;
                anchors.rightMargin = Config.spinnerSpacing;
                anchors.verticalCenter = parent.verticalCenter;
            } else {
                anchors.top = spinner.bottom;
                anchors.topMargin = Config.spinnerSpacing;
                anchors.horizontalCenter = parent.horizontalCenter;
            }
        }

        onVisibleChanged: {
            if (visible && Config.enableAnimations && Config.spinnerDisplayText) {
                spinnerTextInterval.running = true;
            } else {
                spinnerTextAnimation.running = false;
                spinnerTextInterval.running = false;
            }
        }

        SequentialAnimation on scale {
            id: spinnerTextAnimation
            running: false
            loops: Animation.Infinite
            NumberAnimation {
                from: 1.0
                to: 1.05
                duration: 900
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                from: 1.05
                to: 1.0
                duration: 900
                easing.type: Easing.InOutQuad
            }
        }
    }

    Timer {
        id: spinnerTextInterval
        interval: 3500
        repeat: false
        running: false
        onTriggered: {
            spinnerTextAnimation.running = true;
        }
    }

    Component.onDestruction: {
        if (spinnerTextInterval) {
            spinnerTextInterval.running = false;
            spinnerTextInterval.stop();
        }
        if (spinnerTextAnimation) {
            spinnerTextAnimation.running = false;
            spinnerTextAnimation.stop();
        }
    }
}
