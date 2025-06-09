import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ColumnLayout {
    id: selector
    width: Config.layoutPopupWidth

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

    ListView {
        id: layoutList
        Layout.preferredWidth: parent.width
        Layout.preferredHeight: Math.min(keyboard.layouts.length * (Config.menuAreaPopupsItemHeight + 5 + spacing) - spacing, Config.menuAreaPopupsMaxHeight)
        orientation: ListView.Vertical
        interactive: true
        clip: true
        boundsBehavior: Flickable.StopAtBounds
        spacing: Config.menuAreaPopupsSpacing
        highlightFollowsCurrentItem: true
        highlightMoveDuration: 0
        contentHeight: keyboard.layouts.length * (Config.menuAreaPopupsItemHeight + 5 + spacing) - spacing

        // TODO: Fix scrollbar
        ScrollBar.vertical: ScrollBar {
            id: scrollbar
            policy: layoutList.contentHeight > layoutList.height ? ScrollBar.AlwaysOn : ScrollBar.AlwaysOff
            padding: 0
            rightPadding: visible ? 2 : 0
            contentItem: Rectangle {
                implicitWidth: 5
                radius: 5
                color: Config.menuAreaPopupsActiveOptionBackgroundColor
                opacity: Config.menuAreaPopupsActiveOptionBackgroundOpacity
            }
        }

        model: keyboard.layouts

        delegate: Rectangle {
            width: childrenRect.width
            height: childrenRect.height
            color: "transparent"

            Rectangle {
                anchors.fill: parent
                color: Config.menuAreaPopupsActiveOptionBackgroundColor
                opacity: index === currentLayoutIndex ? Config.menuAreaPopupsActiveOptionBackgroundOpacity : (mouseArea.containsMouse ? Config.menuAreaPopupsActiveOptionBackgroundOpacity : 0.0)
                radius: 5
            }

            RowLayout {
                width: Config.layoutPopupWidth
                height: Config.menuAreaPopupsItemHeight + 5
                spacing: 0

                Rectangle {
                    Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                    Layout.preferredHeight: parent.height
                    Layout.preferredWidth: Layout.preferredHeight
                    color: "transparent"

                    Image {
                        anchors.centerIn: parent
                        source: `/usr/share/sddm/flags/${shortName}.png`
                        width: Config.menuAreaPopupsIconSize
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
                        color: index === currentLayoutIndex ? Config.menuAreaPopupsActiveContentColor : Config.menuAreaPopupsContentColor
                        font.pixelSize: Config.menuAreaPopupsFontSize
                        font.family: Config.menuAreaPopupsFontFamily
                        elide: Text.ElideRight
                    }

                    Text {
                        width: parent.width - 5
                        text: longName
                        color: index === currentLayoutIndex ? Config.menuAreaPopupsActiveContentColor : Config.menuAreaPopupsContentColor
                        opacity: 0.75
                        font.pixelSize: Config.menuAreaPopupsFontSize - 2
                        font.family: Config.menuAreaPopupsFontFamily
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
