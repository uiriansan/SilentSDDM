import QtQuick 2.2

ListView {
	id: listView

	signal userSelected()

	readonly property string selectedUser: currentItem ? currentItem.userName : ""

	// implicitHeight: iconButtonSize
	activeFocusOnTab: true
	orientation: Listview.Horizontal
	// highlightRangeMode: ListView.StrictlyEnforceRange

	delegate: Rectangle {
		id: delegate
	}
}

