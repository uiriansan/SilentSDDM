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
        font.family: Config.passwordInputFontFamily
        font.pixelSize: Config.passwordInputFontSize
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
                    source: Config.getIcon(Config.passwordInputIcon)
                    anchors.centerIn: parent
                    width: Config.passwordInputIconSize
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
                visible: textField.text.length === 0 && textField.preeditText.length === 0
                text: textConstants.password
                color: textField.color
                font.pixelSize: textField.font.pixelSize
                font.family: textField.font.family
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: textField.verticalAlignment
                font.italic: true
            }
        }
    }
}
