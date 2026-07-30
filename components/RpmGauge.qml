import QtQuick

Item {
    id: rpmgauge
    width: 200; height: 200

    property real rpmValue
    property real maxRpm

    //게이지 배경
    Canvas {
        id: gaugeBackground
        width: 200; height: 200
        onPaint: {
            var ctx = getContext("2d")

            var startDeg = 0
            var endDeg = 270

            var startRad = startDeg * Math.PI / 180
            var endRad = endDeg * Math.PI / 180

            ctx.beginPath()
            ctx.arc(100, 100, 90, startRad, endRad);

            ctx.strokeStyle = "cyan"
            ctx.lineWidth = 10
            ctx.stroke()
        }
    }
    //게이지 안쪽 배경
    Canvas {
        id: gaugeBackground2
        width: 200; height: 200
        onPaint: {
            var ctx = getContext("2d")

            var startDeg = 0
            var endDeg = 270

            var startRad = startDeg * Math.PI / 180
            var endRad = endDeg * Math.PI / 180

            ctx.beginPath()
            ctx.arc(100, 100, 90, startRad, endRad)
            ctx.fillStyle = "black"
            ctx.fill()
        }
    }

    Canvas {
        id: gaugeNeedle
        width: 200; height: 200
        onPaint: {
            var ctx = getContext("2d")
            ctx.clearRect(0, 0, width, height)

            var startDeg = 0
            var endDeg = 270

            var startRad = startDeg * Math.PI / 180
            var endRad = (startDeg + (rpmgauge.rpmValue / rpmgauge.maxRpm) * endDeg) * Math.PI / 180

            var needleRange = 90

            var centerX = width / 2
            var centerY = height / 2

            //바늘 목적지
            var tipX = centerX + 90 * Math.cos(endRad)
            var tipY = centerY + 90 * Math.sin(endRad)

            var baseWidth = 5

            //바늘 밑부분
            var leftX = centerX + baseWidth * Math.cos(endRad + 90 * Math.PI / 180)
            var leftY = centerY + baseWidth * Math.sin(endRad + 90 * Math.PI / 180)
            var rightX = centerX + baseWidth * Math.cos(endRad - 90 * Math.PI / 180)
            var rightY = centerY + baseWidth * Math.sin(endRad - 90 * Math.PI / 180)

            ctx.beginPath()
            ctx.moveTo(tipX, tipY)
            ctx.lineTo(leftX, leftY)
            ctx.lineTo(rightX, rightY)
            ctx.closePath()
            ctx.fillStyle = "red"
            ctx.fill()
        }
    }

    onRpmValueChanged: {
        gaugeNeedle.requestPaint()
    }
}
