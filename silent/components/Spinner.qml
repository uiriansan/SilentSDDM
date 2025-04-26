import QtQuick 2.5
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0

Item {
    id: spinnerContainer
    width: 50
    height: 50

    Image {
        id: spinner
        source: "icons/spinner.svg" // Your spinner icon
        anchors.centerIn: parent
        width: 32
        height: 32
        sourceSize.width: 32
        sourceSize.height: 32

        RotationAnimation {
            target: spinner
            running: spinnerContainer.visible
            from: 0
            to: 360
            loops: Animation.Infinite
            duration: 1200
        }
    }
}
