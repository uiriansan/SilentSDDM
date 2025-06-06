import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ColumnLayout {
    id: selector
    width: 180
    height: 35
    spacing: 2

    signal layoutChanged(layoutIndex: int)
    signal close

    property int currentLayoutIndex: keyboard.currentLayout ? keyboard.currentLayout : 0
    property string layoutName: ""
    property string layoutShortName: ""

    function updateLayout() {
        keyboard.currentLayout = selector.currentLayoutIndex;
        selector.layoutName = keyboard.layouts[selector.currentLayoutIndex].longName;
        selector.layoutShortName = keyboard.layouts[selector.currentLayoutIndex].shortName;
        selector.layoutChanged(selector.currentLayoutIndex);
    }

    Component.onCompleted: {
        selector.layoutName = keyboard.layouts[selector.currentLayoutIndex].longName;
        selector.layoutShortName = keyboard.layouts[selector.currentLayoutIndex].shortName;
        selector.layoutChanged(selector.currentLayoutIndex);
    }

    // TODO: Missing layout error message

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
                width: 180
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
                        width: parent.width - 5
                        text: Languages.getLabelFor(shortName)
                        visible: text && text.length > 0
                        color: index === currentLayoutIndex ? Config.menuAreaPopupActiveContentColor : Config.menuAreaPopupContentColor
                        font.pixelSize: Config.menuAreaPopupFontSize
                        font.family: Config.fontFamily
                        elide: Text.ElideRight
                    }

                    Text {
                        width: parent.width - 5
                        text: longName
                        color: index === currentLayoutIndex ? Config.menuAreaPopupActiveContentColor : Config.menuAreaPopupContentColor
                        opacity: 0.75
                        font.pixelSize: Config.menuAreaPopupFontSize - 2
                        font.family: Config.fontFamily
                        elide: Text.ElideRight
                    }
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
                    selector.updateLayout();
                }
            }
        }
    }
    Keys.onPressed: event => {
        if (event.key === Qt.Key_Down) {
            selector.currentLayoutIndex = (selector.currentLayoutIndex + keyboard.layouts.length + 1) % keyboard.layouts.length;
            selector.updateLayout();
        } else if (event.key === Qt.Key_Up) {
            selector.currentLayoutIndex = (selector.currentLayoutIndex + keyboard.layouts.length - 1) % keyboard.layouts.length;
            selector.updateLayout();
        } else if (event.key == Qt.Key_Return || event.key == Qt.Key_Enter || event.key === Qt.Key_Space) {
            selector.close();
        }
    }
}
