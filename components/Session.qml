import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Item {
    id: sessionSelector
    height: 30

    signal sessionChanged(sessionIndex: int)
    signal click
    // Current session index
    property int currentSessionIndex: sessionModel.lastIndex >= 0 ? sessionModel.lastIndex : 0
    property string sessionName: ""
    property string sessionIconPath: ""
    property bool popupVisible: false

    function close() {
        sessionPopup.visible = false;
        popupVisible = false;
    }

    function getSessionIcon(name) {
        const available_session_icons = ["hyprland", "kde", "gnome", "ubuntu", "sway", "plasma"];
        for (let i = 0; i < available_session_icons.length; i++) {
            if (name && name.toLowerCase().includes(available_session_icons[i]))
                return "icons/" + available_session_icons[i] + "-session.svg";
        }
        return "icons/default-session.svg";
    }

    // Session button
    Rectangle {
        id: sessionButton
        z: 0
        anchors.left: parent.left
        width: sessionPopup.width
        height: 30
        color: "transparent"
        radius: 4

        Rectangle {
            id: sessionButtonBg
            anchors.fill: parent
            color: "#FFFFFF"
            opacity: popupVisible ? 0.15 : (sessionMouseArea.containsMouse ? 0.15 : 0.0)
            radius: 5

            Behavior on opacity {
                enabled: config.enableAnimations === "false" ? false : true
                NumberAnimation {
                    duration: 250
                }
            }
        }

        Image {
            id: sessionIcon
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
            anchors.verticalCenter: sessionButton.verticalCenter
            color: "white"
            font.pixelSize: 10
        }

        MouseArea {
            id: sessionMouseArea
            z: 0
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor

            onClicked: {
                click();
            }
        }
    }

    readonly property int listEntryHeight: 30

    // Session popup
    Rectangle {
        id: sessionPopup
        z: 2
        width: 200
        height: Math.min(sessionModel.rowCount() * listEntryHeight, 300)
        visible: popupVisible
        color: "transparent"
        anchors.bottom: sessionButton.top
        anchors.bottomMargin: 5
        radius: 5

        Rectangle {
            anchors.fill: parent
            color: "#FFFFFF"
            opacity: 0.15
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
                height: sessionPopup.height
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

                delegate: Rectangle {
                    z: 2
                    width: 200
                    height: listEntryHeight
                    color: "transparent"
                    radius: 5

                    Rectangle {
                        anchors.fill: parent
                        color: "#FFFFFF"
                        opacity: index === currentSessionIndex ? 0.30 : 0.0
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

                        // ColorOverlay {
                        //     anchors.fill: sessionListIcon
                        //     source: sessionListIcon
                        //     color: index === currentSessionIndex ? "#000" : "#FFF"
                        // }
                        MultiEffect {
                            source: sessionListIcon
                            anchors.fill: sessionListIcon
                            colorization: 1
                            colorizationColor: index === currentSessionIndex ? "#000" : "#FFF"
                        }
                    }
                    // Session name
                    Text {
                        anchors.left: sessionListIcon.right
                        anchors.leftMargin: 10
                        anchors.verticalCenter: parent.verticalCenter
                        text: (name.length > 25) ? name.slice(0, 24) + '...' : name
                        color: index === currentSessionIndex ? "#161617" : "#FFF"
                        font.pixelSize: 10
                    }

                    Component.onCompleted: {
                        if (index === sessionList.currentIndex) {
                            sessionName = name;
                            sessionNameText.text = (name.length > 25) ? name.slice(0, 24) + '...' : name;
                            sessionIconPath = getSessionIcon(name);
                            sessionIcon.source = sessionIconPath;
                            sessionChanged(currentSessionIndex);
                        }
                    }

                    MouseArea {
                        anchors.fill: parent
                        z: 2
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true
                        onClicked: {
                            currentSessionIndex = index;
                            sessionList.currentIndex = index;
                            sessionName = name;
                            sessionNameText.text = (name.length > 25) ? name.slice(0, 24) + '...' : name;
                            sessionIconPath = getSessionIcon(name);
                            sessionIcon.source = sessionIconPath;
                            // popupVisible = false;
                            // sessionPopup.visible = false;
                            sessionChanged(currentSessionIndex);
                        }
                    }
                }
            }
        }
    }
}
