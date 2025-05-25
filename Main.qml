import "."
import QtQuick
import SddmComponents
import QtQuick.Effects
import "components"

Rectangle {
    id: root
    state: Config.displayLockScreen ? "lockState" : "loginState"

    readonly property color textColor: "#FFFFFF"

    TextConstants {
        id: textConstants
    }

    states: [
        State {
            name: "lockState"
            PropertyChanges {
                target: lockFrame
                opacity: 1
            }
            PropertyChanges {
                target: loginFrame
                opacity: 0
            }
            PropertyChanges {
                target: bgBlur
                blur: Config.lockScreenBlur ? 1.0 : 0.0
            }
            PropertyChanges {
                target: loginFrame.loginArea
                scale: 0.5
            }
        },
        State {
            name: "loginState"
            PropertyChanges {
                target: lockFrame
                opacity: 0
            }
            PropertyChanges {
                target: loginFrame
                opacity: 1
            }
            PropertyChanges {
                target: bgBlur
                blur: Config.loginScreenBlur ? 1.0 : 0.0
            }
            PropertyChanges {
                target: loginFrame.loginArea
                scale: 1
            }
        }
    ]
    transitions: Transition {
        enabled: config.enableAnimations === "false" ? false : true
        PropertyAnimation {
            duration: 150
            properties: "opacity"
        }
        PropertyAnimation {
            duration: 400
            properties: "blur"
        }
        PropertyAnimation {
            duration: 200
            properties: "scale"
        }
    }

    Repeater {
        model: screenModel
        Background {
            x: geometry.x
            y: geometry.y
            width: geometry.width
            height: geometry.height
            source: root.state === "lockState" ? config.lockScreenBackground || "./backgrounds/default.jpg" : config.loginScreenBackground || "./backgrounds/default.jpg"
            fillMode: Image.Tile
            onStatusChanged: {
                if (status == Image.Error && source !== "./backgrounds/default.jpg") {
                    source = "./backgrounds/default.jpg";
                }
            }
        }
    }

    Item {
        id: mainFrame
        property variant geometry: screenModel.geometry(screenModel.primary)
        x: geometry.x
        y: geometry.y
        width: geometry.width
        height: geometry.height

        Image {
            id: mainFrameBackground
            anchors.fill: parent
            source: root.state === "lockState" ? config.lockScreenBackground || "./backgrounds/default.jpg" : config.loginScreenBackground || "./backgrounds/default.jpg"
        }

        MultiEffect {
            id: bgBlur
            source: mainFrameBackground
            anchors.fill: mainFrameBackground
            blurEnabled: true
            blurMax: Config.blurRadius
        }

        Item {
            id: centerArea
            width: parent.width
            height: parent.height
            anchors.top: parent.top

            Lock {
                id: lockFrame
                focus: true
                anchors.fill: parent
                enabled: root.state == "lockState"
                onNeedLogin: {
                    root.state = "loginState";
                    loginFrame.input.input.forceActiveFocus();
                }
            }
            Login {
                id: loginFrame
                anchors.fill: parent
                anchors.centerIn: parent
                enabled: root.state == "loginState"
                opacity: 0
                onNeedClose: {
                    root.state = "lockState";
                    lockFrame.focus = true;
                }
            }

            MouseArea {
                z: -1
                anchors.fill: parent
                onClicked: {
                    root.state = "loginState";
                    loginFrame.input.input.forceActiveFocus();
                }
            }
        }
    }
}
