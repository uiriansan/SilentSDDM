import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects

ColumnLayout {
    id: selector
    width: Config.sessionMaxWidth

    signal sessionChanged(sessionIndex: int, iconPath: string, label: string)
    signal close

    property int currentSessionIndex: sessionModel.lastIndex >= 0 ? sessionModel.lastIndex : 0
    property string sessionName: ""
    property string sessionIconPath: ""

    function getSessionIcon(name) {
        const available_session_icons = ["hyprland", "kde", "gnome", "ubuntu", "sway", "awesome", "qtile", "i3", "bspwm", "dwm", "xfce", "cinnamon", "niri"];
        for (let i = 0; i < available_session_icons.length; i++) {
            if (name && name.toLowerCase().includes(available_session_icons[i]))
                return `../icons/sessions/${available_session_icons[i]}.svg`;
        }
        return "../icons/sessions/default.svg";
    }

    ListView {
        id: sessionList
        Layout.preferredWidth: Config.sessionMaxWidth
        Layout.preferredHeight: Math.min(sessionModel.rowCount() * (Config.menuAreaPopupsItemHeight + spacing), Config.menuAreaPopupsMaxHeight)
        orientation: ListView.Vertical
        interactive: true
        clip: true
        boundsBehavior: Flickable.StopAtBounds
        spacing: Config.menuAreaPopupsSpacing
        highlightFollowsCurrentItem: true
        highlightMoveDuration: 0
        contentHeight: sessionModel.rowCount() * (Config.menuAreaPopupsItemHeight + spacing)

        ScrollBar.vertical: ScrollBar {
            id: scrollbar
            policy: sessionList.contentHeight > sessionList.height ? ScrollBar.AlwaysOn : ScrollBar.AlwaysOff
            padding: 0
            rightPadding: visible ? 2 : 0
            contentItem: Rectangle {
                implicitWidth: 5
                radius: 5
                color: Config.menuAreaPopupsActiveOptionBackgroundColor
                opacity: Config.menuAreaPopupsActiveOptionBackgroundOpacity
            }
        }

        model: sessionModel
        currentIndex: selector.currentSessionIndex
        onCurrentIndexChanged: {
            const session_name = sessionModel.data(sessionModel.index(currentIndex, 0), 260);

            selector.currentSessionIndex = currentIndex;
            selector.sessionName = session_name;
            selector.sessionChanged(selector.currentSessionIndex, getSessionIcon(session_name), session_name);
        }

        delegate: Rectangle {
            width: scrollbar.visible ? parent.width - 10 : parent.width - 5
            height: Config.menuAreaPopupsItemHeight
            color: "transparent"
            radius: 5

            Rectangle {
                anchors.fill: parent
                color: Config.menuAreaPopupsActiveOptionBackgroundColor
                opacity: index === selector.currentSessionIndex ? Config.menuAreaPopupsActiveOptionBackgroundOpacity : (itemMouseArea.containsMouse ? Config.menuAreaPopupsActiveOptionBackgroundOpacity : 0.0)
                radius: 5
            }

            RowLayout {
                anchors.fill: parent

                Rectangle {
                    Layout.preferredWidth: parent.height
                    Layout.preferredHeight: parent.height
                    Layout.alignment: Qt.AlignVCenter
                    color: "transparent"

                    Image {
                        anchors.centerIn: parent
                        source: selector.getSessionIcon(name)
                        width: Config.menuAreaPopupsIconSize
                        height: Config.menuAreaPopupsIconSize
                        sourceSize: Qt.size(width, height)
                        fillMode: Image.PreserveAspectFit

                        MultiEffect {
                            source: parent
                            anchors.fill: parent
                            colorization: 1
                            colorizationColor: index === selector.currentSessionIndex ? Config.menuAreaPopupsActiveContentColor : Config.menuAreaPopupsContentColor
                        }
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: parent.height
                    Layout.alignment: Qt.AlignVCenter
                    color: "transparent"

                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        // text: (name.length > 25) ? name.slice(0, 24) + '...' : name
                        text: name
                        color: index === selector.currentSessionIndex ? Config.menuAreaPopupsActiveContentColor : Config.menuAreaPopupsContentColor
                        font.pixelSize: Config.menuAreaPopupsFontSize
                        font.family: Config.menuAreaPopupsFontFamily
                    }
                }
            }

            MouseArea {
                id: itemMouseArea
                anchors.fill: parent
                z: 2
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onClicked: {
                    sessionList.currentIndex = index;
                }
            }
        }
    }

    Keys.onPressed: event => {
        if (event.key === Qt.Key_Down) {
            sessionList.currentIndex = (sessionList.currentIndex + sessionModel.rowCount() + 1) % sessionModel.rowCount();
        } else if (event.key === Qt.Key_Up) {
            sessionList.currentIndex = (sessionList.currentIndex + sessionModel.rowCount() - 1) % sessionModel.rowCount();
        } else if (event.key == Qt.Key_Return || event.key == Qt.Key_Enter || event.key === Qt.Key_Space) {
            selector.close();
        }
    }
}
