import QtQuick 2.2

Canvas {
    id: avatar
    property string source: ""
    property color m_strokeStyle: "#ffffff"

    signal clicked()

    onSourceChanged: delayPaintTimer.running = true
    onPaint: {
        var ctx = getContext("2d");
        ctx.beginPath()
        ctx.ellipse(0, 0, width, height)
        ctx.clip()
        ctx.drawImage(source, 0, 0, width, height)
        ctx.strokeStyle = avatar.m_strokeStyle
        ctx.lineWidth = 6
        ctx.stroke()
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: {
            m_strokeStyle = "#77ffffff"
            avatar.requestPaint()
        }
        onExited: {
            m_strokeStyle = "#ffffffff"
            avatar.requestPaint()
        }
        onClicked: avatar.clicked()
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
