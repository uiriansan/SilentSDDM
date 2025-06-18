import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

// Enhanced PasswordInput with improved accessibility, focus states, and error handling
Item {
    id: passwordInput

    signal accepted
    signal errorOccurred(string message)

    property alias input: textField
    property alias text: textField.text
    property bool enabled: true
    property bool hasError: false
    property string errorMessage: ""
    property bool isActive: textField.activeFocus
    
    width: Config.passwordInputWidth
    height: Config.passwordInputHeight

    // Error shake animation - Fixed to use relative values
    property real originalX: x
    SequentialAnimation {
        id: shakeAnimation
        running: false
        onStarted: originalX = passwordInput.x
        NumberAnimation {
            target: passwordInput
            property: "x"
            to: originalX + 5
            duration: 50
        }
        NumberAnimation {
            target: passwordInput
            property: "x"
            to: originalX - 5
            duration: 50
        }
        NumberAnimation {
            target: passwordInput
            property: "x"
            to: originalX + 3
            duration: 50
        }
        NumberAnimation {
            target: passwordInput
            property: "x"
            to: originalX
            duration: 50
        }
    }

    function triggerError(message) {
        hasError = true;
        errorMessage = message;
        if (Config.enableAnimations) {
            shakeAnimation.start();
        }
        errorTimer.start();
        errorOccurred(message);
    }

    function clearError() {
        hasError = false;
        errorMessage = "";
    }

    Timer {
        id: errorTimer
        interval: 3000
        onTriggered: clearError()
    }

    TextField {
        id: textField
        anchors.fill: parent
        color: passwordInput.hasError ? Config.warningMessageErrorColor : Config.passwordInputContentColor
        enabled: passwordInput.enabled
        echoMode: TextInput.Password
        activeFocusOnTab: true
        selectByMouse: true
        verticalAlignment: TextField.AlignVCenter
        font.family: Config.passwordInputFontFamily
        font.pixelSize: Config.passwordInputFontSize
        
        // Enhanced background with focus and error states
        background: Rectangle {
            anchors.fill: parent
            color: Config.passwordInputBackgroundColor
            opacity: passwordInput.hasError ? 0.3 :
                     textField.activeFocus ? Config.passwordInputBackgroundOpacity + 0.1 :
                     Config.passwordInputBackgroundOpacity
            topLeftRadius: Config.passwordInputBorderRadiusLeft
            bottomLeftRadius: Config.passwordInputBorderRadiusLeft
            topRightRadius: Config.passwordInputBorderRadiusRight
            bottomRightRadius: Config.passwordInputBorderRadiusRight
            
            // Smooth opacity transitions
            Behavior on opacity {
                enabled: Config.enableAnimations
                NumberAnimation { duration: 200 }
            }
            
            // Subtle glow effect when focused
            layer.enabled: textField.activeFocus && Config.enableAnimations
            layer.effect: MultiEffect {
                shadowEnabled: true
                shadowColor: passwordInput.hasError ? Config.warningMessageErrorColor : Config.passwordInputContentColor
                shadowOpacity: 0.3
                shadowBlur: 8
                shadowHorizontalOffset: 0
                shadowVerticalOffset: 0
            }
        }
        
        leftPadding: Config.passwordInputDisplayIcon ? iconContainer.width + 2 : 10
        rightPadding: 10
        onAccepted: passwordInput.accepted()
        onTextChanged: {
            if (passwordInput.hasError && text.length > 0) {
                passwordInput.clearError();
            }
        }

        // Configurable border
        Rectangle {
            anchors.fill: parent
            border.width: Config.passwordInputBorderSize
            border.color: Config.passwordInputBorderColor
            color: "transparent"
            topLeftRadius: Config.passwordInputBorderRadiusLeft
            bottomLeftRadius: Config.passwordInputBorderRadiusLeft
            topRightRadius: Config.passwordInputBorderRadiusRight
            bottomRightRadius: Config.passwordInputBorderRadiusRight
        }

        Row {
            anchors.fill: parent
            spacing: 0
            leftPadding: Config.passwordInputDisplayIcon ? 2 : 10

            Rectangle {
                id: iconContainer
                color: "transparent"
                visible: Config.passwordInputDisplayIcon
                height: parent.height
                width: height

                Image {
                    id: icon
                    source: Config.getIcon(Config.passwordInputIcon)
                    anchors.centerIn: parent
                    width: Config.passwordInputIconSize
                    height: width
                    sourceSize: Qt.size(width, height)
                    fillMode: Image.PreserveAspectFit
                    opacity: passwordInput.enabled ?
                            (passwordInput.hasError ? 0.8 : 1.0) : 0.3
                    
                    // Enhanced opacity transitions
                    Behavior on opacity {
                        enabled: Config.enableAnimations
                        NumberAnimation { duration: 200 }
                    }

                    // Icon color with error state support
                    MultiEffect {
                        source: parent
                        anchors.fill: parent
                        colorization: 1
                        colorizationColor: passwordInput.hasError ? Config.warningMessageErrorColor : textField.color
                        
                        // Smooth color transitions
                        Behavior on colorizationColor {
                            enabled: Config.enableAnimations
                            ColorAnimation { duration: 200 }
                        }
                    }
                    
                    // Subtle pulse animation when focused
                    SequentialAnimation {
                        running: textField.activeFocus && Config.enableAnimations
                        loops: Animation.Infinite
                        NumberAnimation {
                            target: icon
                            property: "scale"
                            to: 1.05
                            duration: 1000
                            easing.type: Easing.InOutSine
                        }
                        NumberAnimation {
                            target: icon
                            property: "scale"
                            to: 1.0
                            duration: 1000
                            easing.type: Easing.InOutSine
                        }
                    }
                }
            }

            Text {
                id: placeholderLabel
                anchors {
                    verticalCenter: parent.verticalCenter
                }
                padding: 0
                visible: textField.text.length === 0 && textField.preeditText.length === 0
                text: passwordInput.hasError ? passwordInput.errorMessage : textConstants.password
                color: passwordInput.hasError ? Config.warningMessageErrorColor :
                       textField.activeFocus ? Qt.lighter(textField.color, 1.2) :
                       Qt.darker(textField.color, 1.3)
                font.pixelSize: textField.font.pixelSize
                font.family: textField.font.family
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: textField.verticalAlignment
                font.italic: !passwordInput.hasError
                font.weight: passwordInput.hasError ? Font.Medium : Font.Normal
                
                // Smooth color and text transitions
                Behavior on color {
                    enabled: Config.enableAnimations
                    ColorAnimation { duration: 200 }
                }
                
                // Subtle fade animation for placeholder
                Behavior on opacity {
                    enabled: Config.enableAnimations
                    NumberAnimation { duration: 150 }
                }
            }
        }
    }
}
