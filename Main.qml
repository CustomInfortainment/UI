import QtQuick

Window {
    width: 1024
    height: 600
    visible: true
    title: qsTr("Hello World")

    // 전체 배경
    Canvas {
        id: allBackground
        width: 1024
        height: 600
        anchors.centerIn: parent

        onPaint: {
            var ctx = getContext("2d");

            ctx.beginPath();
            ctx.rect(0, 0, width, height);
            ctx.fillStyle = "blue"
            ctx.closePath();
            ctx.fill();
        }
    }

    // 게이지 배경
    Canvas {
        id: rpmGaugeBgCanvas
        width: 640
        height: 480
        anchors.centerIn: parent

        onPaint: {
            var ctx = getContext("2d");

            // 중앙값
            var centerX = width / 2;
            var centerY = height / 2;

            //-----------------------RPM-----------------------
            // RPM 게이지 위치
            var rpmPosX = centerX - 30;

            // RPM 게이지 각도
            var rpmStartAng = 135 * Math.PI / 180;
            var rpmEndAng = 45 * Math.PI / 180;

            // RPM 전체 배경
            ctx.beginPath();
            ctx.fillStyle = Qt.rgba(0.3, 0.3, 0.3, 1);
            ctx.lineWidth = 15;
            ctx.arc(rpmPosX, centerY, 115, rpmStartAng, rpmEndAng , false);
            ctx.fill();

            // RPM 바깥 테두리
            ctx.beginPath();
            ctx.arc(rpmPosX, centerY, 115, rpmStartAng, rpmEndAng , false);
            ctx.lineWidth = 10;
            ctx.stroke();
            ctx.arc(rpmPosX, centerY, 90, rpmStartAng, rpmEndAng, false);

            //-----------------------수온게이지-----------------------
            // 수온게이지 위치
            var coolentTempPosX = centerX - 50;

            ctx.beginPath();

            for(var i = 0; i < 40; i++)
            {
                var pos = (135 + (i / 40) * 270) * Math.PI / 180;

                var x1 = centerX + 100 * Math.cos(pos);
                var y1 = centerY + 100 * Math.sin(pos);

                var x2 = centerX + 115 * Math.cos(pos);
                var y2 = centerY + 115 * Math.sin(pos);

                ctx.lineWidth = 2;
                ctx.moveTo(x1, y1);
                ctx.lineTo(x2, y2);

                if(i % 5 == 0)
                {
                    var textX = centerX + 85 * Math.cos(pos);
                    var textY = centerY + 85 * Math.sin(pos);

                    ctx.textAlign = "center";
                    ctx.textBaseline = "middle";
                    ctx.fillStyle = "white";
                    ctx.fillText(i * 200, textX, textY);
                }
            }
            ctx.stroke();
        }
    }

    //게이지
    Canvas {
        id: rpmGaugeCanvas
        width: 640
        height: 480
        anchors.centerIn: parent

        property real rpm: 0
        onRpmChanged: requestPaint()

        onPaint: {
            var centerX = width / 2;
            var centerY = height / 2;

            var ctx = getContext("2d");

            var gaugeStartAng = 135 * Math.PI / 180;
            var gaugeEndAng = (135 + (rpm / 8000) * 270) * Math.PI / 180;

            ctx.clearRect(0, 0, width, height);
            ctx.beginPath();
            ctx.strokeStyle = Qt.rgba(0.2, 1, 0.8, 1);
            ctx.lineWidth = 10;
            ctx.arc(centerX, centerY, 105, gaugeStartAng, gaugeEndAng, false);
            ctx.stroke();

            ctx.beginPath();
            var tipX = centerX + 90 * Math.cos(gaugeEndAng);
            var tipY = centerY + 90 * Math.sin(gaugeEndAng);

            var baseWidth = 5;

            var leftX = centerX + baseWidth * Math.cos(gaugeEndAng + Math.PI / 2);
            var leftY = centerY + baseWidth * Math.sin(gaugeEndAng + Math.PI / 2);
            var rightX = centerX + baseWidth * Math.cos(gaugeEndAng - Math.PI / 2);
            var rightY = centerY + baseWidth * Math.sin(gaugeEndAng - Math.PI / 2);

            ctx.moveTo(tipX, tipY);
            ctx.lineTo(rightX, rightY);
            ctx.lineTo(leftX, leftY);
            ctx.closePath();
            ctx.fillStyle = "red";
            ctx.fill();
        }
    }

    //게이지 테스트용
    Timer {
        interval: 30
        running: true
        repeat: true
        onTriggered: {
            rpmGaugeCanvas.rpm += 100
            if(rpmGaugeCanvas.rpm > 8000) rpmGaugeCanvas.rpm = 0
        }
    }
}
