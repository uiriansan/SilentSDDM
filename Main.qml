import "."
import QtQuick
import SddmComponents
import QtQuick.Effects
import QtMultimedia
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
    onCapsLockOnChanged: {
        loginScreen.updateCapsLock();
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

        AnimatedImage {
            id: backgroundImage
            property bool isVideo: ["avi", "mp4", "mov", "mkv", "m4v", "webm"].includes(source.toString().split(".").slice(-1)[0])
            property url tsource: root.state === "lockState" ? Config.lockScreenBackground : Config.loginScreenBackground
            anchors.fill: parent
            visible: (root.state === "lockState" && !Config.lockScreenUseBackgroundColor) || (root.state === "loginState" && !Config.loginScreenUseBackgroundColor)
            source: !isVideo ? tsource : ""

            Rectangle {
                id: backgroundColor
                anchors.fill: parent
                color: root.state === "lockState" && Config.lockScreenUseBackgroundColor ? Config.lockScreenBackgroundColor : root.state === "loginState" && Config.loginScreenUseBackgroundColor ? Config.loginScreenBackgroundColor : "black"
                visible: root.state === "lockState" && Config.lockScreenUseBackgroundColor || root.state === "loginState" && Config.loginScreenUseBackgroundColor || backgroundVideo.visible
            }

            // TODO: This is really slow
            Video {
                id: backgroundVideo
                anchors.fill: parent
                source: parent.isVideo ? Qt.resolvedUrl(parent.source) : ""
                visible: parent.isVideo && !backgroundColor.visible
                autoPlay: true
                loops: MediaPlayer.Infinite
                muted: true
                onSourceChanged: {
                    if (source.toString().length > 0)
                        backgroundVideo.play();
                }
            }
        }
        MultiEffect {
            // Background blur
            id: backgroundBlur
            source: backgroundImage
            anchors.fill: backgroundImage
            blurEnabled: backgroundImage.visible
            blurMax: Config.blurRadius
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
