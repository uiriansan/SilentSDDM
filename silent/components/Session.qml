import QtQuick 2.5

Item {
    id: sessionSelector
    height: 30

    // Current session index
    property int currentSessionIndex: sessionModel.lastIndex >= 0 ? sessionModel.lastIndex : 0
    property string sessionName: ""
    property string sessionIconPath: ""
    property bool popupVisible: false

    function getSessionIcon(name) {
        const s = name.split(" ")[0].toLowerCase();
        const available_session_icons = ["hyprland", "kde", "gnome", "ubuntu", "sway"];
        if (s && available_session_icons.includes(s)) {
            return "icons/" + s + "-session.svg";
        }
        return "icons/default-session.svg";
    }

    // Session button
    Rectangle {
        id: sessionButton
        anchors.left: parent.left
        width: childrenRect.width
        height: 30
        // color: sessionMouseArea.pressed ? "#333333" : (sessionMouseArea.containsMouse ? "#222222" : "#1d1d1d")
        color: "transparent"
        radius: 4
        // opacity: 0.15

        Image {
            id: sessionIcon
            // source: sessionIcon
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
            width: 15
            height: 15
            sourceSize.width: 15
            sourceSize.height: 15
        }
        // Current session name
        Text {
            id: sessionNameText
            anchors.left: sessionIcon.right
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            anchors.verticalCenter: sessionButton.verticalCenter
            color: "white"
            font.pixelSize: 10
        }

        MouseArea {
            id: sessionMouseArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                sessionPopup.visible = !sessionPopup.visible;
            }
        }
    }

    // Session popup
    Rectangle {
        id: sessionPopup
        width: childrenRect.width
        height: Math.min(sessionModel.rowCount() * 40, 300)
        visible: popupVisible
        color: "#2d2d2d"
        border.color: "#3daee9"
        border.width: 1
        radius: 4
        anchors.bottom: sessionButton.top
        anchors.bottomMargin: 5

        // Simple session list without ScrollBar (for compatibility)
        ListView {
            id: sessionList
            anchors.fill: parent
            anchors.margins: 5
            orientation: ListView.Vertical
            spacing: 2
            interactive: false

            model: sessionModel
            currentIndex: sessionModel.lastIndex

            delegate: Rectangle {
                width: sessionPopup.width - 10
                height: 40
                color: index === currentSessionIndex ? "#3daee9" : "black"
                radius: 3

                Image {
                    id: sessionListIcon
                    anchors {
                        left: parent.left
                        leftMargin: 10
                        verticalCenter: parent.verticalCenter
                    }
                    source: getSessionIcon(name)
                }
                // Session name
                Text {
                    anchors.left: sessionListIcon.right
                    anchors.leftMargin: 10
                    anchors.verticalCenter: parent.verticalCenter
                    text: name
                    color: "white"
                    font.pixelSize: 14
                }

                Component.onCompleted: {
                    if (index === sessionList.currentIndex) {
                        sessionName = name;
                        sessionNameText.text = (name.length > 25) ? name.slice(0, 24) + '...' : name;
                        sessionIconPath = getSessionIcon(name);
                        sessionIcon.source = sessionIconPath;
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        // sessionModel.lastIndex = index
                        currentSessionIndex = index;
                        sessionList.currentIndex = index;
                        sessionName = name;
                        sessionNameText.text = (name.length > 25) ? name.slice(0, 24) + '...' : name;
                        popupVisible = false;
                        sessionPopup.visible = false;
                    }
                }
            }
        }
    }
}
