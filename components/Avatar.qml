import QtQuick
import QtQuick.Effects
import QtQuick.Controls

Rectangle {
    id: avatar
    property string shape: Config.avatarShape
    property string source: ""
    property string username: ""
    property bool active: false
    property int squareRadius: (shape == "circle") ? this.width : (Config.avatarBorderRadius === 0 ? 1 : Config.avatarBorderRadius * Config.generalScale) // min: 1
    property bool drawStroke: (active && Config.avatarActiveBorderSize > 0) || (!active && Config.avatarInactiveBorderSize > 0)
    property color strokeColor: active ? Config.avatarActiveBorderColor : Config.avatarInactiveBorderColor
    property int strokeSize: active ? (Config.avatarActiveBorderSize * Config.generalScale) : (Config.avatarInactiveBorderSize * Config.generalScale)
    property string tooltipText: ""
    property bool showTooltip: false

    signal clicked
    signal clickedOutside

    radius: squareRadius
    color: "transparent"
    antialiasing: true

    Image {
        id: faceImage
        source: parent.source
        anchors.fill: parent
        mipmap: true
        antialiasing: true
        visible: false
        smooth: true

        // FIX: Visual bug with the avatar – if the user uploads an image that is too large, the avatar appears distorted. The code below fixes this and works similarly to the CSS property `object-fit: cover;`.
        fillMode: Image.PreserveAspectCrop
        horizontalAlignment: Image.AlignHCenter
        verticalAlignment: Image.AlignVCenter

        Rectangle {
            anchors.fill: parent
            radius: avatar.squareRadius
            color: "transparent"
            border.width: avatar.strokeSize
            border.color: avatar.strokeColor
            antialiasing: true
        }

        onStatusChanged: {
            if (status === Image.Error) {
                facePlaceholder.visible = true;
                facePlaceholderBG.visible = true;
            }
        }

        Rectangle {
            id: facePlaceholderBG
            anchors.fill: parent
            radius: avatar.squareRadius
            color: Config.passwordInputBackgroundColor
            opacity: Config.passwordInputBackgroundOpacity > 0.1 ? Config.passwordInputBackgroundOpacity : 0.1
            visible: false
        }
        Text {
            id: facePlaceholder
            visible: false
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }
            text: avatar.username && avatar.username !== "" ? avatar.username[0].toUpperCase() : "~"
            font.pixelSize: parent.width / 2
            lineHeight: font.pixelSize
            fontSizeMode: Text.Fit
            font.bold: true
            font.family: Config.passwordInputFontFamily
            color: avatar.strokeColor === Config.passwordInputBackgroundColor && Config.passwordInputBackgroundOpacity === 1.0 ? Config.passwordInputContentColor : avatar.strokeColor
        }
    }

    MultiEffect {
        anchors.fill: faceImage
        antialiasing: true
        maskEnabled: true
        maskSource: faceImageMask
        maskSpreadAtMin: 1.0
        maskThresholdMax: 1.0
        maskThresholdMin: 0.5
        source: faceImage
    }

    Item {
        id: faceImageMask

        height: this.width
        layer.enabled: true
        layer.smooth: true
        visible: false
        width: faceImage.width

        Rectangle {
            height: this.width
            radius: avatar.squareRadius
            width: faceImage.width
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

        onReleased: function (mouse) {
            var isInside = isCursorInsideAvatar();
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
            property bool shouldShow: enabled && avatar.showTooltip || (enabled && mouseArea.isCursorInsideAvatar() && avatar.tooltipText !== "")
            visible: shouldShow
            delay: 300
            contentItem: Text {
                font.family: Config.tooltipsFontFamily
                font.pixelSize: Config.tooltipsFontSize * Config.generalScale
                text: avatar.tooltipText
                color: Config.tooltipsContentColor
            }
            background: Rectangle {
                color: Config.tooltipsBackgroundColor
                opacity: Config.tooltipsBackgroundOpacity
                border.width: 0
                radius: Config.tooltipsBorderRadius * Config.generalScale
            }
        }
    }
}
