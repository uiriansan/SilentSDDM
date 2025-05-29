import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// Custom TextField that doesn't hide the placeholder when it gets focused.
// Why the hell isn't this the default behavior???????????????????
Item {
    id: passwordInput

    property alias text: textField.text
    property bool enabled: true
    property alias input: textField

    signal accepted

    width: Config.passwordInputWidth
    height: Config.passwordInputHeight

    TextField {
        id: textField
        anchors.fill: parent
        color: Config.passwordInputTextColor
        enabled: passwordInput.enabled
        echoMode: TextInput.Password
        activeFocusOnTab: true
        focus: true
        selectByMouse: true
        verticalAlignment: TextField.AlignVCenter
        font.family: Config.fontFamily
        font.pixelSize: Config.passwordInputFontSize
        background: Rectangle {
            id: backgroundRect
            anchors.fill: parent
            color: Config.passwordInputBackgroundColor
            opacity: Config.passwordInputBackgroundOpacity
            radius: 10
        }
        leftPadding: 10
        rightPadding: 10
        onAccepted: passwordInput.accepted()
    }

    Label {
        id: placeholderLabel
        anchors.fill: parent
        anchors.leftMargin: textField.leftPadding
        anchors.rightMargin: textField.rightPadding
        visible: textField.text.length === 0
        text: textConstants.password
        color: Config.passwordInputTextColor
        font.pixelSize: Config.passwordInputFontSize
        font.family: textField.font.family
        font.italic: true
        verticalAlignment: textField.verticalAlignment
        elide: Text.ElideRight
    }
}
