import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ColumnLayout {
    id: selector
    width: Config.powerPopupWidth * Config.generalScale
    spacing: 2

    signal close

    KeyNavigation.up: shutdownButton
    KeyNavigation.down: suspendButton

    IconButton {
        id: suspendButton

        preferredWidth: Layout.preferredWidth
        Layout.preferredHeight: Config.menuAreaPopupsItemHeight * Config.generalScale
        Layout.preferredWidth: Config.powerPopupWidth * Config.generalScale

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
            selector.close();
            sddm.suspend();
        }
        label: textConstants.suspend

        KeyNavigation.up: shutdownButton
        KeyNavigation.down: rebootButton
    }

    IconButton {
        id: rebootButton

        preferredWidth: Layout.preferredWidth
        Layout.preferredHeight: Config.menuAreaPopupsItemHeight * Config.generalScale
        Layout.preferredWidth: Config.powerPopupWidth * Config.generalScale

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
            selector.close();
            sddm.reboot();
        }
        label: textConstants.reboot

        KeyNavigation.up: suspendButton
        KeyNavigation.down: shutdownButton
    }

    IconButton {
        id: shutdownButton

        preferredWidth: Layout.preferredWidth
        Layout.preferredHeight: Config.menuAreaPopupsItemHeight * Config.generalScale
        Layout.preferredWidth: Config.powerPopupWidth * Config.generalScale

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
            selector.close();
            sddm.powerOff();
        }
        label: textConstants.shutdown

        KeyNavigation.up: rebootButton
        KeyNavigation.down: suspendButton
    }

    Keys.onPressed: function (event) {
        if (event.key == Qt.Key_Return || event.key == Qt.Key_Enter || event.key === Qt.Key_Space) {
            selector.close();
        } else if (event.key === Qt.Key_CapsLock) {
            root.capsLockOn = !root.capsLockOn;
        }
    }
}
