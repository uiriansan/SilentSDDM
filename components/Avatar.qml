import QtQuick
import QtQuick.Controls

Canvas {
    id: avatar

    signal clicked
    signal clickedOutside

    property bool active: false
    property string source: ""
    property string shape: Config.avatarShape
    property int squareRadius: Config.avatarBorderRadius === 0 ? 1 : Config.avatarBorderRadius // min: 1
    property bool drawStroke: (active && Config.avatarActiveBorderSize > 0) || (!active && Config.avatarInactiveBorderSize > 0)
    property color strokeColor: active ? Config.avatarActiveBorderColor : Config.avatarInactiveBorderColor
    property int strokeSize: active ? Config.avatarActiveBorderSize : Config.avatarInactiveBorderSize
    property string tooltipText: ""
    property bool showTooltip: false

    onSourceChanged: delayPaintTimer.running = true
    onPaint: {
        const ctx = getContext("2d");
        ctx.reset(); // Clear previous drawing
        ctx.beginPath();

        if (shape === "square") {
            // Squircle, actually
            const r = width * squareRadius / 100;
            ctx.moveTo(width - r, 0);
            ctx.arcTo(width, 0, width, height, r);
            ctx.arcTo(width, height, 0, height, r);
            ctx.arcTo(0, height, 0, 0, r);
            ctx.arcTo(0, 0, width, 0, r);
            ctx.closePath();
        } else {
            // Circle
            ctx.ellipse(0, 0, width, height);
        }
        ctx.clip();

        if (source === "")
            source = "../icons/user-default.png";
        ctx.drawImage(source, 0, 0, width, height);

        // Border
        if (drawStroke) {
            ctx.strokeStyle = strokeColor;
            ctx.lineWidth = strokeSize;
            ctx.stroke();
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.ArrowCursor

        function isCursorInsideAvatar() {
            if (!mouseArea.containsMouse)
                return false;
            if (avatar.shape === "square")
                return true;

            // Ellipse center and radius
            const centerX = width / 2;
            const centerY = height / 2;
            const radiusX = centerX;
            const radiusY = centerY;

            // Distance from center
            const dx = (mouseArea.mouseX - centerX) / radiusX;
            const dy = (mouseArea.mouseY - centerY) / radiusY;

            // Check if pointer is inside the ellipse
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

        ToolTip {
            parent: mouseArea
            enabled: Config.tooltipsEnable && !Config.tooltipsDisableUser
            visible: enabled && avatar.showTooltip || (enabled && mouseArea.isCursorInsideAvatar() && avatar.tooltipText !== "")
            delay: 300
            contentItem: Text {
                font.family: Config.tooltipsFontFamily
                font.pixelSize: Config.tooltipsFontSize
                text: avatar.tooltipText
                color: Config.tooltipsContentColor
            }
            background: Rectangle {
                color: Config.tooltipsBackgroundColor
                opacity: Config.tooltipsBackgroundOpacity
                border.width: 0
                radius: Config.tooltipsBorderRadius
            }
        }
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
