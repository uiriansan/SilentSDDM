import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

Item {
    id: input

    signal accepted

    property string placeholder: ""
    property alias input: textField
    property bool isPassword: false
    property bool splitBorderRadius: false
    property alias text: textField.text
    property string icon: ""
    property bool enabled: true
    property int inputMethodHints: Qt.ImhNone

    width: Config.passwordInputWidth * Config.automaticScale(Screen.devicePixelRatio)
    height: Config.passwordInputHeight * Config.automaticScale(Screen.devicePixelRatio)

    TextField {
        id: textField
        anchors.fill: parent
        inputMethodHints: input.inputMethodHints
        color: Config.passwordInputContentColor
        enabled: input.enabled
        echoMode: input.isPassword ? TextInput.Password : TextInput.Normal
        passwordCharacter: Config.passwordInputMaskedCharacter
        activeFocusOnTab: true
        selectByMouse: true
        verticalAlignment: TextField.AlignVCenter
        font.family: Config.passwordInputFontFamily
        font.pixelSize: Math.max(8, Config.passwordInputFontSize * Config.automaticScale(Screen.devicePixelRatio))
        background: Rectangle {
            anchors.fill: parent
            color: Config.passwordInputBackgroundColor
            opacity: Config.passwordInputBackgroundOpacity
            topLeftRadius: Config.passwordInputBorderRadiusLeft * Config.automaticScale(Screen.devicePixelRatio)
            bottomLeftRadius: Config.passwordInputBorderRadiusLeft * Config.automaticScale(Screen.devicePixelRatio)
            topRightRadius: input.splitBorderRadius ? Config.passwordInputBorderRadiusRight * Config.automaticScale(Screen.devicePixelRatio) : Config.passwordInputBorderRadiusLeft * Config.automaticScale(Screen.devicePixelRatio)
            bottomRightRadius: input.splitBorderRadius ? Config.passwordInputBorderRadiusRight * Config.automaticScale(Screen.devicePixelRatio) : Config.passwordInputBorderRadiusLeft * Config.automaticScale(Screen.devicePixelRatio)
        }
        leftPadding: placeholderLabel.x
        rightPadding: 10
        onAccepted: input.accepted()

        Rectangle {
            anchors.fill: parent
            border.width: Config.passwordInputBorderSize * Config.automaticScale(Screen.devicePixelRatio)
            border.color: Config.passwordInputBorderColor
            color: "transparent"
            topLeftRadius: Config.passwordInputBorderRadiusLeft * Config.automaticScale(Screen.devicePixelRatio)
            bottomLeftRadius: Config.passwordInputBorderRadiusLeft * Config.automaticScale(Screen.devicePixelRatio)
            topRightRadius: input.splitBorderRadius ? Config.passwordInputBorderRadiusRight * Config.automaticScale(Screen.devicePixelRatio) : Config.passwordInputBorderRadiusLeft * Config.automaticScale(Screen.devicePixelRatio)
            bottomRightRadius: input.splitBorderRadius ? Config.passwordInputBorderRadiusRight * Config.automaticScale(Screen.devicePixelRatio) : Config.passwordInputBorderRadiusLeft * Config.automaticScale(Screen.devicePixelRatio)
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
                    source: input.icon
                    anchors.centerIn: parent
                    width: Math.max(1, Config.passwordInputIconSize * Config.automaticScale(Screen.devicePixelRatio))
                    height: width
                    sourceSize: Qt.size(width, height)
                    fillMode: Image.PreserveAspectFit
                    opacity: input.enabled ? 1.0 : 0.3
                    Behavior on opacity {
                        enabled: Config.enableAnimations
                        NumberAnimation {
                            duration: 250
                        }
                    }

                    MultiEffect {
                        source: parent
                        anchors.fill: parent
                        colorization: 1
                        colorizationColor: textField.color
                    }
                }
            }

            Text {
                id: placeholderLabel
                anchors {
                    verticalCenter: parent.verticalCenter
                }
                padding: 0
                visible: textField.text.length === 0 && (!textField.preeditText || textField.preeditText.length === 0)
                text: input.placeholder
                color: textField.color
                font.pixelSize: Math.max(8, textField.font.pixelSize || 12)
                font.family: textField.font.family || "sans-serif"
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: textField.verticalAlignment
                font.italic: true
            }
        }
    }
}
