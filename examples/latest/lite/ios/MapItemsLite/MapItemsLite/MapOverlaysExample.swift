/*
 * Copyright (C) 2019-2021 HERE Europe B.V.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 * SPDX-License-Identifier: Apache-2.0
 * License-Filename: LICENSE
 */

import heresdk
import UIKit

class MapOverlaysExample {

    private var mapView: MapViewLite
    private let mapCenterGeoCoordinates = GeoCoordinates(latitude: 52.520798, longitude: 13.409408)

    init(mapView: MapViewLite) {
        self.mapView = mapView
        let camera = mapView.camera
        camera.setZoomLevel(12)

        camera.setTarget(mapCenterGeoCoordinates)
        addCircle(geoCoordinates: mapCenterGeoCoordinates)
    }

    func onDefaultButtonClicked() {
        showMapOverlay()
    }

    func onAnchoredButtonClicked() {
        showAnchoredMapOverlay()
    }

    func onClearButtonClicked() {
        clearMap()
    }

    private func showMapOverlay() {
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        textView.textAlignment = .center
        textView.isEditable = false
        textView.backgroundColor = UIColor(red: 72/255, green: 218/255, blue: 208/255, alpha: 1)
        textView.textColor = .white
        textView.font = .systemFont(ofSize: 17)
        textView.text = "Centered MapOverlay"

        let mapOverlay = MapOverlayLite(view: textView, geoCoordinates: mapCenterGeoCoordinates)
        mapView.addMapOverlay(mapOverlay)
    }

    private func showAnchoredMapOverlay() {
        let textView = UITextView(frame: CGRect(x: 0, y: 0, width: 200, height: 40))
        textView.textAlignment = .center
        textView.isEditable = false
        textView.backgroundColor = UIColor(red: 0/255, green: 144/255, blue: 138/255, alpha: 1)
        textView.textColor = .white
        textView.font = .systemFont(ofSize: 17)
        textView.text = "Anchored MapOverlay"
        textView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)

        let mapOverlay = MapOverlayLite(view: textView, geoCoordinates: mapCenterGeoCoordinates)
        mapView.addMapOverlay(mapOverlay)
    }

    private func clearMap() {
        mapView.overlays.forEach {
            mapView.removeMapOverlay($0)
        }
    }

    private func addCircle(geoCoordinates: GeoCoordinates) {
        let geoCircle = GeoCircle(center: geoCoordinates,
                                  radiusInMeters: 30.0)
        let mapCircleStyle = MapCircleStyleLite()
        mapCircleStyle.setFillColor(0x00908AA0, encoding: .rgba8888)
        let mapCircle = MapCircleLite(geometry: geoCircle, style: mapCircleStyle)
        mapView.mapScene.addMapCircle(mapCircle)
    }
}
