import QtQuick 2.5
import QtQuick.Controls 2.5

Item {
    id: iconButton
    width: 50
    height: 50

    property string icon: ""
    property int icon_size: 24
    property double backgroundOpacity: 0.15
    property color backgroundColor: "#FFFFFF"
    signal clicked

    Rectangle {
        id: buttonBackground
        anchors.fill: parent
        color: iconButton.backgroundColor
        radius: 10
        opacity: iconButton.backgroundOpacity
    }

    Image {
        id: buttonIcon
        source: iconButton.icon
        anchors.centerIn: parent
        width: iconButton.icon_size
        height: iconButton.icon_size
        sourceSize: Qt.size(width, height)
        fillMode: Image.PreserveAspectFit
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: iconButton.clicked()
        cursorShape: Qt.PointingHandCursor
    }
    Keys.onPressed: event => {
        if (event.key == Qt.Key_Return || event.key == Qt.Key_Enter) {
            iconButton.clicked();
        }
    }
}
