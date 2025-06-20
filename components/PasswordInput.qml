import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects

// Custom TextField that doesn't hide the placeholder when it gets focused.
// Why the hell isn't this the default behavior???????????????????
Item {
    id: passwordInput

    signal accepted

    property alias input: textField
    property alias text: textField.text
    property bool enabled: true

    width: Config.passwordInputWidth
    height: Config.passwordInputHeight

    TextField {
        id: textField
        anchors.fill: parent
        color: Config.passwordInputContentColor
        enabled: passwordInput.enabled
        echoMode: TextInput.Password
        activeFocusOnTab: true
        selectByMouse: true
        verticalAlignment: TextField.AlignVCenter
        // FIX: Font properties null safety
        font.family: Config.passwordInputFontFamily || "sans-serif"
        font.pixelSize: Math.max(8, Config.passwordInputFontSize || 12)
        background: Rectangle {
            anchors.fill: parent
            color: Config.passwordInputBackgroundColor
            opacity: Config.passwordInputBackgroundOpacity
            topLeftRadius: Config.passwordInputBorderRadiusLeft
            bottomLeftRadius: Config.passwordInputBorderRadiusLeft
            topRightRadius: Config.passwordInputBorderRadiusRight
            bottomRightRadius: Config.passwordInputBorderRadiusRight
        }
        leftPadding: placeholderLabel.x
        rightPadding: 10
        onAccepted: passwordInput.accepted()

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
                    // FIX: Icon source null safety
                    source: Config.passwordInputIcon ? Config.getIcon(Config.passwordInputIcon) : ""
                    anchors.centerIn: parent
                    // FIX: Icon size safety
                    width: Math.max(1, Config.passwordInputIconSize || 16)
                    height: width
                    sourceSize: Qt.size(width, height)
                    fillMode: Image.PreserveAspectFit
                    opacity: passwordInput.enabled ? 1.0 : 0.3
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
                // FIX: Preedit text null safety and improved visibility check
                visible: textField.text.length === 0 && (!textField.preeditText || textField.preeditText.length === 0)
                // FIX: Text constants null safety
                text: (textConstants && textConstants.password) ? textConstants.password : "Password"
                color: textField.color
                // FIX: Font size null safety
                font.pixelSize: Math.max(8, textField.font.pixelSize || 12)
                font.family: textField.font.family || "sans-serif"
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: textField.verticalAlignment
                font.italic: true
            }
        }
    }
}
