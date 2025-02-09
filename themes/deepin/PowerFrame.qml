import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    signal needClose()
    signal needShutdown()
    signal needRestart()
    signal needSuspend()

    property alias shutdown: shutdownButton

    Row {
        spacing: 70

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom

        Item {
            width: 100
            height: 150

            ImgButton {
                id: shutdownButton
                width: 75
                height: 75
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                normalImg: "icons/powerframe/shutdown_normal.png"
                hoverImg: "icons/powerframe/shutdown_hover.png"
                pressImg: "icons/powerframe/shutdown_press.png"
                onClicked: needShutdown()
                KeyNavigation.right: restartButton
                KeyNavigation.left: suspendButton
                Keys.onEscapePressed: needClose()
            }

            Text {
                text: qsTr("Shutdown")
                font.pointSize: 15
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
            }
        }

        Item {
            width: 100
            height: 150

            ImgButton {
                id: restartButton
                width: 75
                height: 75
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                normalImg: "icons/powerframe/restart_normal.png"
                hoverImg: "icons/powerframe/restart_hover.png"
                pressImg: "icons/powerframe/restart_press.png"
                onClicked: needRestart()
                KeyNavigation.right: suspendButton
                KeyNavigation.left: shutdownButton
                Keys.onEscapePressed: needClose()
            }

            Text {
                text: qsTr("Reboot")
                font.pointSize: 15
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
            }
        }

        Item {
            width: 100
            height: 150

            ImgButton {
                id: suspendButton
                width: 75
                height: 75
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                normalImg: "icons/powerframe/suspend_normal.png"
                hoverImg: "icons/powerframe/suspend_hover.png"
                pressImg: "icons/powerframe/suspend_press.png"
                onClicked: needSuspend()
                KeyNavigation.right: shutdownButton
                KeyNavigation.left: restartButton
                Keys.onEscapePressed: needClose()
            }

            Text {
                text: qsTr("Suspend")
                font.pointSize: 15
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
            }
        }
    }

    MouseArea {
        z: -1
        anchors.fill: parent
        onClicked: needClose()
    }

    Keys.onEscapePressed: needClose()
}
