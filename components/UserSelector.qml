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

    ListView {
        id: userList
        anchors.fill: parent
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

        delegate: Item {
            width: index === userList.currentIndex ? Config.avatarActiveSize : Config.avatarInactiveSize
            height: width
            anchors {
                verticalCenter: selector.orientation === "vertical" ? parent.verticalCenter : undefined
                horizontalCenter: selector.orientation === "vertical" ? undefined : parent.horizontalCenter
            }
            // color: "transparent"
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
                active: index === userList.currentIndex
                opacity: active ? 1.0 : Config.avatarInactiveOpacity
                enabled: userModel.rowCount() > 1 // No need to open the selector if there's only one user
                tooltipText: active && selector.listUsers ? "Close user selection" : (active && !listUsers ? "Select user" : `Select user ${model.name}`)
                showTooltip: selector.focus && !listUsers && active

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
                        selector.focus = true;
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
                // selector.listUsers = false;
                selector.closeUserList();
                selector.focus = false;
            } else {
                // selector.listUsers = true;
                selector.openUserList();
                selector.focus = true;
            }
        } else if (event.key == Qt.Key_Escape) {
            // selector.listUsers = false;
            selector.closeUserList();
            selector.focus = false;
        } else if ((selector.orientation === "vertical" && event.key == Qt.Key_Left) || (selector.orientation === "horizontal" && event.key == Qt.Key_Up)) {
            userList.decrementCurrentIndex();
            selector.focus = true;
        } else if ((selector.orientation === "vertical" && event.key == Qt.Key_Right) || (selector.orientation === "horizontal" && event.key == Qt.Key_Down)) {
            userList.incrementCurrentIndex();
            selector.focus = true;
        }
    }
}
