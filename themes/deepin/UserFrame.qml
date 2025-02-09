import QtQuick 2.2
import QtGraphicalEffects 1.0

Item {
    id: frame
    signal selected(var userName)
    signal needClose()

    //readonly property int m_viewMaxWidth: frame.width - prevUser.width - nextUser.width - 130
    property string currentIconPath: usersList.currentItem.iconPath
    property string currentUserName: "uirian" // usersList.currentItem.userName
    property bool shouldShowBG: false
    property alias currentItem: usersList.currentItem

    function isMultipleUsers() {
        return usersList.count > 1
    }

    onOpacityChanged: {
        shouldShowBG = false
    }

    onFocusChanged: {
        // Active by mouse click
        if (focus) {
            usersList.currentItem.focus = false
        }
    }

    //ImgButton {
    //    id: prevUser
    //    visible: usersList.childrenRect.width > m_viewMaxWidth
    //    anchors.left: parent.left
    //    anchors.verticalCenter: parent.verticalCenter
    //    anchors.margins: 10
    //    normalImg: "icons/angle-left.png"
    //    onClicked: {
    //        usersList.decrementCurrentIndex()
    //        shouldShowBG = true
    //    }
    //}

    ListView {
        id: usersList
        anchors.centerIn: parent
        //width: childrenRect.width > m_viewMaxWidth ? m_viewMaxWidth : childrenRect.width
        height: 150
        model: userModel
        clip: true
        spacing: 10
        orientation: ListView.Horizontal

        delegate: Rectangle {
            id: item
            property string iconPath: icon
            //property string userName: nameText.text
            property bool activeBG: usersList.currentIndex === index && shouldShowBG

            border.width: 3
            border.color: activeBG || focus ? "#33ffffff" : "transparent"
            radius: 8
            color: activeBG || focus? "#55000000" : "transparent"

            width: 130
            height: 150

            function select() {
                selected(name)
                usersList.currentIndex = index
                currentIconPath = icon
                currentUserName = name
            }

            //UserAvatar {
            //    id: iconButton
            //    anchors.top: parent.top
            //    anchors.horizontalCenter: parent.horizontalCenter
            //    width: 100
            //    height: 100
            //    source: icon
            //    onClicked: item.select()
            //}
            //
            //Text {
            //    id: nameText
            //    width: parent.width
            //    anchors.bottom: parent.bottom
            //    anchors.horizontalCenter: parent.horizontalCenter
            //    horizontalAlignment: Text.AlignHCenter
            //    text: name
            //    font.pointSize: 15
            //    color: "white"
            //    wrapMode: Text.WordWrap
            //}
            //
            //Keys.onLeftPressed: {
            //    usersList.decrementCurrentIndex()
            //    usersList.currentItem.forceActiveFocus()
            //}
            //Keys.onRightPressed: {
            //    usersList.incrementCurrentIndex()
            //    usersList.currentItem.forceActiveFocus()
            //}
            //Keys.onEscapePressed: needClose()
            //Keys.onEnterPressed: item.select()
            //Keys.onReturnPressed: item.select()
            //
            //Component.onCompleted: {
            //    if (name === userModel.lastUser) {
            //        item.select()
            //    }
            //}
        }
    }

    //ImgButton {
    //    id: nextUser
    //    visible: usersList.childrenRect.width > m_viewMaxWidth
    //    anchors.right: parent.right
    //    anchors.verticalCenter: parent.verticalCenter
    //    anchors.margins: 10
    //    normalImg: "icons/angle-right.png"
    //    onClicked: {
    //        usersList.incrementCurrentIndex()
    //        shouldShowBG = true
    //    }
    //}
    //
    //MouseArea {
    //    z: -1
    //    anchors.fill: parent
    //    onClicked: needClose()
    //}
    //
    //Keys.onEscapePressed: needClose()
}
