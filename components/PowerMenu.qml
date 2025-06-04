import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ColumnLayout {
    id: selector
    width: 100
    spacing: 2

    signal close

    IconButton {
        id: suspendButton
        Layout.preferredHeight: 35
        Layout.preferredWidth: 100
        width: Layout.preferredWidth
        enabled: sddm.canSuspend
        icon: "icons/power-suspend.svg"
        iconColor: Config.menuAreaPopupContentColor
        activeIconColor: Config.menuAreaPopupActiveContentColor
        backgroundColor: Config.menuAreaPopupBackgroundColor
        activeBackgroundColor: Config.menuAreaPopupActiveOptionBackgroundColor
        activeBackgroundOpacity: Config.menuAreaPopupActiveOptionBackgroundOpacity
        iconSize: Config.menuAreaPopupIconSize
        fontSize: Config.menuAreaPopupFontSize
        onClicked: sddm.suspend()
        label: textConstants.suspend
    }

    IconButton {
        id: rebootButton
        Layout.preferredHeight: 35
        Layout.preferredWidth: 100
        width: Layout.preferredWidth
        enabled: sddm.canReboot
        icon: "icons/power-reboot.svg"
        iconColor: Config.menuAreaPopupContentColor
        activeIconColor: Config.menuAreaPopupActiveContentColor
        backgroundColor: Config.menuAreaPopupBackgroundColor
        activeBackgroundColor: Config.menuAreaPopupActiveOptionBackgroundColor
        activeBackgroundOpacity: Config.menuAreaPopupActiveOptionBackgroundOpacity
        iconSize: Config.menuAreaPopupIconSize
        fontSize: Config.menuAreaPopupFontSize
        onClicked: sddm.suspend()
        label: textConstants.reboot
    }

    IconButton {
        id: shutdownButton
        Layout.preferredHeight: 35
        Layout.preferredWidth: 100
        width: Layout.preferredWidth
        enabled: sddm.canPowerOff
        icon: "icons/power.svg"
        iconColor: Config.menuAreaPopupContentColor
        activeIconColor: Config.menuAreaPopupActiveContentColor
        backgroundColor: Config.menuAreaPopupBackgroundColor
        activeBackgroundColor: Config.menuAreaPopupActiveOptionBackgroundColor
        activeBackgroundOpacity: Config.menuAreaPopupActiveOptionBackgroundOpacity
        iconSize: Config.menuAreaPopupIconSize
        fontSize: Config.menuAreaPopupFontSize
        onClicked: sddm.suspend()
        label: textConstants.shutdown
    }
}
