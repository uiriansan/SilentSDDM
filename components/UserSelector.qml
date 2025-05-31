import QtQuick
import QtQuick.Controls
import SddmComponents

Item {
    id: selector

    signal openUserList
    signal closeUserList
    signal userChanged(userIndex: int, username: string, userRealName: string, userIcon: string, needsPassword: bool)

    property bool listUsers: false
    property string orientation: ""

    Rectangle {
        width: parent.width
        height: parent.height
        // color: "#000"
        color: "transparent"
    }

    ListView {
        id: userList
        anchors {
            fill: parent
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
        orientation: selector.orientation === "vertical" ? ListView.Horizontal : ListView.Vertical
        spacing: 10
        interactive: selector.listUsers
        boundsBehavior: Flickable.StopAtBounds

        // Center the active avatar
        preferredHighlightBegin: selector.orientation === "vertical" ? (width - Config.avatarActiveSize) / 2 : (height - Config.avatarActiveSize) / 2
        preferredHighlightEnd: preferredHighlightBegin
        highlightRangeMode: ListView.StrictlyEnforceRange
        // Padding for centering
        leftMargin: selector.orientation === "vertical" ? preferredHighlightBegin : 0
        rightMargin: leftMargin
        topMargin: selector.orientation === "vertical" ? 0 : preferredHighlightBegin
        bottomMargin: topMargin

        // Animation properties
        highlightMoveDuration: 200
        highlightResizeDuration: 200
        highlightMoveVelocity: -1
        highlightFollowsCurrentItem: true
        // highlightFollowsCurrentItem: false

        model: userModel

        currentIndex: userModel.lastIndex
        onCurrentIndexChanged: {
            const username = userModel.data(userModel.index(currentIndex, 0), 257);
            const userRealName = userModel.data(userModel.index(currentIndex, 0), 258);
            const userIcon = userModel.data(userModel.index(currentIndex, 0), 260);
            const needsPasswd = userModel.data(userModel.index(currentIndex, 0), 261);

            sddm.currentUser = username;
            selector.userChanged(currentIndex, username, userRealName, userIcon, needsPasswd);
        }

        delegate: Rectangle {
            width: index === userList.currentIndex ? Config.avatarActiveSize : Config.avatarInactiveSize
            height: width
            anchors {
                verticalCenter: selector.orientation === "vertical" ? parent.verticalCenter : undefined
                horizontalCenter: selector.orientation === "vertical" ? undefined : parent.horizontalCenter
            }
            color: "transparent"
            visible: selector.listUsers || index === userList.currentIndex

            Behavior on width {
                enabled: Config.enableAnimations
                NumberAnimation {
                    duration: 150
                    easing.type: Easing.OutQuad
                }
            }
            Behavior on height {
                enabled: Config.enableAnimations
                NumberAnimation {
                    duration: 150
                    easing.type: Easing.OutQuad
                }
            }
            opacity: selector.listUsers || index === userList.currentIndex ? 1.0 : 0.0
            Behavior on opacity {
                enabled: Config.enableAnimations
                NumberAnimation {
                    duration: 150
                }
            }

            Avatar {
                width: parent.width
                height: parent.height
                source: model.icon
                opacity: index === userList.currentIndex ? 1.0 : Config.avatarInactiveOpacity
                enabled: userModel.rowCount() > 1 // No need to open the selector if there's only one user
                tooltipText: index === userList.currentIndex && selector.listUsers ? "Close user selection" : (index === userList.currentIndex && !listUsers ? "Select user" : `Select user ${model.name}`)
                showTooltip: selector.focus && !listUsers && index === userList.currentIndex

                Behavior on opacity {
                    enabled: Config.enableAnimations
                    NumberAnimation {
                        duration: 150
                    }
                }

                onClicked: {
                    if (!selector.listUsers) {
                        // Open selector
                        selector.openUserList();
                        userList.model.reset();
                    } else {
                        // Collapse the list if the selected user gets another click
                        if (index === userList.currentIndex) {
                            selector.closeUserList();
                        }
                        userList.currentIndex = index;
                    }
                }
                onClickedOutside: {
                    selector.closeUserList();
                }
            }
        }

        MouseArea {
            z: -1
            anchors.fill: parent
            enabled: selector.listUsers
            onClicked: mouse => {
                const clickedItem = userList.itemAt(mouse.x, mouse.y);
                if (!clickedItem) {
                    selector.closeUserList();
                    mouse.accepted = true;
                } else {
                    mouse.accepted = false;
                }
            }
        }
    }
}
