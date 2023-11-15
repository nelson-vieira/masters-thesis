// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <2080511@student.uma.pt>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:url_launcher/url_launcher.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:iotprivacy/models/device.dart";
import "package:iotprivacy/pages/devices/update.dart";
import "package:iotprivacy/helpers/category.dart";

class ShowDevice extends StatefulWidget {
  static const String route = "/showdevice";

  final Device device;
  const ShowDevice({super.key, required this.device});

  @override
  State<ShowDevice> createState() => _ShowDeviceState();
}

class _ShowDeviceState extends State<ShowDevice> {
  Future<Device?> readDevice() async {
    final docDevice =
        FirebaseFirestore.instance.collection("devices").doc(widget.device.id);
    final snapshot = await docDevice.get();

    if (snapshot.exists) {
      return Device.fromJson(snapshot.data()!);
    }
    return null;
  }

  Image categoryIcon(Device device) {
    switch (device.category) {
      case "08gNFyCLyxSxiYIcdFx0":
        return Image.asset("assets/images/unique_identification.png",
            width: 110.0);
      case "1qyoLqyrgmLTpLklqgFX":
        return Image.asset("assets/images/environment.png", width: 110.0);
      case "6yYW2K9Fv9AogHPfut5l":
        return Image.asset("assets/images/biometrics.png", width: 110.0);
      case "WnvAzxPaI5Z8hFzUE228":
        return Image.asset("assets/images/location.png", width: 110.0);
      case "bvf9p6MYF1DwxgDab2Mp":
        return Image.asset("assets/images/presence.png", width: 110.0);
      case "rhSmoONpwDl8B1mrXBZL":
        return Image.asset("assets/images/audio.png", width: 110.0);
      case "vfWA43iLPsUj6ZW3D5Rg":
        return Image.asset("assets/images/visual.png", width: 110.0);
      default:
        return Image.asset("assets/images/icon.png", width: 120.0);
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
                          categoryIcon(device),
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
                                    AppLocalizations.of(context)!
                                        .firebaseError("${snapshot.error}"),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 17.0,
                                    ),
                                    textAlign: TextAlign.center,
                                  ));
                                } else if (snapshot.hasData) {
                                  final category = snapshot.data!;

                                  return Text(
                                    CategoryHelper.categoryName(
                                        context, category.get("name")),
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
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 0.0,
                                  right: 20.0,
                                  bottom: 0.0,
                                  left: 0.0),
                              child: Text(
                                AppLocalizations.of(context)!
                                    .whoHasAccessDevice,
                                style: const TextStyle(
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
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 0.0,
                                  right: 20.0,
                                  bottom: 0.0,
                                  left: 0.0),
                              child: Text(
                                AppLocalizations.of(context)!.purposeDevice,
                                style: const TextStyle(
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
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 0.0,
                                  right: 20.0,
                                  bottom: 0.0,
                                  left: 0.0),
                              child: Text(
                                AppLocalizations.of(context)!.identifyDevice,
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              device.identifiable == true
                                  ? AppLocalizations.of(context)!.yes
                                  : AppLocalizations.of(context)!.no,
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
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 0.0,
                                  right: 20.0,
                                  bottom: 0.0,
                                  left: 0.0),
                              child: Text(
                                AppLocalizations.of(context)!.whatsDoneDevice,
                                style: const TextStyle(
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
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 0.0,
                                  right: 20.0,
                                  bottom: 0.0,
                                  left: 0.0),
                              child: Text(
                                AppLocalizations.of(context)!.timeStoredDevice,
                                style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              device.timeStored,
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
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 0.0,
                                  right: 20.0,
                                  bottom: 0.0,
                                  left: 0.0),
                              child: Text(
                                AppLocalizations.of(context)!.ownerDevice,
                                style: const TextStyle(
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
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0.0,
                                        right: 20.0,
                                        bottom: 0.0,
                                        left: 0.0),
                                    child: Text(
                                      AppLocalizations.of(context)!
                                          .privacyOptionsDevice,
                                      style: const TextStyle(
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
                                            AppLocalizations.of(context)!
                                                .errorLaunchingLink);
                                      }
                                    },
                                    child: Text(
                                      AppLocalizations.of(context)!.options,
                                      style: const TextStyle(
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
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 0.0,
                                  right: 20.0,
                                  bottom: 0.0,
                                  left: 0.0),
                              child: Text(
                                AppLocalizations.of(context)!.coordinatesDevice,
                                style: const TextStyle(
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
                            Text(
                              AppLocalizations.of(context)!.lastUpdated,
                              style: const TextStyle(
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
                              backgroundColor: const Color(0xFFAFAD15),
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
                            child: Text(
                              AppLocalizations.of(context)!.editDevice,
                              style: const TextStyle(
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
                  return Text(AppLocalizations.of(context)!
                      .firebaseError("${snapshot.error}"));
                } else if (snapshot.hasData) {
                  final device = snapshot.data!;

                  // ignore: unnecessary_null_comparison
                  return device == null
                      ? Center(
                          child: Text(AppLocalizations.of(context)!.noDevice))
                      : buildDevice(device);
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
