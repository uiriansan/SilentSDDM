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
    property bool isDragging: false

    function prevUser() {
        userList.decrementCurrentIndex();
    }
    function nextUser() {
        userList.incrementCurrentIndex();
    }

    ListView {
        id: userList
        anchors.fill: parent
        orientation: selector.orientation === "horizontal" ? ListView.Horizontal : ListView.Vertical
        spacing: 10
        interactive: false
        boundsBehavior: Flickable.StopAtBounds

        // Center the active avatar
        preferredHighlightBegin: selector.orientation === "horizontal" ? (width - Config.avatarActiveSize) / 2 : (height - Config.avatarActiveSize) / 2
        preferredHighlightEnd: preferredHighlightBegin
        highlightRangeMode: ListView.StrictlyEnforceRange
        // Padding for centering
        leftMargin: selector.orientation === "horizontal" ? preferredHighlightBegin : 0
        rightMargin: leftMargin
        topMargin: selector.orientation === "horizontal" ? 0 : preferredHighlightBegin
        bottomMargin: topMargin

        // Animation properties
        highlightMoveDuration: 200
        highlightResizeDuration: 200
        highlightMoveVelocity: -1
        highlightFollowsCurrentItem: true

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
            height: index === userList.currentIndex ? Config.avatarActiveSize : Config.avatarInactiveSize
            anchors {
                verticalCenter: selector.orientation === "horizontal" ? parent.verticalCenter : undefined
                horizontalCenter: selector.orientation === "horizontal" ? undefined : parent.horizontalCenter
            }
            color: "transparent"
            visible: selector.listUsers || index === userList.currentIndex

            Behavior on width {
                enabled: Config.enableAnimations
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.OutQuad
                }
            }
            Behavior on height {
                enabled: Config.enableAnimations
                NumberAnimation {
                    duration: 200
                    easing.type: Easing.OutQuad
                }
            }
            opacity: selector.listUsers || index === userList.currentIndex ? 1.0 : 0.0
            Behavior on opacity {
                enabled: Config.enableAnimations
                NumberAnimation {
                    duration: 200
                }
            }

            Avatar {
                width: parent.width
                height: parent.height
                source: Qt.resolvedUrl("../icons/user-default.png")
                userName: model.name
                active: index === userList.currentIndex
                opacity: active ? 1.0 : Config.avatarInactiveOpacity
                enabled: userModel.rowCount() > 1 // No need to open the selector if there's only one user
                tooltipText: !Config.tooltipsDisableUser ? (active && selector.listUsers ? (textConstants.closeUserSelection || "Close") : (active && !listUsers ? (textConstants.selectUser || "Select User") : (textConstants.selectUser || "Select User") + " " + model.name)) : ""
                showTooltip: selector.focus && !listUsers && active

                Behavior on opacity {
                    enabled: Config.enableAnimations
                    NumberAnimation {
                        duration: 200
                    }
                }

                onClicked: {
                    if (!selector.listUsers) {
                        // Open selector
                        selector.openUserList();
                        selector.focus = true;
                        userList.model.reset();
                    } else {
                        // Collapse the list if the selected user gets another click
                        if (index === userList.currentIndex) {
                            selector.closeUserList();
                            selector.focus = false;
                        }
                        userList.currentIndex = index;
                    }
                }
                onClickedOutside: {
                    selector.closeUserList();
                    selector.focus = false;
                }
            }
        }
    }

    Keys.onPressed: event => {
        if (event.key == Qt.Key_Return || event.key == Qt.Key_Enter || event.key === Qt.Key_Space) {
            if (selector.listUsers) {
                selector.closeUserList();
                selector.focus = false;
            } else {
                selector.openUserList();
                selector.focus = true;
            }
            event.accepted = true;
        } else if (event.key == Qt.Key_Escape) {
            selector.closeUserList();
            selector.focus = false;
            event.accepted = true;
        } else if ((selector.orientation === "horizontal" && event.key == Qt.Key_Left) || (selector.orientation === "vertical" && event.key == Qt.Key_Up)) {
            if (userModel.rowCount() > 0) {
                userList.currentIndex = (userList.currentIndex + userModel.rowCount() - 1) % userModel.rowCount();
            }
            selector.focus = true;
            event.accepted = true;
        } else if ((selector.orientation === "horizontal" && event.key == Qt.Key_Right) || (selector.orientation === "vertical" && event.key == Qt.Key_Down)) {
            if (userModel.rowCount() > 0) {
                userList.currentIndex = (userList.currentIndex + userModel.rowCount() + 1) % userModel.rowCount();
            }
            selector.focus = true;
            event.accepted = true;
        } else if (event.key === Qt.Key_CapsLock) {
            root.capsLockOn = !root.capsLockOn;
            event.accepted = true;
        } else {
            // Do not steal other keys
            event.accepted = false;
        }
    }
}
