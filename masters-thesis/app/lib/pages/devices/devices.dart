// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <nelson0.vieira@gmail.com>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "package:firebase_core/firebase_core.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'dart:math' as math;
import "package:app/main.dart";
import "package:app/models/device.dart";
import 'package:app/pages/public/home.dart';
import 'package:app/pages/public/about.dart';
import 'package:app/pages/public/encyclopedia.dart';
import 'package:app/pages/auth/account.dart';
import 'package:app/pages/devices/create.dart';
import 'package:app/pages/devices/update.dart';
import 'package:app/pages/devices/show.dart';
import 'package:app/pages/auth/auth.dart';

class Devices extends StatefulWidget {
  static const String route = "/devices";

  const Devices({super.key});

  @override
  State<Devices> createState() => _DevicesState();
}

class _DevicesState extends State<Devices> {
  Stream<List<Device>> readDevices() => FirebaseFirestore.instance
      .collection("devices")
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Device.fromJson(doc.data())).toList());

  AssetImage markerImage(Device device) {
    switch (device.category) {
      case "08gNFyCLyxSxiYIcdFx0":
        return AssetImage("assets/images/unique_identification.png");
      case "1qyoLqyrgmLTpLklqgFX":
        return AssetImage("assets/images/environment.png");
      case "6yYW2K9Fv9AogHPfut5l":
        return AssetImage("assets/images/biometrics.png");
      case "WnvAzxPaI5Z8hFzUE228":
        return AssetImage("assets/images/location.png");
      case "bvf9p6MYF1DwxgDab2Mp":
        return AssetImage("assets/images/presence.png");
      case "rhSmoONpwDl8B1mrXBZL":
        return AssetImage("assets/images/audio.png");
      case "vfWA43iLPsUj6ZW3D5Rg":
        return AssetImage("assets/images/visual.png");
      default:
        return AssetImage("assets/images/icon.png");
    }
  }

  Widget buildDevices(Device device) => Container(
        decoration: BoxDecoration(
          color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
              .withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
        ),
        margin: const EdgeInsets.only(bottom: 10),
        child: ListTile(
          textColor: const Color.fromARGB(255, 255, 255, 255),
          titleTextStyle:
              const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          subtitleTextStyle: const TextStyle(fontSize: 16.0),
          title: Text(
            device.name,
          ),
          subtitle: Text(
            device.purpose,
          ),
          onTap: () {
            Navigator.of(context)
                .pushNamed(ShowDevice.route, arguments: device);
          },
          leading: CircleAvatar(
            foregroundImage: markerImage(device),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Devices",
          style: TextStyle(fontSize: 30),
        ),
        backgroundColor: const Color(0xFF334150),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 2.0, right: 4.0, left: 4.0, bottom: 4.0),
        child: Container(
          padding: const EdgeInsets.all(16),
          color: const Color.fromARGB(255, 16, 44, 53),
          child: FutureBuilder(
              future: readDevices().first,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                    "Something went wrong! ${snapshot.error}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                    ),
                    textAlign: TextAlign.center,
                  ));
                } else if (snapshot.hasData) {
                  final devices = snapshot.data!;

                  return FirebaseAuth.instance.currentUser != null
                      ? Column(
                          children: <Widget>[
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: const Size.fromHeight(50),
                                backgroundColor: Color(0xFF0A8A4E),
                                padding: const EdgeInsets.only(
                                    left: 0.0,
                                    top: 18.0,
                                    right: 0.0,
                                    bottom: 18.0),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushNamed(Create.route);
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.account_tree_outlined),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    "Add Device",
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            ListView(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: devices.map(buildDevices).toList(),
                            )
                          ],
                        )
                      : ListView(
                          children: devices.map(buildDevices).toList(),
                        );
                  // ListView(
                  //   children: devices.map(buildDevices).toList(),
                  // );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }
}
