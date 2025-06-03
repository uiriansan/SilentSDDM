import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ColumnLayout {
    id: selector
    width: 200
    spacing: 2

    signal layoutChanged(layoutIndex: int)

    property int currentLayoutIndex: keyboard.currentLayout ? keyboard.currentLayout : 0
    property string layoutName: ""
    property string layoutShortName: ""

    Repeater {
        id: layoutsList

        model: keyboard.layouts

        delegate: Rectangle {
            width: childrenRect.width
            height: childrenRect.height
            color: "transparent"

            Rectangle {
                anchors.fill: parent
                color: Config.menuAreaPopupActiveOptionBackgroundColor
                opacity: index === currentLayoutIndex ? Config.menuAreaPopupActiveOptionBackgroundOpacity : (mouseArea.containsMouse ? Config.menuAreaPopupActiveOptionBackgroundOpacity : 0.0)
                radius: 5
            }

            RowLayout {
                width: 200
                height: 35
                spacing: 0

                Rectangle {
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    Layout.preferredHeight: parent.height
                    Layout.preferredWidth: Layout.preferredHeight
                    color: "transparent"

                    Image {
                        anchors.centerIn: parent
                        source: `/usr/share/sddm/flags/${shortName}.png`
                        width: 16
                        height: width
                        sourceSize: Qt.size(width, height)
                        fillMode: Image.PreserveAspectFit
                    }
                }

                Column {
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    Layout.fillWidth: true

                    Text {
                        text: Languages.getLabelFor(shortName)
                        visible: text && text.length > 0
                        color: index === currentLayoutIndex ? Config.menuAreaPopupActiveContentColor : Config.menuAreaPopupContentColor
                        font.pixelSize: Config.menuAreaPopupFontSize
                        font.family: Config.fontFamily
                    }

                    Text {
                        text: longName
                        color: index === currentLayoutIndex ? Config.menuAreaPopupActiveContentColor : Config.menuAreaPopupContentColor
                        opacity: 0.75
                        font.pixelSize: Config.menuAreaPopupFontSize - 2
                        font.family: Config.fontFamily
                    }
                }
            }

            Component.onCompleted: {
                if (index === selector.currentLayoutIndex) {
                    selector.layoutName = longName;
                    selector.layoutShortName = shortName;
                    selector.layoutChanged(selector.currentLayoutIndex);
                }
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                enabled: index !== selector.currentLayoutIndex
                hoverEnabled: index !== selector.currentLayoutIndex
                z: 2
                cursorShape: hoverEnabled ? Qt.PointingHandCursor : Qt.ArrowCursor
                onClicked: {
                    selector.currentLayoutIndex = index;
                    keyboard.currentLayout = index;
                    selector.layoutName = longName;
                    selector.layoutShortName = shortName;
                    selector.layoutChanged(selector.currentLayoutIndex);
                }
            }
        }
    }
}
