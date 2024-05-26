// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2024 Nelson Vieira
//
// @author Nelson Vieira <2080511@student.uma.pt>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";

class Map extends StatelessWidget {
  const Map({
    Key? key,
    required List<Marker> markers,
    required this.initialPosition,
  })  : _markers = markers,
        super(key: key);

  final List<Marker> _markers;
  final LatLng initialPosition;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: initialPosition,
        interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
        zoom: 9,
      ),
      nonRotatedChildren: [
        AttributionWidget.defaultWidget(
          source: "OpenStreetMap",
          onSourceTapped: null,
          sourceTextStyle: const TextStyle(
            color: Color.fromARGB(255, 30, 30, 30),
            fontSize: 10,
          ),
        ),
      ],
      children: [
        TileLayer(
          urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
          userAgentPackageName: "me.nelsonvieira.iotprivacy",
        ),
        MarkerLayer(markers: _markers),
      ],
    );
  }
}
