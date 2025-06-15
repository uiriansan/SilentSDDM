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
                blurMax: Config.lockScreenBlur
            }
            PropertyChanges {
                target: loginScreen.loginContainer
                scale: 0.5
            }
            PropertyChanges {
                target: backgroundBlur
                brightness: Config.lockScreenBrightness
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
                blurMax: Config.loginScreenBlur
            }
            PropertyChanges {
                target: loginScreen.loginContainer
                scale: 1.0
            }
            PropertyChanges {
                target: backgroundBlur
                brightness: Config.loginScreenBrightness
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
            properties: "blurMax"
        }
        PropertyAnimation {
            duration: 400
            properties: "brightness"
        }
    }

    Item {
        id: mainFrame
        property variant geometry: screenModel.geometry(screenModel.primary)
        x: geometry.x
        y: geometry.y
        width: geometry.width
        height: geometry.height

        // AnimatedImage { // `.gif`s are seg faulting with multi monitors... QT/SDDM issue?
        Image {
            // Background
            id: backgroundImage
            property string tsource: root.state === "lockState" ? Config.lockScreenBackground : Config.loginScreenBackground
            property bool isVideo: ["avi", "mp4", "mov", "mkv", "m4v", "webm"].includes(tsource.toString().split(".").slice(-1)[0])
            property bool displayColor: root.state === "lockState" && Config.lockScreenUseBackgroundColor || root.state === "loginState" && Config.loginScreenUseBackgroundColor
            property string placeholder: Config.animatedBackgroundPlaceholder // Idea stolen from astronaut-theme. Not a fan of it, but works...

            anchors.fill: parent
            source: !isVideo ? `backgrounds/${tsource}` : ""
            cache: true
            mipmap: true

            function updateVideo() {
                if (isVideo && tsource.toString().length > 0) {
                    backgroundVideo.source = Qt.resolvedUrl(`backgrounds/${tsource}`);

                    if (placeholder.length > 0)
                        source = `backgrounds/${placeholder}`;
                }
            }

            onSourceChanged: {
                updateVideo();
            }
            Component.onCompleted: {
                updateVideo();
            }
            onStatusChanged: {
                if (status === Image.Error && source !== "backgrounds/default.jpg") {
                    source = "backgrounds/default.jpg";
                }
            }

            Rectangle {
                id: backgroundColor
                anchors.fill: parent
                anchors.margins: 0
                color: root.state === "lockState" && Config.lockScreenUseBackgroundColor ? Config.lockScreenBackgroundColor : root.state === "loginState" && Config.loginScreenUseBackgroundColor ? Config.loginScreenBackgroundColor : "black"
                visible: parent.displayColor || (backgroundVideo.visible && parent.placeholder.length === 0)
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
                onErrorOccurred: {
                    if (error !== MediaPlayer.NoError && backgroundImage.placeholder.length === 0)
                        backgroundImage.displayColor = true;
                }
            }
        }
        MultiEffect {
            // Background blur
            id: backgroundBlur
            source: backgroundImage
            anchors.fill: backgroundImage
            blurEnabled: backgroundImage.visible
            blur: 1.0
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
                    loginScreen.resetFocus();
                }
            }
            LoginScreen {
                id: loginScreen
                z: root.state === "loginState" ? 2 : 1
                anchors.fill: parent
                enabled: root.state === "loginState"
                opacity: 0.0
                onClose: {
                    root.state = "lockState";
                }
            }
        }
    }
}
