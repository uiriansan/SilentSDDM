import QtQuick

Canvas {
    id: avatar
    property string source: ""
    property string avatarShape: "circle"
    property int squareRadius: 20 // min: 1
    property bool drawStroke: false
    property color strokeColor: "#ffffff"
    property int strokeSize: 2
    property bool drawShadow: true

    signal clicked
    signal clickedOutside

    // https://github.com/uiriansan/SilentSDDM/commit/4be55b0a45036f6052bc4958eb335f87d2a005f9#diff-bc8308d345b73b6024951322fad1ccbd20a74df91e4c9b9a16ae957745047881

    onSourceChanged: delayPaintTimer.running = true
    onPaint: {
        var ctx = getContext("2d");
        ctx.reset(); // Clear previous drawing
        ctx.beginPath();

        if (avatarShape === "square") {
            const r = width * squareRadius / 100;
            ctx.moveTo(width - r, 0);
            ctx.arcTo(width, 0, width, height, r);
            ctx.arcTo(width, height, 0, height, r);
            ctx.arcTo(0, height, 0, 0, r);
            ctx.arcTo(0, 0, width, 0, r);
            ctx.closePath();
        } else {
            ctx.ellipse(0, 0, width, height);
        }

        ctx.clip();

        if (source === "")
            source = "icons/user-default.png";
        ctx.drawImage(source, 0, 0, width, height);

        if (drawStroke) {
            ctx.strokeStyle = avatar.strokeColor;
            ctx.lineWidth = avatar.strokeSize;
            ctx.stroke();
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.ArrowCursor

        function isCursorInsideAvatar() {
            if (avatar.avatarShape === "square" || avatar.avatarShape === "squircle")
                return true;

            // Calculate ellipse center and radius
            const centerX = width / 2;
            const centerY = height / 2;
            const radiusX = width / 2;
            const radiusY = height / 2;

            // Distance from center
            const dx = (mouseX - centerX) / radiusX;
            const dy = (mouseY - centerY) / radiusY;

            // Check if pointer is inside ellipse
            return (dx * dx + dy * dy) <= 1.0;
        }

        onReleased: mouse => {
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

    // FIX: paint() not affect event if source is not empty in initialization
    Timer {
        id: delayPaintTimer
        repeat: false
        interval: 150
        onTriggered: avatar.requestPaint()
        running: true
    }
}
