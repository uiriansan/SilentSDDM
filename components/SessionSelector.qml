import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Effects

ColumnLayout {
    id: selector
    width: (Config.sessionPopupWidth - Config.menuAreaPopupsPadding * 2) * Config.generalScale

    signal sessionChanged(sessionIndex: int, iconPath: string, label: string)
    signal close

    property int currentSessionIndex: (sessionModel && sessionModel.lastIndex >= 0) ? sessionModel.lastIndex : 0
    property string sessionName: ""
    property string sessionIconPath: ""

    function getSessionIcon(name) {
        var available_session_icons = ["hyprland", "plasma", "gnome", "ubuntu", "sway", "awesome", "qtile", "i3", "bspwm", "dwm", "xfce", "cinnamon", "niri"];
        for (var i = 0; i < available_session_icons.length; i++) {
            if (name && name.toLowerCase().includes(available_session_icons[i]))
                return "../icons/sessions/" + available_session_icons[i] + ".svg";
        }
        return "../icons/sessions/default.svg";
    }

    ListView {
        id: sessionList
        Layout.preferredWidth: parent.width
        Layout.preferredHeight: Math.min((sessionModel ? sessionModel.rowCount() : 0) * (Config.menuAreaPopupsItemHeight * Config.generalScale + spacing), Config.menuAreaPopupsMaxHeight * Config.generalScale)
        orientation: ListView.Vertical
        interactive: true
        clip: true
        boundsBehavior: Flickable.StopAtBounds
        spacing: Config.menuAreaPopupsSpacing
        highlightFollowsCurrentItem: true
        highlightMoveDuration: 0
        contentHeight: sessionModel.rowCount() * (Config.menuAreaPopupsItemHeight * Config.generalScale + spacing)

        ScrollBar.vertical: ScrollBar {
            id: scrollbar
            policy: Config.menuAreaPopupsDisplayScrollbar && sessionList.contentHeight > sessionList.height ? ScrollBar.AlwaysOn : ScrollBar.AlwaysOff
            contentItem: Rectangle {
                id: scrollbarBackground
                implicitWidth: 5 * Config.generalScale
                radius: 5 * Config.generalScale
                color: Config.menuAreaPopupsContentColor
                opacity: Config.menuAreaPopupsActiveOptionBackgroundOpacity
            }
        }

        model: sessionModel
        currentIndex: selector.currentSessionIndex
        onCurrentIndexChanged: {
            var session_name = sessionModel.data(sessionModel.index(currentIndex, 0), 260);

            selector.currentSessionIndex = currentIndex;
            selector.sessionName = session_name;
            selector.sessionChanged(selector.currentSessionIndex, getSessionIcon(session_name), session_name);
        }

        delegate: Rectangle {
            width: scrollbar.visible ? parent.width - Config.menuAreaPopupsPadding - scrollbar.width : parent.width
            height: Config.menuAreaPopupsItemHeight * Config.generalScale
            color: "transparent"
            radius: Config.menuAreaButtonsBorderRadius * Config.generalScale

            Rectangle {
                anchors.fill: parent
                color: Config.menuAreaPopupsActiveOptionBackgroundColor
                opacity: index === selector.currentSessionIndex ? Config.menuAreaPopupsActiveOptionBackgroundOpacity : (itemMouseArea.containsMouse ? Config.menuAreaPopupsActiveOptionBackgroundOpacity : 0.0)
                radius: Config.menuAreaButtonsBorderRadius * Config.generalScale
            }

            RowLayout {
                anchors.fill: parent

                Rectangle {
                    Layout.preferredWidth: parent.height
                    Layout.preferredHeight: parent.height
                    Layout.alignment: Qt.AlignVCenter
                    color: "transparent"

                    Image {
                        id: sessionIcon
                        anchors.centerIn: parent
                        source: selector.getSessionIcon(name)
                        width: Config.menuAreaPopupsIconSize * Config.generalScale
                        height: Config.menuAreaPopupsIconSize * Config.generalScale
                        sourceSize: Qt.size(width, height)
                        fillMode: Image.PreserveAspectFit
                        visible: false
                    }
                    MultiEffect {
                        id: sessionIconEffect
                        source: sessionIcon
                        anchors.fill: sessionIcon
                        colorization: 1
                        colorizationColor: index === selector.currentSessionIndex || itemMouseArea.containsMouse ? Config.menuAreaPopupsActiveContentColor : Config.menuAreaPopupsContentColor
                        antialiasing: true
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
                        color: index === selector.currentSessionIndex || itemMouseArea.containsMouse ? Config.menuAreaPopupsActiveContentColor : Config.menuAreaPopupsContentColor
                        font.pixelSize: Config.menuAreaPopupsFontSize * Config.generalScale
                        font.family: Config.menuAreaPopupsFontFamily
                    }
                }
            }

            MouseArea {
                id: itemMouseArea
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onClicked: {
                    // FIXME: Some clicks seem to be ignored
                    sessionList.currentIndex = index;
                }
            }
        }
    }

    Keys.onPressed: function (event) {
        if (event.key === Qt.Key_Down) {
            if (sessionModel.rowCount() > 0) {
                sessionList.currentIndex = (sessionList.currentIndex + sessionModel.rowCount() + 1) % sessionModel.rowCount();
            }
        } else if (event.key === Qt.Key_Up) {
            if (sessionModel.rowCount() > 0) {
                sessionList.currentIndex = (sessionList.currentIndex + sessionModel.rowCount() - 1) % sessionModel.rowCount();
            }
        } else if (event.key == Qt.Key_Return || event.key == Qt.Key_Enter || event.key === Qt.Key_Space) {
            selector.close();
        } else if (event.key === Qt.Key_CapsLock) {
            root.capsLockOn = !root.capsLockOn;
        }
    }
}
