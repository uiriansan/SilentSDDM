import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Item {
    id: powerSelector
    z: 2
    height: childrenRect.height
    width: 100

    signal optionSelected(option: int)

    property bool canShutdown: sddm.canPowerOff
    property bool canReboot: sddm.canReboot
    property bool canSuspend: sddm.canSuspend

    property bool popupVisible: true

    function close() {
        popupVisible = false;
    }

    readonly property int listEntryHeight: 30

    Rectangle {
        id: powerPopup
        z: 2
        width: 100
        height: 3 * listEntryHeight + 10
        visible: popupVisible
        color: "transparent"
        radius: 5

        Rectangle {
            anchors.fill: parent
            color: Config.menuAreaPopupBackgroundColor
            opacity: Config.menuAreaPopupBackgroundOpacity
            radius: 5
        }

        Column {
            id: powerList
            z: 2
            anchors.fill: parent
            anchors.margins: 5

            IconButton {
                id: suspendButton
                enabled: powerSelector.canSuspend
                height: listEntryHeight
                width: parent.width
                icon: "icons/power-suspend.svg"
                iconColor: Config.menuAreaPopupContentColor
                hoverIconColor: Config.menuAreaPopupActiveContentColor
                backgroundColor: Config.menuAreaPopupBackgroundColor
                hoverBackgroundColor: Config.menuAreaPopupActiveOptionBackgroundColor
                hoverBackgroundOpacity: Config.menuAreaPopupActiveOptionBackgroundOpacity
                iconSize: Config.menuAreaPopupIconSize
                fontSize: Config.menuAreaPopupFontSize
                onClicked: sddm.suspend()
                label: textConstants.suspend
            }

            IconButton {
                id: rebootButton
                enabled: powerSelector.canReboot
                height: listEntryHeight
                width: parent.width
                icon: "icons/power-reboot.svg"
                iconColor: Config.menuAreaPopupContentColor
                hoverIconColor: Config.menuAreaPopupActiveContentColor
                backgroundColor: Config.menuAreaPopupBackgroundColor
                hoverBackgroundColor: Config.menuAreaPopupActiveOptionBackgroundColor
                hoverBackgroundOpacity: Config.menuAreaPopupActiveOptionBackgroundOpacity
                iconSize: Config.menuAreaPopupIconSize
                fontSize: Config.menuAreaPopupFontSize
                onClicked: sddm.reboot()
                label: textConstants.reboot
            }

            IconButton {
                id: shutdownButton
                enabled: powerSelector.canShutdown
                height: listEntryHeight
                width: parent.width
                icon: "icons/power.svg"
                iconColor: Config.menuAreaPopupContentColor
                hoverIconColor: Config.menuAreaPopupActiveContentColor
                backgroundColor: Config.menuAreaPopupBackgroundColor
                hoverBackgroundColor: Config.menuAreaPopupActiveOptionBackgroundColor
                hoverBackgroundOpacity: Config.menuAreaPopupActiveOptionBackgroundOpacity
                iconSize: Config.menuAreaPopupIconSize
                fontSize: Config.menuAreaPopupFontSize
                onClicked: sddm.powerOff()
                label: textConstants.shutdown
            }
        }
    }
}
