import QtQuick
import QtQuick.Controls
import SddmComponents

Item {
    signal click
    signal userChanged(userIndex: int)
    signal closeUserList
    property bool listUsers: false

    z: 2

    ListView {
        id: userList
        width: parent.width
        height: config.selectedAvatarSize || 120
        anchors.horizontalCenter: parent.horizontalCenter
        orientation: ListView.Horizontal
        spacing: 10.0

        model: userModel
        currentIndex: userModel.lastIndex

        // Center the current avatar
        preferredHighlightBegin: width / 2 - (config.selectedAvatarSize || 120) / 2
        preferredHighlightEnd: preferredHighlightBegin
        highlightRangeMode: ListView.StrictlyEnforceRange

        // Animation properties
        highlightMoveDuration: 200
        highlightResizeDuration: 200
        highlightMoveVelocity: -1
        highlightFollowsCurrentItem: true
        boundsBehavior: Flickable.StopAtBounds

        interactive: listUsers

        // Padding for centering
        leftMargin: width / 2 - (config.selectedAvatarSize || 120) / 2
        rightMargin: leftMargin

        // Close the list when click behind the avatars

        MouseArea {
            anchors.fill: parent
            enabled: listUsers
            onClicked: mouse => {
                const clickedItem = userList.itemAt(mouse.x, mouse.y);
                if (!clickedItem) {
                    closeUserList();
                    mouse.accepted = true;
                } else {
                    mouse.accepted = false;
                }
            }
            z: -1
        }

        onCurrentIndexChanged: {
            const username = userModel.data(userModel.index(currentIndex, 0), 257);
            const userRealName = userModel.data(userModel.index(currentIndex, 0), 258);
            const userIconL = userModel.data(userModel.index(currentIndex, 0), 260);
            const needsPasswd = userModel.data(userModel.index(currentIndex, 0), 261);

            sddm.currentUser = username;
            userName = username;
            userIcon = userIconL;
            userNameText.text = userRealName ? userRealName : username;
            userChanged(currentIndex);

            if (!needsPasswd) {
                loginFrame.showKeyboard = true;
            } else {
                loginFrame.showKeyboard = false;
            }
        }

        delegate: Rectangle {
            property string iconPath: model.icon
            width: index === userList.currentIndex ? config.selectedAvatarSize || 120 : config.standardAvatarSize || 80
            height: index === userList.currentIndex ? config.selectedAvatarSize || 120 : config.standardAvatarSize || 80
            anchors.verticalCenter: parent.verticalCenter
            color: "transparent"

            visible: listUsers || index === userList.currentIndex

            // Size transition animation
            Behavior on width {
                enabled: config.enableAnimations === "false" ? false : true
                NumberAnimation {
                    duration: 150
                    easing.type: Easing.OutQuad
                }
            }
            Behavior on height {
                enabled: config.enableAnimations === "false" ? false : true
                NumberAnimation {
                    duration: 150
                    easing.type: Easing.OutQuad
                }
            }

            // Animate visibility
            opacity: listUsers || index === userList.currentIndex ? 1.0 : 0.0
            Behavior on opacity {
                enabled: config.enableAnimations === "false" ? false : true
                NumberAnimation {
                    duration: 150
                }
            }

            Avatar {
                z: 5
                width: parent.width
                height: parent.height
                source: model.icon
                opacity: index === userList.currentIndex ? 1.0 : config.standardAvatarOpacity || 0.35
                enabled: userModel.rowCount() > 1

                // Opacity transition
                Behavior on opacity {
                    enabled: config.enableAnimations === "false" ? false : true
                    NumberAnimation {
                        duration: 150
                    }
                }

                onClicked: {
                    if (!listUsers) {
                        click();
                        userList.model.reset();
                    } else {
                        // Collapse the list if the user selects the current one again
                        if (index === userList.currentIndex) {
                            closeUserList();
                        }
                        userList.currentIndex = index;
                    }
                }
                onClickedOutside: {
                    closeUserList();
                }
            }

            Component.onCompleted: {
                if (index === userList.currentIndex) {
                    userNameText.text = model.realName ? model.realName : model.name;
                }
            }
        }
    }
}
