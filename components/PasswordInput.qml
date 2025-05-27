import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

// Custom TextField that doesn't hide the placeholder when it gets focused.
// Why the hell isn't that the default behavior???????????????????
Item {
    id: passwordInput

    property alias text: textField.text
    property bool enabled: true
    property alias input: textField

    signal accepted

    width: 200
    height: 30

    TextField {
        id: textField
        anchors.fill: parent
        color: "#FFFFFF"
        enabled: passwordInput.enabled
        echoMode: TextInput.Password
        activeFocusOnTab: true
        focus: true
        selectByMouse: true
        verticalAlignment: TextField.AlignVCenter
        font.family: "RedHatDisplay"
        font.pointSize: 8
        background: Rectangle {
            id: backgroundRect
            anchors.fill: parent
            color: "#FFFFFF"
            opacity: 0.15
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
        color: "#FFFFFF"
        font.family: textField.font.family
        font.italic: true
        verticalAlignment: textField.verticalAlignment
        elide: Text.ElideRight
    }
}
