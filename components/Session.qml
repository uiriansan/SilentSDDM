import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Item {
    id: sessionSelector
    height: Math.min(sessionModel.rowCount() * listEntryHeight, 300)
    width: 200

    signal sessionChanged(sessionIndex: int, icon: string, label: string)
    signal click
    // Current session index
    property int currentSessionIndex: sessionModel.lastIndex >= 0 ? sessionModel.lastIndex : 0
    property string sessionName: ""
    property string sessionIconPath: ""

    function getSessionIcon(name) {
        const available_session_icons = ["hyprland", "kde", "gnome", "ubuntu", "sway", "awesome", "qtile", "i3", "bspwm", "dwm", "xfce", "cinnamon", "niri"];
        for (let i = 0; i < available_session_icons.length; i++) {
            if (name && name.toLowerCase().includes(available_session_icons[i]))
                return "icons/sessions/" + available_session_icons[i] + ".svg";
        }
        return "icons/sessions/default.svg";
    }

    readonly property int listEntryHeight: 30

    // Session popup

    Rectangle {
        anchors.fill: parent
        color: Config.menuAreaPopupBackgroundColor
        opacity: Config.menuAreaPopupBackgroundOpacity
        radius: 5
    }

    ScrollView {
        anchors.fill: parent
        ScrollBar.vertical.policy: ScrollBar.AlwaysOn
        ScrollBar.vertical.interactive: true
        ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

        // Simple session list without ScrollBar (for compatibility)
        ListView {
            id: sessionList
            z: 2
            height: sessionSelector.height
            width: parent.width
            anchors.fill: parent
            anchors.margins: 5
            anchors.rightMargin: 13
            orientation: ListView.Vertical
            interactive: true
            clip: true
            boundsBehavior: Flickable.StopAtBounds

            model: sessionModel
            currentIndex: sessionModel.lastIndex

            spacing: 2
            keyNavigationEnabled: true
            keyNavigationWraps: true

            delegate: Rectangle {
                z: 2
                width: 200
                height: listEntryHeight
                color: "transparent"
                radius: 5

                Rectangle {
                    anchors.fill: parent
                    color: Config.menuAreaPopupActiveOptionBackgroundColor
                    opacity: index === currentSessionIndex ? Config.menuAreaPopupActiveOptionBackgroundOpacity : (itemMouseArea.containsMouse ? Config.menuAreaPopupActiveOptionBackgroundOpacity : 0.0)
                    radius: 5
                }

                Image {
                    id: sessionListIcon
                    anchors {
                        left: parent.left
                        leftMargin: 10
                        verticalCenter: parent.verticalCenter
                    }
                    source: getSessionIcon(name)
                    width: Config.menuAreaPopupIconSize
                    height: Config.menuAreaPopupIconSize
                    sourceSize: Qt.size(width, height)
                    fillMode: Image.PreserveAspectFit

                    MultiEffect {
                        source: sessionListIcon
                        anchors.fill: sessionListIcon
                        colorization: 1
                        colorizationColor: index === currentSessionIndex ? Config.menuAreaPopupActiveContentColor : Config.menuAreaPopupContentColor
                    }
                }
                // Session name
                Text {
                    anchors.left: sessionListIcon.right
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    text: (name.length > 25) ? name.slice(0, 24) + '...' : name
                    color: index === currentSessionIndex ? Config.menuAreaPopupActiveContentColor : Config.menuAreaPopupContentColor
                    font.pixelSize: Config.menuAreaPopupFontSize
                    font.family: Config.fontFamily
                }

                Component.onCompleted: {
                    if (index === sessionList.currentIndex) {
                        sessionName = name;
                        sessionChanged(currentSessionIndex, getSessionIcon(name), (name.length > 25) ? name.slice(0, 24) + '...' : name);
                    }
                }

                MouseArea {
                    id: itemMouseArea
                    anchors.fill: parent
                    z: 2
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true
                    onClicked: {
                        currentSessionIndex = index;
                        sessionList.currentIndex = index;
                        sessionName = name;
                        sessionChanged(currentSessionIndex, getSessionIcon(name), (name.length > 25) ? name.slice(0, 24) + '...' : name);
                    }
                }
            }
        }
    }
}
