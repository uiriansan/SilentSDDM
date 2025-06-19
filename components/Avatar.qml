import QtQuick
import QtQuick.Controls
import QtQuick.Effects

Canvas {
    id: avatar

    signal clicked
    signal clickedOutside

    property bool active: false
    property bool authenticating: false
    property string source: ""
    property string userName: ""
    property string shape: Config.avatarShape
    property int squareRadius: Config.avatarBorderRadius === 0 ? 1 : Config.avatarBorderRadius
    property bool drawStroke: (active ? Config.avatarActiveBorderSize : Config.avatarInactiveBorderSize) > 0
    property color strokeColor: active ? Config.avatarActiveBorderColor : Config.avatarInactiveBorderColor
    property int strokeSize: active ? Config.avatarActiveBorderSize : Config.avatarInactiveBorderSize
    property string tooltipText: ""
    property bool showTooltip: false
    property bool imageLoaded: false
    property bool isHovered: mouseArea.containsMouse && mouseArea.isCursorInsideAvatar()

    // Enhanced visual feedback - disabled when authenticating/locked
    scale: authenticating ? 1.0 : (mouseArea.pressed ? 0.95 : (isHovered ? 1.05 : 1.0))
    opacity: active ? 1.0 : Config.avatarInactiveOpacity
    
    Behavior on scale {
        enabled: Config.enableAnimations && !authenticating
        NumberAnimation {
            duration: 200
            easing.type: Easing.OutCubic
        }
    }
    
    Behavior on opacity {
        enabled: Config.enableAnimations
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutCubic
        }
    }

    // Generate initials from username for fallback
    function getInitials(name) {
        if (!name || name.length === 0) return "?";
        var words = name.trim().split(/\s+/);
        if (words.length === 1) {
            return words[0].charAt(0).toUpperCase();
        }
        return (words[0].charAt(0) + words[words.length - 1].charAt(0)).toUpperCase();
    }

    // Generate color from username
    function getUserColor(name) {
        if (!name) return "#6B7280";
        var hash = 0;
        for (var i = 0; i < name.length; i++) {
            hash = name.charCodeAt(i) + ((hash << 5) - hash);
        }
        var colors = [
            "#EF4444", "#F97316", "#F59E0B", "#EAB308",
            "#84CC16", "#22C55E", "#10B981", "#14B8A6",
            "#06B6D4", "#0EA5E9", "#3B82F6", "#6366F1",
            "#8B5CF6", "#A855F7", "#D946EF", "#EC4899"
        ];
        return colors[Math.abs(hash) % colors.length];
    }

    onSourceChanged: delayPaintTimer.running = true
    onPaint: {
        var ctx = getContext("2d");
        ctx.reset();
        
        // Save initial state before clipping
        ctx.save();
        ctx.beginPath();

        // Create clipping path
        if (shape === "square") {
            var r = width > 0 ? width * squareRadius / 100 : 0;
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

        // Try to draw user avatar first, fallback to initials only
        var imageDrawn = false;
        try {
            if (source && source !== "") {
                ctx.drawImage(source, 0, 0, width, height);
                imageLoaded = true;
                imageDrawn = true;
            }
        } catch (e) {
            console.log("Failed to load avatar image:", e);
            imageLoaded = false;
        }

        // Fallback: Draw initials with colored background
        if (!imageDrawn || !imageLoaded) {
            // Background gradient
            var gradient = ctx.createLinearGradient(0, 0, width, height);
            var baseColor = getUserColor(userName);
            gradient.addColorStop(0, baseColor);
            gradient.addColorStop(1, Qt.darker(baseColor, 1.2));
            
            ctx.fillStyle = gradient;
            ctx.fillRect(0, 0, width, height);

            // Draw initials
            var initials = getInitials(userName);
            ctx.fillStyle = "#FFFFFF";
            var fontSize = Math.max(Math.floor(width * 0.4), 16);
            ctx.font = fontSize + "px " + Config.usernameFontFamily;
            ctx.textAlign = "center";
            ctx.textBaseline = "middle";
            var centerX = width / 2;
            var centerY = height / 2;
            ctx.fillText(initials, centerX, centerY);
        }

        // Restore state and draw border
        ctx.restore();
        
        // Enhanced border with glow effect
        if (drawStroke && strokeColor.a > 0) {
            ctx.beginPath();
            
            if (shape === "square") {
                var r = width * squareRadius / 100;
                ctx.moveTo(width - r, 0);
                ctx.arcTo(width, 0, width, height, r);
                ctx.arcTo(width, height, 0, height, r);
                ctx.arcTo(0, height, 0, 0, r);
                ctx.arcTo(0, 0, width, 0, r);
                ctx.closePath();
            } else {
                ctx.ellipse(0, 0, width, height);
            }
            
            ctx.strokeStyle = strokeColor;
            ctx.lineWidth = strokeSize;
            ctx.stroke();
            
            // Add subtle glow for active avatar
            if (active && Config.enableAnimations) {
                ctx.shadowColor = strokeColor;
                ctx.shadowBlur = strokeSize * 2;
                ctx.stroke();
            }
        }
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: !authenticating
        cursorShape: Qt.ArrowCursor

        function isCursorInsideAvatar() {
            if (!mouseArea.containsMouse)
                return false;
            if (avatar.shape === "square")
                return true;

            // Ellipse center and radius
            var centerX = width / 2;
            var centerY = height / 2;
            var radiusX = centerX;
            var radiusY = centerY;

            // Distance from center
            var dx = (mouseArea.mouseX - centerX) / radiusX;
            var dy = (mouseArea.mouseY - centerY) / radiusY;

            // Check if pointer is inside the ellipse
            return (dx * dx + dy * dy) <= 1.0;
        }

        onReleased: function(mouse) {
            var isInside = isCursorInsideAvatar();
            if (isInside) {
                avatar.clicked();
            } else {
                avatar.clickedOutside();
            }
            mouse.accepted = isInside;
        }

        function updateHover() {
            if (authenticating) {
                cursorShape = Qt.ArrowCursor;
            } else if (isCursorInsideAvatar()) {
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
