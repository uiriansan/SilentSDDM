import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

ColumnLayout {
    id: selector
    width: 100
    spacing: 2

    signal close

    KeyNavigation.up: shutdownButton
    KeyNavigation.down: suspendButton

    IconButton {
        id: suspendButton
        Layout.preferredHeight: 35
        Layout.preferredWidth: 100
        focus: selector.visible
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
        Layout.preferredHeight: 35
        Layout.preferredWidth: 100
        focus: selector.visible
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
        Layout.preferredHeight: 35
        Layout.preferredWidth: 100
        focus: selector.visible
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
        }
    }
}
