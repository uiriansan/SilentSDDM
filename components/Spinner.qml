import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Item {
    id: spinnerContainer
    width: Config.spinnerSize
    height: Config.spinnerSize

    Image {
        id: spinner
        source: Config.getIcon(Config.spinnerIcon)
        anchors.centerIn: parent
        width: parent.width
        height: parent.height
        sourceSize.width: width
        sourceSize.height: height

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
    }
}
