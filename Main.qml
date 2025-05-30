import "."
import QtQuick
import SddmComponents
import QtQuick.Effects
import "components"

Item {
    id: root
    state: Config.lockScreenDisplay ? "lockState" : "loginState"

    // TODO: Add own translations: https://github.com/sddm/sddm/wiki/Localization
    TextConstants {
        id: textConstants
    }

    // Break property binding so it doesn't update when `sddm.keyboard.capsLock` changes.
    // `sddm.keyboard.capsLock` should be enough, but yet again it doesn't work
    // TODO: Update this every time the login area becomes visible, so it kinda works with multiple monitors
    property bool capsLockOn: {
        capsLockOn = keyboard ? keyboard.capsLock : false;
    }

    states: [
        State {
            name: "lockState"
            PropertyChanges {
                target: lockScreen
                opacity: 1.0
            }
            PropertyChanges {
                target: loginScreen
                opacity: 0.0
            }
            PropertyChanges {
                target: backgroundBlur
                blur: Config.lockScreenBlur
            }
            PropertyChanges {
                target: loginScreen.loginArea
                scale: 0.5
            }
        },
        State {
            name: "loginState"
            PropertyChanges {
                target: lockScreen
                opacity: 0.0
            }
            PropertyChanges {
                target: loginScreen
                opacity: 1.0
            }
            PropertyChanges {
                target: backgroundBlur
                blur: Config.loginScreenBlur
            }
            PropertyChanges {
                target: loginScreen.loginArea
                scale: 1.0
            }
        }
    ]
    transitions: Transition {
        enabled: Config.enableAnimations
        PropertyAnimation {
            duration: 150
            properties: "opacity"
        }
        PropertyAnimation {
            duration: 400
            properties: "blur"
        }
    }

    // Still not sure if this is needed:
    // Repeater {
    //     model: screenModel

    //     Background {
    //         x: geometry.x
    //         y: geometry.y
    //         width: geometry.width
    //         height: geometry.height
    //         source: root.state === "lockState" ? Config.lockScreenBackground : Config.loginScreenBackground
    //         fillMode: Image.Tile
    //         onStatusChanged: {
    //             if (status == Image.Error && source !== "backgrounds/default.jpg") {
    //                 source = "background/default.jpg";
    //             }
    //         }
    //     }
    // }

    Item {
        id: mainFrame
        property variant geometry: screenModel.geometry(screenModel.primary)
        x: geometry.x
        y: geometry.y
        width: geometry.width
        height: geometry.height

        Rectangle {
            // TODO: Animated backgrounds (video/gif)
            id: backgroundContainer
            anchors.fill: parent
            // Background color
            color: root.state === "lockState" && Config.lockScreenUseBackgroundColor ? Config.lockScreenBackgroundColor : (root.state === "loginState" && Config.loginScreenUseBackgroundColor ? Config.loginScreenBackgroundColor : "transparent")

            Image {
                // Background image
                id: backgroundImage
                anchors.fill: parent
                visible: (root.state === "lockState" && !Config.lockScreenUseBackgroundColor) || (root.state === "loginState" && !Config.loginScreenUseBackgroundColor)
                source: root.state === "lockState" ? Config.lockScreenBackground : Config.loginScreenBackground
            }

            MultiEffect {
                // Background blur
                id: backgroundBlur
                source: backgroundImage
                anchors.fill: backgroundImage
                blurEnabled: backgroundImage.visible
                blurMax: Config.blurRadius
                blur: 0.0
            }
        }

        Item {
            id: screenContainer
            anchors.fill: parent
            anchors.top: parent.top

            LockScreen {
                id: lockScreen
                anchors.fill: parent
                focus: root.state === "lockState"
                enabled: root.state === "lockState"
                onLoginRequested: {
                    root.state = "loginState";
                    loginScreen.password.input.forceActiveFocus();
                }
            }
            LoginScreen {
                id: loginScreen
                anchors.fill: parent
                enabled: root.state === "loginState"
                opacity: 0.0
                onCloseRequested: {
                    root.state = "lockState";
                }
            }
        }
    }
}
