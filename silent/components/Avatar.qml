import QtQuick 2.5

Canvas {
    id: avatar
    property string source: ""
    property color m_strokeStyle: "#ffffff"

    signal clicked
    signal clickedOutside

    onSourceChanged: delayPaintTimer.running = true
    onPaint: {
        var ctx = getContext("2d");
        ctx.reset(); // Clear previous drawing
        ctx.beginPath();
        ctx.ellipse(0, 0, width, height);
        ctx.clip();
        if (source === "")
            source = "icons/user-default.png";
        ctx.drawImage(source, 0, 0, width, height);
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.ArrowCursor

        function isCursorInsideAvatar() {
            // Calculate ellipse center and radius
            const centerX = width / 2;
            const centerY = height / 2;
            const radiusX = width / 2;
            const radiusY = height / 2;

            // Calculate normalized distance from center
            const dx = (mouseX - centerX) / radiusX;
            const dy = (mouseY - centerY) / radiusY;

            // Check if point is inside ellipse using the equation (x/a)² + (y/b)² ≤ 1
            return (dx * dx + dy * dy) <= 1.0;
        }

        // This is the key part - check if the click is within the ellipse
        onPressed: mouse => {
            const isInside = isCursorInsideAvatar();
            if (isInside) {
                avatar.clicked();
            } else {
                avatar.clickedOutside();
            }

            mouse.accepted = isInside;
        }

        function updateHover() {
            if (isCursorInsideAvatar()) {
                cursorShape = Qt.PointingHandCursor;
            } else {
                cursorShape = Qt.ArrowCursor;
            }
        }

        onMouseXChanged: updateHover()
        onMouseYChanged: updateHover()
    }

    // Fixme: paint() not affect event if source is not empty in initialization
    Timer {
        id: delayPaintTimer
        repeat: false
        interval: 150
        onTriggered: avatar.requestPaint()
        running: true
    }
}
