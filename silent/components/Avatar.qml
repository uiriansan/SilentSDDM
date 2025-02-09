import QtQuick 2.2

Canvas {
	id: avatarCanvas

	property string source: ""

	signal clicked()

	onSourceChanged: delayPaint.running = true

	onPaint: {
		const ctx = getContext("2d")
		ctx.beginPath()

		switch(avatarShape) {
			case "square":
				ctx.rect(0, 0, width, height)
				break
			case "squircle":
				const r = width * 35 / 100
				ctx.moveTo(width - r, 0)
				ctx.arcTo(width, 0, width, height, r)
				ctx.arcTo(width, height, 0, height, r)
				ctx.arcTo(0, height, 0, 0, r)
				ctx.arcTo(0, 0, width, 0, r)
				ctx.closePath()
				break
			default:
				ctx.ellipse(0, 0, width, height)
		}
		ctx.clip()
		ctx.drawImage(source, 0, 0, width, height)
	}

	MouseArea {
		anchors.fill: parent
		hoverEnabled: true
		onEntered: avatarCanvas.requestPaint()
        onExited: avatarCanvas.requestPaint()
        onClicked: avatarCanvas.clicked()
	}

	Timer {
		id: delayPaint
		repeat: false
		interval: 150
		onTriggered: avatarCanvas.requestPaint()
		running: true
	}
}
