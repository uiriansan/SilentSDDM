import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Item {
    id: spinnerContainer
    width: config.spinnerSize || 50
    height: config.spinnerSize || 50

    Image {
        id: spinner
        source: "icons/spinner.svg" // Your spinner icon
        anchors.centerIn: parent
        width: config.spinnerSize || 32
        height: config.spinnerSize || 32
        sourceSize.width: config.spinnerSize || 32
        sourceSize.height: config.spinnerSize || 32

        RotationAnimation {
            target: spinner
            running: spinnerContainer.visible
            from: 0
            to: 360
            loops: Animation.Infinite
            duration: 1200
        }

        // ColorOverlay {
        //     anchors.fill: spinner
        //     source: spinner
        //     color: config.spinnerColor || "#FFFFFF"
        // }

        MultiEffect {
            source: spinner
            anchors.fill: spinner
            colorization: 1
            colorizationColor: config.spinnerColor || "#FFFFFF"
        }
    }
}
