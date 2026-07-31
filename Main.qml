import QtQuick

import "components"

Window {
    visible: true
    width: 480
    height: 480

    Rectangle {
        id: page
        width: 480; height: 480
        color: "lightgray"

        RpmGauge {
            id: rpmgauge
            anchors.centerIn: parent
            rpmValue: 0
            maxRpm: 8000

            startAng: 140
            endAng: 40

            needleMoveRange: 240

            states: State {
                name: "clusterHighlight"; when: rpmgauge.rpmValue > 5000
                PropertyChanges {
                    target: rpmgauge.gaugeBackground
                    strokeColor: "red"
                }
            }

            transitions: Transition {
                from: " "; to: "clusterHighlight"; reversible: true
                ParallelAnimation {
                    ColorAnimation {
                        duration: 500
                    }
                }
            }
        }

        Grid {
            id: colorPicker
            x: 4; anchors.bottom: page.bottom; anchors.bottomMargin: 4
            rows: 2; columns: 3; spacing: 3

            Cell { cellColor: "red"; onClicked: helloText.color = cellColor }
            Cell { cellColor: "green"; onClicked: helloText.color = cellColor }
            Cell { cellColor: "blue"; onClicked: helloText.color = cellColor }
            Cell { cellColor: "yellow"; onClicked: helloText.color = cellColor }
            Cell { cellColor: "steelblue"; onClicked: helloText.color = cellColor }
            Cell { cellColor: "black"; onClicked: helloText.color = cellColor }
        }

        //게이지 테스트용
        Timer {
            interval: 30
            running: true
            repeat: true
            onTriggered: {
                rpmgauge.rpmValue += 100
                if(rpmgauge.rpmValue > 8000) rpmgauge.rpmValue = 0
            }
        }
    }
}
