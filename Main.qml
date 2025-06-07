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
            // Background
            id: backgroundImage
            property string tsource: root.state === "lockState" ? Config.lockScreenBackground : Config.loginScreenBackground
            property bool isVideo: ["avi", "mp4", "mov", "mkv", "m4v", "webm"].includes(tsource.toString().split(".").slice(-1)[0])
            property bool displayColor: root.state === "lockState" && Config.lockScreenUseBackgroundColor || root.state === "loginState" && Config.loginScreenUseBackgroundColor

            anchors.fill: parent
            source: !isVideo ? tsource : ""
            asynchronous: true
            cache: true
            mipmap: true

            function updateVideo() {
                if (isVideo && tsource.toString().length > 0) {
                    backgroundVideo.source = Qt.resolvedUrl(tsource);
                }
            }

            onSourceChanged: {
                updateVideo();
            }
            Component.onCompleted: {
                updateVideo();
            }

            Rectangle {
                id: backgroundColor
                anchors.fill: parent
                anchors.margins: 0
                color: root.state === "lockState" && Config.lockScreenUseBackgroundColor ? Config.lockScreenBackgroundColor : root.state === "loginState" && Config.loginScreenUseBackgroundColor ? Config.loginScreenBackgroundColor : "black"
                visible: parent.displayColor || backgroundVideo.visible
            }

            // TODO: This is slow af. Removing the property bindings and doing everything at startup should help.
            Video {
                id: backgroundVideo
                anchors.fill: parent
                visible: parent.isVideo && !parent.displayColor
                enabled: visible
                autoPlay: true
                loops: MediaPlayer.Infinite
                muted: true
                onSourceChanged: {
                    if (source)
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
