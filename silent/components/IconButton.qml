import QtQuick 2.2

Rectangle {
	id: iconButton
	radius: borderRadius
	width: iconButtonSize
	height: iconButtonSize
	color: config.enableOptionsBg === "true" ? bgColor : "transparent"
	opacity: focus ? focusBgOpacity : bgOpacity

	property url icon: ""

	signal clicked()
	signal accepted()

	Image {
		id: icon
		width: iconButtonFontSize
		height: iconButtonFontSize
		anchors.centerIn: parent
		sourceSize: Qt.size(width, height)
	}

	MouseArea {
		anchors.fill: parent
		hoverEnabled: true
		onEntered: iconButton.opacity = focusBgOpacity
		onExited: iconButton.opacity = bgOpacity
		onPressed: iconButton.opacity = bgOpacity
		onReleased: iconButton.opacity = focusBgOpacity
		onClicked: iconButton.clicked()
	}

	Component.onCompleted: {
		icon.source = icon
	}
	Keys.onPressed: (event) => {
		if(event.key == Qt.Key_Return || event.key == Qt.Key_Enter) {
			iconButton.clicked()
			iconButton.accepted()
	}
}
