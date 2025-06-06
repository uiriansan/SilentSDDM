import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects

ColumnLayout {
    id: selector
    width: 200

    signal sessionChanged(sessionIndex: int, iconPath: string, label: string)
    signal close

    property int currentSessionIndex: sessionModel.lastIndex >= 0 ? sessionModel.lastIndex : 0
    property string sessionName: ""
    property string sessionIconPath: ""

    function getSessionIcon(name) {
        const available_session_icons = ["hyprland", "kde", "gnome", "ubuntu", "sway", "awesome", "qtile", "i3", "bspwm", "dwm", "xfce", "cinnamon", "niri"];
        for (let i = 0; i < available_session_icons.length; i++) {
            if (name && name.toLowerCase().includes(available_session_icons[i]))
                return `icons/sessions/${available_session_icons[i]}.svg`;
        }
        return "icons/sessions/default.svg";
    }

    ListView {
        id: sessionList
        Layout.preferredWidth: 200
        Layout.preferredHeight: Math.min(sessionModel.rowCount() * 35, 300)
        orientation: ListView.Vertical
        interactive: true
        clip: true
        boundsBehavior: Flickable.StopAtBounds
        spacing: 2
        highlightFollowsCurrentItem: true
        highlightMoveDuration: 0

        ScrollBar.vertical: ScrollBar {
            id: scrollbar
            policy: sessionList.contentHeight > sessionList.height ? ScrollBar.AlwaysOn : ScrollBar.AlwaysOff
            padding: 0
            rightPadding: visible ? 2 : 0
            contentItem: Rectangle {
                implicitWidth: 5
                radius: 5
                color: Config.menuAreaPopupActiveOptionBackgroundColor
                opacity: Config.menuAreaPopupActiveOptionBackgroundOpacity
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
            height: 35
            color: "transparent"
            radius: 5

            Rectangle {
                anchors.fill: parent
                color: Config.menuAreaPopupActiveOptionBackgroundColor
                opacity: index === selector.currentSessionIndex ? Config.menuAreaPopupActiveOptionBackgroundOpacity : (itemMouseArea.containsMouse ? Config.menuAreaPopupActiveOptionBackgroundOpacity : 0.0)
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
                        width: Config.menuAreaPopupIconSize
                        height: Config.menuAreaPopupIconSize
                        sourceSize: Qt.size(width, height)
                        fillMode: Image.PreserveAspectFit

                        MultiEffect {
                            source: parent
                            anchors.fill: parent
                            colorization: 1
                            colorizationColor: index === selector.currentSessionIndex ? Config.menuAreaPopupActiveContentColor : Config.menuAreaPopupContentColor
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
                        color: index === selector.currentSessionIndex ? Config.menuAreaPopupActiveContentColor : Config.menuAreaPopupContentColor
                        font.pixelSize: Config.menuAreaPopupFontSize
                        font.family: Config.fontFamily
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
