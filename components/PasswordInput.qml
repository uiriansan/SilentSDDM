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
        color: Config.passwordInputTextColor
        enabled: passwordInput.enabled
        echoMode: TextInput.Password
        activeFocusOnTab: true
        selectByMouse: true
        verticalAlignment: TextField.AlignVCenter
        font.family: Config.fontFamily
        font.pixelSize: Config.passwordInputFontSize
        background: Rectangle {
            anchors.fill: parent
            color: Config.passwordInputBackgroundColor
            opacity: Config.passwordInputBackgroundOpacity
            radius: 10
        }
        leftPadding: placeholderLabel.x
        rightPadding: 10
        onAccepted: passwordInput.accepted()

        Rectangle {
            id: iconContainer
            height: parent.height
            width: height
            anchors {
                verticalCenter: parent.verticalCenter
                left: parent.left
                leftMargin: 3
            }
            color: "transparent"

            Image {
                id: icon
                source: "icons/password.svg"
                anchors.centerIn: parent
                width: 16
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

        Label {
            id: placeholderLabel
            anchors {
                verticalCenter: parent.verticalCenter
                left: iconContainer.right
                leftMargin: 0
            }
            padding: 0
            visible: textField.text.length === 0 && textField.preeditText.length === 0
            text: textConstants.password
            color: textField.color
            font.pixelSize: textField.font.pixelSize
            font.family: textField.font.family
            font.italic: true
            verticalAlignment: textField.verticalAlignment
            elide: Text.ElideRight
        }
    }
}
