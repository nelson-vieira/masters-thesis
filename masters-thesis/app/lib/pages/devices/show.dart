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
import 'package:url_launcher/url_launcher.dart';
import "package:app/main.dart";
import "package:app/models/device.dart";
import 'package:app/pages/public/home.dart';
import 'package:app/pages/public/about.dart';
import 'package:app/pages/public/encyclopedia.dart';
import 'package:app/pages/auth/account.dart';
import 'package:app/pages/devices/create.dart';
import 'package:app/pages/devices/update.dart';
import 'package:app/pages/devices/devices.dart';
import 'package:app/pages/auth/auth.dart';

class ShowDevice extends StatefulWidget {
  static const String route = "/showdevice";

  final Device device;
  const ShowDevice({super.key, required this.device});

  @override
  State<ShowDevice> createState() => _ShowDeviceState();
}

class _ShowDeviceState extends State<ShowDevice> {
  var _url;

  Future<Device?> readDevice() async {
    final docDevice =
        FirebaseFirestore.instance.collection("devices").doc(widget.device.id);
    final snapshot = await docDevice.get();

    if (snapshot.exists) {
      return Device.fromJson(snapshot.data()!);
    }
  }

  Widget buildDevice(Device device) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 40.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset("assets/icon.png", width: 60.0),
                          const SizedBox(
                            height: 20,
                          ),
                          FutureBuilder(
                              future: FirebaseFirestore.instance
                                  .collection("categories")
                                  .doc(device.category)
                                  .get(),
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
                                  final category = snapshot.data!;

                                  return Text(
                                    category.get("name"),
                                    style: const TextStyle(
                                        fontSize: 16.0, color: Colors.white),
                                  );
                                } else {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                              }),
                        ],
                      ),
                    ),
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(50),
                        1: FlexColumnWidth(50),
                      },
                      children: <TableRow>[
                        TableRow(
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.only(
                                  top: 0.0,
                                  right: 20.0,
                                  bottom: 0.0,
                                  left: 0.0),
                              child: Text(
                                "Who has access to the data?",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              device.whoHasAccess,
                              style: const TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                          ],
                        ),
                        const TableRow(children: [
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ]),
                        TableRow(
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.only(
                                  top: 0.0,
                                  right: 20.0,
                                  bottom: 0.0,
                                  left: 0.0),
                              child: Text(
                                "What is the purpose for collection?",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              device.purpose,
                              style: const TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                          ],
                        ),
                        const TableRow(children: [
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ]),
                        TableRow(
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.only(
                                  top: 0.0,
                                  right: 20.0,
                                  bottom: 0.0,
                                  left: 0.0),
                              child: Text(
                                "Can the data identify someone?",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              device.identifiable == true ? "Yes" : "No",
                              style: const TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                          ],
                        ),
                        const TableRow(children: [
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ]),
                        TableRow(
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.only(
                                  top: 0.0,
                                  right: 20.0,
                                  bottom: 0.0,
                                  left: 0.0),
                              child: Text(
                                "What is being done with the data?",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              device.whatsDone,
                              style: const TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                          ],
                        ),
                        const TableRow(children: [
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ]),
                        TableRow(
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.only(
                                  top: 0.0,
                                  right: 20.0,
                                  bottom: 0.0,
                                  left: 0.0),
                              child: Text(
                                "For how long is the data stored?",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              device.purpose,
                              style: const TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                          ],
                        ),
                        const TableRow(children: [
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ]),
                        TableRow(
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.only(
                                  top: 0.0,
                                  right: 20.0,
                                  bottom: 0.0,
                                  left: 0.0),
                              child: Text(
                                "Device owner: ",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              device.owner.isEmpty ? "N/A" : device.owner,
                              style: const TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                          ],
                        ),
                        device.privacyOptions.isEmpty
                            ? const TableRow(
                                children: <Widget>[
                                  SizedBox(
                                    height: 0.0,
                                  ),
                                  SizedBox(
                                    height: 0.0,
                                  ),
                                ],
                              )
                            : const TableRow(children: [
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 20,
                                )
                              ]),
                        device.privacyOptions.isEmpty
                            ? const TableRow(
                                children: <Widget>[
                                  SizedBox(
                                    height: 0.0,
                                  ),
                                  SizedBox(
                                    height: 0.0,
                                  ),
                                ],
                              )
                            : TableRow(
                                children: <Widget>[
                                  const Padding(
                                    padding: EdgeInsets.only(
                                        top: 0.0,
                                        right: 20.0,
                                        bottom: 0.0,
                                        left: 0.0),
                                    child: Text(
                                      "Privacy options: ",
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      if (!await launchUrl(
                                          Uri.parse(device.privacyOptions))) {
                                        throw Exception(
                                            "Could not launch ${device.privacyOptions}");
                                      }
                                    },
                                    child: const Text(
                                      "Options",
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color:
                                            Color.fromARGB(255, 75, 191, 206),
                                        decoration: TextDecoration.underline,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                        const TableRow(children: [
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ]),
                        TableRow(
                          children: <Widget>[
                            const Padding(
                              padding: EdgeInsets.only(
                                  top: 0.0,
                                  right: 20.0,
                                  bottom: 0.0,
                                  left: 0.0),
                              child: Text(
                                "Coordinates of the device:",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              "Lat: ${device.latitude}, Long: ${device.longitude}",
                              style: const TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                          ],
                        ),
                        const TableRow(children: [
                          SizedBox(
                            height: 70,
                          ),
                          SizedBox(
                            height: 70,
                          )
                        ]),
                        TableRow(
                          children: <Widget>[
                            const Text(
                              "Last updated:",
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              device.updatedAt.toString(),
                              style: const TextStyle(
                                  fontSize: 14.0, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    FirebaseAuth.instance.currentUser != null
                        ? ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                              backgroundColor: Color(0xFF0F51B3),
                              padding: const EdgeInsets.only(
                                  left: 0.0,
                                  top: 16.0,
                                  right: 0.0,
                                  bottom: 16.0),
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(Update.route, arguments: device);
                            },
                            child: const Text(
                              "Edit device",
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                            //    FloatingActionButton(
                            //       child: Icon(Icons.add),
                            //       onPressed: () {
                            //         Navigator.of(context)
                            //             .pushNamed(Update.route, arguments: device);
                            //       }),
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          widget.device.name,
          style: const TextStyle(fontSize: 30),
        ),
        backgroundColor: const Color(0xFF334150),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 2.0, right: 4.0, left: 4.0, bottom: 4.0),
        child: Container(
          color: const Color.fromARGB(255, 16, 44, 53),
          child: FutureBuilder<Device?>(
              future: readDevice(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text("Something went wrong! ${snapshot.error}");
                } else if (snapshot.hasData) {
                  final device = snapshot.data!;

                  return device == null
                      ? Center(child: Text("No Device"))
                      : buildDevice(device);
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }
}
