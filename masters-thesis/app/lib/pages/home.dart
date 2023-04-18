// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <nelson0.vieira@gmail.com>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "package:app/pages/about.dart";

Padding home() {
  return Padding(
    padding:
        const EdgeInsets.only(top: 2.0, right: 4.0, left: 4.0, bottom: 4.0),
    child: Column(
      children: [
        Flexible(
          child: FlutterMap(
            options: MapOptions(
              center: LatLng(32.778295173354356, -16.737781931587615),
              zoom: 9,
            ),
            nonRotatedChildren: [
              AttributionWidget.defaultWidget(
                source: "OpenStreetMap",
                onSourceTapped: null,
              ),
            ],
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: "me.nelsonvieira.iot_privacy_app",
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
