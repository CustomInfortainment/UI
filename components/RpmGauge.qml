import QtQuick

Item {
    id: rpmgauge
    width: 200; height: 200

    property real rpmValue
    property real maxRpm

    //게이지 범위
    property real startAng
    property real endAng

    property real needleMoveRange

    //캔버스 프로퍼티
    property alias gaugeBackground: gaugeBackground
    property alias gaugeBackground2: gaugeBackground2
    property alias gaugeNeedle: gaugeNeedle

    //게이지 배경
    Canvas {
        id: gaugeBackground
        width: 200; height: 200

        property color strokeColor: "cyan"

        onStrokeColorChanged: requestPaint()

        onPaint: {
            var ctx = getContext("2d")

            var startDeg = startAng
            var endDeg = endAng

            var startRad = startDeg * Math.PI / 180
            var endRad = endDeg * Math.PI / 180

            ctx.beginPath()
            ctx.arc(100, 100, 90, startRad, endRad);

            ctx.strokeStyle = strokeColor
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

            var startDeg = startAng
            var endDeg = endAng

            var startRad = startDeg * Math.PI / 180
            var endRad = endDeg * Math.PI / 180

            ctx.beginPath()
            ctx.arc(100, 100, 90, startRad, endRad)
            ctx.fillStyle = "black"
            ctx.fill()
        }
    }

    Canvas {
        id: gaugeBackground3
        width: 200; height: 200

        property real tickRangeStartAng =
        property real tickRangeEndAng =

        onPaint: {
            var ctx = getContext("2d")

            var startDeg = startAng
            var endDeg = endAng

            var startRad = startDeg * Math.PI / 180
            var endRad = endDeg * Math.PI / 180

            var tickPosX =
        }
    }

    //게이지 바늘
    Canvas {
        id: gaugeNeedle
        width: 200; height: 200
        onPaint: {
            var ctx = getContext("2d")
            ctx.clearRect(0, 0, width, height)

            var startDeg = startAng
            var endDeg = endAng

            var startRad = startDeg * Math.PI / 180
            var endRad = (startDeg + (rpmgauge.rpmValue / rpmgauge.maxRpm) * needleMoveRange) * Math.PI / 180

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
