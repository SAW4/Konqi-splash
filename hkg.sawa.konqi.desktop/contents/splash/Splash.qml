/*
 *   Author :   Sato Sawa 
 *   E-mail :   satosawa93@gmail.com
 *   Github :   https://github.com/SatoSawa/Konqi-splash    
 *
 */

import QtQuick 2.7

Rectangle {
    id: root
    color: "black"

    property int stage

    onStageChanged: {
        if (stage == 2) {
            introAnimation.running = true;
            konqiAnimation.running = true;
        } else if (stage == 5) {
            introAnimation.target = busyIndicator;
            introAnimation.from = 1;
            introAnimation.to = 0;
            introAnimation.running = true;
        }
    }

    Item {
        id: content
        anchors.fill: parent
        opacity: 0
        TextMetrics {
            id: units
            text: "M"
            property int gridUnit: boundingRect.height
            property int largeSpacing: units.gridUnit
            property int smallSpacing: Math.max(2, gridUnit/4)
        }

        Image {
            id: konqi_logo
            property real size: units.gridUnit * 32
            anchors.centerIn: parent
            source: "images/konqi.svgz"
            sourceSize.width: size
            sourceSize.height: size           
        }        
                

        Image {
            id: busyIndicator
            //in the middle of the remaining space
            y: (parent.height - konqi_logo.y) + 10
            anchors.horizontalCenter: parent.horizontalCenter
            source: "images/busy.svg"
            sourceSize.height: units.gridUnit * 5
            sourceSize.width: units.gridUnit * 5
            RotationAnimator on rotation {
                id: rotationAnimator
                from: 0
                to: 360
                duration: 1500
                loops: Animation.Infinite
            }
        }
    }

    OpacityAnimator {
        id: introAnimation
        running: false
        target: content
        from: 0
        to: 1
        duration: 1000
        easing.type: Easing.InOutQuad
    }
    ScaleAnimator {
        id: konqiAnimation
        target: konqi_logo
        from: 2
        to: 1
        duration: 700
    }    
}
