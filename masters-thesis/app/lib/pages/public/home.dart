// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <nelson0.vieira@gmail.com>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:app/main.dart";
import 'package:app/pages/public/about.dart';
import 'package:app/pages/public/encyclopedia.dart';
import 'package:app/models/device.dart';
import 'package:app/pages/devices/show.dart';
import 'package:app/pages/auth/account.dart';
import 'package:app/pages/devices/create.dart';
import 'package:app/pages/devices/update.dart';
import 'package:app/pages/devices/devices.dart';
import 'package:app/pages/auth/auth.dart';

class Home extends StatefulWidget {
  static const String route = "/";

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Marker> _markers = [];

//   Future<List<Marker>> getMarkers() async {
//     _markers.clear();
//     FirebaseFirestore.instance.collection("devices").snapshots().map(
//       (snapshot) {
//         snapshot.docs.map(
//           (doc) => doc.data().forEach(
//             (key, value) {
//               _markers;
//             },
//           ),
//         );
//       },
//     );
//     return _markers;
//   }

//   void initMarker(device) async {
//     final Marker marker = Marker(
//       width: 80,
//       height: 80,
//       point: LatLng(
//           double.parse(device["latitude"]), double.parse(device["longitude"])),
//       builder: (context) => GestureDetector(
//         onTap: () {
//           Navigator.of(context).pushNamed(ShowDevice.route, arguments: device);
//         },
//         child: const FlutterLogo(),
//       ),
//     );
//     // setState(() {
//     //   _markers = _markers.add(marker);
//     // });
//   }

//   getMarkers() async {
//     FirebaseFirestore.instance.collection("devices").get().then((data) {
//       if (data.docs.isNotEmpty) {
//         for (int i = 0; i < data.docs.length; i++) {
//           initMarker(data.docs[i].data());
//         }
//       }
//     });

  // Marker buildMarkers(Device device) => Marker(
  //       width: 80,
  //       height: 80,
  //       point: LatLng(
  //           double.parse(device.latitude), double.parse(device.longitude)),
  //       builder: (context) => GestureDetector(
  //         onTap: () {
  //           Navigator.of(context)
  //               .pushNamed(ShowDevice.route, arguments: device);
  //         },
  //         child: const FlutterLogo(),
  //       ),
  //     );

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
                  MarkerLayer(markers: _markers),
                  //   FutureBuilder(
                  //     future: getMarkers(),
                  //     builder: (context, snapshot) {
                  //       if (snapshot.hasError) {
                  //         return Center(
                  //             child: Text(
                  //           "Something went wrong! ${snapshot.error}",
                  //           style: const TextStyle(
                  //             color: Colors.white,
                  //             fontSize: 17.0,
                  //           ),
                  //           textAlign: TextAlign.center,
                  //         ));
                  //       } else if (snapshot.hasData) {
                  //         final devices = snapshot.data!;

                  //         return MarkerLayer(markers: _markers);
                  //       } else {
                  //         return const Center(
                  //           child: CircularProgressIndicator(),
                  //         );
                  //       }

                  //       //   if (snapshot.hasData) {
                  //       //     return MarkerLayer(markers: _markers.add(buildMarkers));
                  //       //   }
                  //       //   return Container();
                  //     },
                  //   ),
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
