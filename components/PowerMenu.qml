import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ColumnLayout {
    id: selector
    width: Config.powerPopupWidth
    spacing: 2

    signal close

    KeyNavigation.up: shutdownButton
    KeyNavigation.down: suspendButton

    IconButton {
        id: suspendButton
        Layout.preferredHeight: Config.menuAreaPopupsItemHeight
        Layout.preferredWidth: Config.powerPopupWidth
        focus: selector.visible
        width: Layout.preferredWidth
        enabled: sddm.canSuspend
        icon: Config.getIcon("power-suspend.svg")
        contentColor: Config.menuAreaPopupsContentColor
        activeContentColor: Config.menuAreaPopupsActiveContentColor
        fontFamily: Config.menuAreaPopupsFontFamily
        backgroundColor: "transparent"
        activeBackgroundColor: Config.menuAreaPopupsActiveOptionBackgroundColor
        activeBackgroundOpacity: Config.menuAreaPopupsActiveOptionBackgroundOpacity
        iconSize: Config.menuAreaPopupsIconSize
        fontSize: Config.menuAreaPopupsFontSize
        onClicked: {
            sddm.suspend();
            selector.close();
        }
        label: textConstants.suspend

        KeyNavigation.up: shutdownButton
        KeyNavigation.down: rebootButton
    }

    IconButton {
        id: rebootButton
        Layout.preferredHeight: Config.menuAreaPopupsItemHeight
        Layout.preferredWidth: Config.powerPopupWidth
        focus: selector.visible
        width: Layout.preferredWidth
        enabled: sddm.canReboot
        icon: Config.getIcon("power-reboot.svg")
        contentColor: Config.menuAreaPopupsContentColor
        activeContentColor: Config.menuAreaPopupsActiveContentColor
        fontFamily: Config.menuAreaPopupsFontFamily
        backgroundColor: "transparent"
        activeBackgroundColor: Config.menuAreaPopupsActiveOptionBackgroundColor
        activeBackgroundOpacity: Config.menuAreaPopupsActiveOptionBackgroundOpacity
        iconSize: Config.menuAreaPopupsIconSize
        fontSize: Config.menuAreaPopupsFontSize
        onClicked: {
            sddm.suspend();
            selector.close();
        }
        label: textConstants.reboot

        KeyNavigation.up: suspendButton
        KeyNavigation.down: shutdownButton
    }

    IconButton {
        id: shutdownButton
        Layout.preferredHeight: Config.menuAreaPopupsItemHeight
        Layout.preferredWidth: Config.powerPopupWidth
        focus: selector.visible
        width: Layout.preferredWidth
        enabled: sddm.canPowerOff
        icon: Config.getIcon("power.svg")
        contentColor: Config.menuAreaPopupsContentColor
        activeContentColor: Config.menuAreaPopupsActiveContentColor
        fontFamily: Config.menuAreaPopupsFontFamily
        backgroundColor: "transparent"
        activeBackgroundColor: Config.menuAreaPopupsActiveOptionBackgroundColor
        activeBackgroundOpacity: Config.menuAreaPopupsActiveOptionBackgroundOpacity
        iconSize: Config.menuAreaPopupsIconSize
        fontSize: Config.menuAreaPopupsFontSize
        onClicked: {
            sddm.suspend();
            selector.close();
        }
        label: textConstants.shutdown

        KeyNavigation.up: rebootButton
        KeyNavigation.down: suspendButton
    }

    Keys.onPressed: event => {
        if (event.key == Qt.Key_Return || event.key == Qt.Key_Enter || event.key === Qt.Key_Space) {
            selector.close();
        } else if (event.key === Qt.Key_CapsLock) {
            root.capsLockOn = !root.capsLockOn;
        }
    }
}
