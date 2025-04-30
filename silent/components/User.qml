import QtQuick 2.5
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0
import SddmComponents 2.0

Item {
    signal click
    signal userChanged(userIndex: int)
    signal closeUserList
    property bool listUsers: false

    ListView {
        id: userList
        z: 2
        width: parent.width
        height: config.selectedAvatarSize || 120
        anchors.horizontalCenter: parent.horizontalCenter
        orientation: ListView.Horizontal
        spacing: 10.0

        model: userModel
        currentIndex: userModel.lastIndex

        // Center the current item
        preferredHighlightBegin: width / 2 - (config.selectedAvatarSize || 120) / 2
        preferredHighlightEnd: preferredHighlightBegin
        highlightRangeMode: ListView.StrictlyEnforceRange

        // Animation properties
        highlightMoveDuration: 200
        highlightResizeDuration: 200
        highlightMoveVelocity: -1
        highlightFollowsCurrentItem: true
        boundsBehavior: Flickable.StopAtBounds

        // Interactive behavior
        interactive: listUsers
        flickDeceleration: 1500
        maximumFlickVelocity: 2500

        // Padding for centering
        leftMargin: width / 2 - (config.selectedAvatarSize || 120) / 2
        rightMargin: leftMargin

        onCurrentIndexChanged: index => {
            userList.changeUser(index);
        }

        function changeUser(index) {
            // Collapse the list if the user selects the current one again
            if (index === userList.currentIndex) {
                closeUserList();
            }
            userList.currentIndex = index;
            sddm.currentUser = model.name;
            userName = model.name;
            userIcon = model.icon;
            userNameText.text = model.realName ? model.realName : model.name;
            userChanged(index);
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
                NumberAnimation {
                    duration: 150
                    easing.type: Easing.OutQuad
                }
            }
            Behavior on height {
                NumberAnimation {
                    duration: 150
                    easing.type: Easing.OutQuad
                }
            }

            // Animate visibility
            opacity: listUsers || index === userList.currentIndex ? 1.0 : 0.0
            Behavior on opacity {
                NumberAnimation {
                    duration: 150
                }
            }

            Avatar {
                z: 4
                width: parent.width
                height: parent.height
                source: model.icon
                opacity: index === userList.currentIndex ? 1.0 : config.standardAvatarOpacity || 0.35
                enabled: true

                // Opacity transition
                Behavior on opacity {
                    NumberAnimation {
                        duration: 150
                    }
                }

                onClicked: {
                    if (!listUsers) {
                        click();
                        userList.model.reset();
                    } else {
                        userList.changeUser(index);
                    }
                }
            }

            Component.onCompleted: {
                if (index === userList.currentIndex) {
                    userNameText.text = model.realName ? model.realName : model.name;
                }
            }
        }
    }
    MouseArea {
        anchors.fill: parent
        z: 3
        enabled: listUsers
        visible: listUsers
        onClicked: {
            closeUserList();
        }
    }
}
