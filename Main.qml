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

    // Break property binding so it doesn't lock to `keyboard.capsLock` state's.
    // `keyboard.capsLock` should be enough, but its value only updates once for some F*ing reason
    property bool capsLockOn: {
        capsLockOn = keyboard ? keyboard.capsLock : false;
    }

    // Maybe it would be a good idea to use StackLayout or something similar instead. Anyway, this works and I'm not touching it...
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
                target: loginScreen.loginContainer
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
                target: loginScreen.loginContainer
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
                z: root.state === "lockState" ? 2 : 1 // Fix tooltips from the login screen showing up on top of the lock screen.
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
                z: root.state === "loginState" ? 2 : 1
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
