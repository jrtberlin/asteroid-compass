/*
 * Copyright (C) 2017 - Florent Revest  <revestflo@gmail.com>
 *                    - Niels Tholenaar <info@123quality.nl>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.9
import org.asteroid.controls 1.0
import QtSensors 5.3

Application {
    id: app

    centerColor: "#4cd479"
    outerColor: "#1c723a"

    property int rotation: 0;
    property int calibration: 0;
    property bool calibrated: false;

    Compass {
        active: true
        onReadingChanged: {
            app.rotation = reading.azimuth;
            app.calibration = reading.calibrationLevel;
            if (app.calibration === 0) {
                app.calibrated = false;
            } else {
                app.calibrated = true;
            }
            calibrationInfo.visible = !app.calibrated;
        }
    }

    Image {
        anchors.fill: parent
        anchors.margins: Dims.l(15)
        fillMode: Image.PreserveAspectFit
        source: "qrc:///compass.svg"
        rotation: -app.rotation
        height: 200;
        sourceSize.width: width
        sourceSize.height: height
    }

    Label {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Dims.l(7)
        font.pixelSize: Dims.l(5)
        text: app.rotation + " °N"
    }

    Label {
        id: calibrationInfo
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: Dims.l(7)
        font.pixelSize: Dims.l(5)
        //% "Calibrate with ∞-figure"
	text: qsTrId("calibration-text")
    }

}
