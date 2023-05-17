// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <nelson0.vieira@gmail.com>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:app/main.dart";
import "package:app/pages/about.dart";
import "package:app/pages/encyclopedia.dart";
import "package:app/pages/account.dart";
import 'package:app/pages/devices/create.dart';
import 'package:app/pages/devices/update.dart';
import 'package:app/pages/devices/devices.dart';
import "package:app/pages/auth.dart";

class Home extends StatelessWidget {
  static const String route = "/";

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "IoT Privacy App",
          style: const TextStyle(fontSize: 30),
        ),
        backgroundColor: const Color(0xFF334150),
      ),
      body: Padding(
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
                    urlTemplate:
                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    userAgentPackageName: "me.nelsonvieira.iot_privacy_app",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FirebaseAuth.instance.currentUser != null
          ? FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(Create.route);
              })
          : Container(),
    );
  }
}

// Padding home() {
//   return Padding(
//     padding:
//         const EdgeInsets.only(top: 2.0, right: 4.0, left: 4.0, bottom: 4.0),
//     child: Column(
//       children: [
//         Flexible(
//           child: FlutterMap(
//             options: MapOptions(
//               center: LatLng(32.778295173354356, -16.737781931587615),
//               zoom: 9,
//             ),
//             nonRotatedChildren: [
//               AttributionWidget.defaultWidget(
//                 source: "OpenStreetMap",
//                 onSourceTapped: null,
//               ),
//             ],
//             children: [
//               TileLayer(
//                 urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
//                 userAgentPackageName: "me.nelsonvieira.iot_privacy_app",
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }
