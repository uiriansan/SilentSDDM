import QtQuick 2.0
import QtGraphicalEffects 1.0

Item {
    id: frame
    signal selected(var index)
    signal needClose()

    readonly property int m_viewMaxWidth: frame.width - prevSession.width - nextSession.width - 230;
    property bool shouldShowBG: false
    property var sessionTypeList: ["deepin", "enlightenment", "fluxbox", "gnome", "kde", "lxde", "ubuntu"]
    property alias currentItem: sessionList.currentItem

    function getIconName(sessionName) {
        for (var item in sessionTypeList) {
            var str = sessionTypeList[item]
            var index = sessionName.toLowerCase().indexOf(str)
            if (index >= 0) {
                return str
            }
        }

        return "unknow"
    }

    function getCurrentSessionIconIndicator() {
        return sessionList.currentItem.iconIndicator;
    }

    function isMultipleSessions() {
        return sessionList.count > 1
    }

    onOpacityChanged: {
        shouldShowBG = false
    }

    onFocusChanged: {
        // Active by mouse click
        if (focus) {
            sessionList.currentItem.focus = false
        }
    }

    ImgButton {
        id: prevSession
        visible: sessionList.childrenRect.width > m_viewMaxWidth
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: 10
        normalImg: "icons/angle-left.png"
        onClicked: {
            sessionList.decrementCurrentIndex()
            shouldShowBG = true
        }
    }

    ListView {
        id: sessionList
        anchors.centerIn: parent
        width:  childrenRect.width > m_viewMaxWidth ? m_viewMaxWidth : childrenRect.width
        height: 150
        clip: true
        model: sessionModel
        currentIndex: sessionModel.lastIndex
        orientation: ListView.Horizontal
        spacing: 10
        delegate: Rectangle {
            property string iconIndicator: iconButton.indicator
            property bool activeBG: sessionList.currentIndex === index && shouldShowBG

            border.width: 3
            border.color: activeBG || focus ? "#33ffffff" : "transparent"
            radius: 8
            color: activeBG || focus ? "#55000000" : "transparent"

            width: 230
            height: 150

            ImgButton {
                id: iconButton
                anchors.top: parent.top
                anchors.horizontalCenter: parent.horizontalCenter
                width: 100
                height: 100
                normalImg: ("%1normal.png").arg(prefix)
                hoverImg: ("%1hover.png").arg(prefix)
                pressImg: ("%1press.png").arg(prefix)

                property var prefix: ("icons/sessionicon/%1_").arg(getIconName(name));
                property var indicator: ("icons/%1_indicator_normal.png").arg(getIconName(name));

                onClicked: {
                    selected(index)
                    sessionList.currentIndex = index
                }
            }

            Text {
                width: parent.width
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                horizontalAlignment: Text.AlignHCenter
                text: name
                font.pointSize: 15
                color: "white"
                wrapMode: Text.WordWrap
            }

            Keys.onLeftPressed: {
                sessionList.decrementCurrentIndex()
                sessionList.currentItem.forceActiveFocus()
            }
            Keys.onRightPressed: {
                sessionList.incrementCurrentIndex()
                sessionList.currentItem.forceActiveFocus()
            }
            Keys.onEscapePressed: needClose()
            Keys.onEnterPressed: {
                selected(index)
                sessionList.currentIndex = index
            }
            Keys.onReturnPressed: {
                selected(index)
                sessionList.currentIndex = index
            }
        }
    }

    ImgButton {
        id: nextSession
        visible: sessionList.childrenRect.width > m_viewMaxWidth
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: 10
        normalImg: "icons/angle-right.png"
        onClicked: {
            sessionList.incrementCurrentIndex()
            shouldShowBG = true
        }
    }

    MouseArea {
        z: -1
        anchors.fill: parent
        onClicked: needClose()
    }

    Keys.onEscapePressed: needClose()
}
