import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Item {
    id: languageSelector
    z: 2

    signal languageChanged(languageIndex: int)

    property int currentLanguageIndex: keyboard.currentLayout ? keyboard.currentLayout : 0
    property string languageName: ""
    property string languageShort: ""
    property bool popupVisible: true

    function close() {
        popupVisible = false;
    }

    readonly property int listEntryHeight: 30

    Rectangle {
        id: languagePopup
        z: 2
        width: 200
        height: keyboard && keyboard.layouts.length > 0 ? Math.min(keyboard.layouts.length * listEntryHeight + 13, 300) : noLangText.height
        visible: popupVisible
        color: "transparent"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.horizontalCenter: parent.horizontalCenter
        radius: 5

        Rectangle {
            anchors.fill: parent
            color: "#FFFFFF"
            opacity: 0.15
            radius: 5
        }

        ScrollView {
            z: 2
            anchors.fill: parent
            ScrollBar.vertical.policy: languagePopup.height < 300 ? ScrollBar.AlwaysOff : ScrollBar.AlwaysOn
            ScrollBar.vertical.interactive: true
            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

            Text {
                id: noLangText
                visible: keyboard == undefined || keyboard.layouts.length === 0
                text: "No keyboard layout could be found. This is a known issue with Wayland."
                width: parent.width
                wrapMode: Text.Wrap
                horizontalAlignment: Text.AlignHCenter
                color: "#FFFFFF"
                padding: 10
            }

            ListView {
                id: languageList
                z: 2
                height: languagePopup.height
                width: parent.width
                anchors.fill: parent
                visible: keyboard && keyboard.layouts.length > 0
                anchors.margins: 5
                anchors.rightMargin: languagePopup.height < 300 ? 5 : 13
                orientation: ListView.Vertical
                interactive: true
                clip: true
                boundsBehavior: Flickable.StopAtBounds

                model: keyboard.layouts
                currentIndex: languageSelector.currentLanguageIndex

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
                        opacity: index === currentLanguageIndex ? 0.15 : (itemMouseArea.containsMouse ? 0.15 : 0.0)
                        radius: 5
                    }

                    Text {
                        anchors.left: parent.left
                        anchors.leftMargin: 10
                        anchors.verticalCenter: parent.verticalCenter
                        text: (longName.length > 25) ? longName.slice(0, 24) + '...' : longName
                        color: index === currentLanguageIndex ? "#fff" : "#FFF"
                        font.pixelSize: 10
                    }

                    Component.onCompleted: {
                        if (index === languageList.currentIndex) {
                            languageName = longName;
                            languageShort = shortName;
                            languageChanged(currentLanguageIndex);
                        }
                    }

                    MouseArea {
                        id: itemMouseArea
                        anchors.fill: parent
                        z: 2
                        cursorShape: Qt.PointingHandCursor
                        hoverEnabled: true
                        onClicked: {
                            currentLanguageIndex = index;
                            keyboard.currentLayout = index;
                            languageName = longName;
                            languageShort = shortName;
                            // popupVisible = false;
                            // sessionPopup.visible = false;
                            languageChanged(currentLanguageIndex);
                        }
                    }
                }
            }
        }
    }
}
