import QtQuick 2.5
import QtGraphicalEffects 1.12
import SddmComponents 2.0
import "components"

Rectangle {
    id: root
    state: config.showLockScreen === "false" ? "loginState" : "lockState"

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
                radius: config.lockScreenBlur || 0
            }
            PropertyChanges {
                target: loginFrame
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
                radius: config.loginScreenBlur || 50
            }
            PropertyChanges {
                target: loginFrame
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
            properties: "radius"
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
            source: root.state === "lockState" ? config.lockScreenBackground || "backgrounds/default.jpg" : config.loginScreenBackground || "backgrounds/default.jpg"
            fillMode: Image.Tile
            onStatusChanged: {
                if (status == Image.Error && source !== "backgrounds/default.jpg") {
                    source = "backgrounds/default.jpg";
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
            source: root.state === "lockState" ? config.lockScreenBackground || "backgrounds/default.jpg" : config.loginScreenBackground || "backgrounds/default.jpg"
        }

        FastBlur {
            id: bgBlur
            anchors.fill: mainFrameBackground
            source: mainFrameBackground
            radius: 0
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
                    loginFrame.input.forceActiveFocus();
                    // print("op1:", config.intValue("LoginScreen/option1"));
                    // print("op2:", config.intValue("LoginScreen.Buttons/option2"));
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
                scale: 0.5
            }

            MouseArea {
                z: -1
                anchors.fill: parent
                onClicked: {
                    root.state = "loginState";
                    loginFrame.input.forceActiveFocus();
                }
            }
        }
    }
}
