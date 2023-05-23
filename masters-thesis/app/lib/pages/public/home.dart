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
  final List<Marker> _markers = <Marker>[];

  // Function to create a Marker and add to list
  void createMarker(Device device) async {
    final Marker marker = Marker(
      width: 30,
      height: 30,
      point:
          LatLng(double.parse(device.latitude), double.parse(device.longitude)),
      builder: (context) => GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(ShowDevice.route, arguments: device);
        },
        child: const FlutterLogo(),
      ),
    );
    // Only adds to the marker list with setState method
    setState(() {
      _markers.add(marker);
    });
  }

  // This function gets all devices from database and for each one, createMarker
  // is called which creates the Marker and adds to the markers list
  getMarkersData() async {
    await FirebaseFirestore.instance.collection("devices").get().then((data) {
      if (data.docs.isNotEmpty) {
        for (int i = 0; i < data.docs.length; i++) {
          createMarker(Device.fromJson(data.docs[i].data()));
        }
      }
    });
  }

  @override
  initState() {
    // This function runs whenever this page is loaded, very important so that
    // the data can be ready to show on the page
    getMarkersData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "IoT Privacy App",
          style: TextStyle(fontSize: 30),
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
                  interactiveFlags:
                      InteractiveFlag.all & ~InteractiveFlag.rotate,
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
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FirebaseAuth.instance.currentUser != null
          ? FloatingActionButton(
              tooltip: "Add a new device",
              child: const Row(
                children: [
                  Icon(Icons.add),
                  Icon(Icons.account_tree_outlined),
                ],
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(Create.route);
              })
          : Container(),
    );
  }
}