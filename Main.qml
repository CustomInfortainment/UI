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

        Text {
            id: helloText
            text: "Hello World!"
            y: 30
            anchors.horizontalCenter: page.horizontalCenter
            font.pointSize: 24; font.bold: true

            MouseArea { id: mouseArea; anchors.fill: parent}

            states: State {
                name: "down"; when: mouseArea.pressed == true
                PropertyChanges {
                    helloText {
                        y: 160
                        rotation: 180
                        color: "red"
                    }
                }
            }

            transitions: Transition {
                from: " "; to: "down"; reversible: true
                ParallelAnimation {
                    NumberAnimation { properties: "y,rotation"; duration: 500; easing.type: Easing.InOutQuad }
                    ColorAnimation {
                        duration: 500
                    }
                }
            }

            states: State {
                name: "clusterHighlight"; when: rpmgauge.rpmValue > 5000
                PropertyChanges {


                }
            }

            transitions: Transition {

            }
        }

        RpmGauge {
            id: rpmgauge
            anchors.centerIn: parent
            rpmValue: 0
            maxRpm: 8000

            startAng: 140
            endAng: 40

            needleMoveRange: 240
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
