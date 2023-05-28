// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <nelson0.vieira@gmail.com>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "package:app/models/user.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "package:firebase_core/firebase_core.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:datetime_picker_formfield/datetime_picker_formfield.dart";
import "package:intl/intl.dart";
import "package:app/main.dart";
import "package:app/models/device.dart";
import 'package:app/pages/public/home.dart';
import 'package:app/pages/public/about.dart';
import 'package:app/pages/public/encyclopedia.dart';
import 'package:app/pages/auth/account.dart';
import 'package:app/pages/devices/create.dart';
import 'package:app/pages/devices/devices.dart';
import 'package:app/pages/devices/show.dart';
import 'package:app/pages/auth/auth.dart';
import 'package:app/models/category.dart';

class Update extends StatefulWidget {
  static const String route = "/update";

  final Device device;
  const Update({super.key, required this.device});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  final controllerName = TextEditingController();
  String? controllerCategory;
  final controllerPurpose = TextEditingController();
  final controllerWhoHasAccess = TextEditingController();
  final controllerTimeStored = TextEditingController();
  var controllerIdentifiable;
  final controllerWhatsDone = TextEditingController();
  final controllerPrivacyOptions = TextEditingController();
  var controllerLatitude;
  var controllerLongitude;
  final controllerOwner = TextEditingController();
  String _userEmail = "Random";

  InputDecoration decoration(String label) => InputDecoration(
        labelText: label,
        enabledBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 255, 255, 255), width: 0.0),
        ),
        border: const OutlineInputBorder(),
        labelStyle: const TextStyle(
          color: Color(0xFFAAAAAA),
        ),
      );

  @override
  initState() {
    // https://github.com/flutter/flutter/issues/9969
    controllerName.text = widget.device.name;
    controllerCategory = widget.device.category;
    controllerPurpose.text = widget.device.purpose;
    controllerWhoHasAccess.text = widget.device.whoHasAccess;
    controllerTimeStored.text = widget.device.timeStored;
    controllerIdentifiable = widget.device.identifiable;
    controllerWhatsDone.text = widget.device.whatsDone;
    controllerPrivacyOptions.text = widget.device.privacyOptions;
    controllerLatitude = widget.device.latitude;
    controllerLongitude = widget.device.longitude;
    controllerOwner.text = widget.device.owner;
    super.initState();
  }

  AlertDialog confirmDelete() => AlertDialog(
        title: const Text("Confirmation"),
        titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
        actionsOverflowButtonSpacing: 20,
        actions: [
          ElevatedButton(
              onPressed: () {
                final docDevice = FirebaseFirestore.instance
                    .collection("devices")
                    .doc(widget.device.id);
                docDevice.delete();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text("Yes")),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("No")),
        ],
        content: const Text("Are you sure you want to delete this device?"),
      );

  Dialog controllerCoordinates() => Dialog(
        child: SizedBox.expand(
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                Flexible(
                  child: FlutterMap(
                    options: MapOptions(
                      center: LatLng(32.778295173354356, -16.737781931587615),
                      interactiveFlags:
                          InteractiveFlag.all & ~InteractiveFlag.rotate,
                      zoom: 9,
                      onLongPress: (tapPosition, point) {
                        setState(() {
                          controllerLatitude = point.latitude;
                          controllerLongitude = point.longitude;
                        });
                        Navigator.of(context).pop();
                      },
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
        ),
      );

  Stream<List<Category>> readCategories() => FirebaseFirestore.instance
      .collection("categories")
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Category.fromJson(doc.data())).toList());

  DropdownMenuItem<String> buildCategories(Category cat) => DropdownMenuItem(
        value: cat.id,
        child: Text(
          cat.name,
          style: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      );

  Stream<List<UserDocument>> readUserDocuments() => FirebaseFirestore.instance
      .collection("users")
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => UserDocument.fromJson(doc.data()))
          .toList());

  Widget buildDelete(UserDocument user) => (FirebaseAuth.instance.currentUser !=
              null &&
          user.role.toString() == "admin")
      ? ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 207, 30, 30),
            padding: const EdgeInsets.only(
                left: 0.0, top: 18.0, right: 0.0, bottom: 18.0),
          ),
          child: const Text(
            "Delete",
            style: TextStyle(fontSize: 16.0, color: Colors.white),
          ),
          onPressed: () {
            showDialog(context: context, builder: (context) => confirmDelete());
          })
      : Container();

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
        title: const Text(
          "Update",
          style: TextStyle(fontSize: 30),
        ),
        backgroundColor: const Color(0xFF334150),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 2.0, right: 4.0, left: 4.0, bottom: 4.0),
        child: Container(
          color: const Color.fromARGB(255, 16, 44, 53),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              TextField(
                controller: controllerName,
                decoration: decoration("Name"),
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              const SizedBox(height: 24),
              FutureBuilder(
                  future: readCategories().first,
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

                      return DropdownButtonFormField(
                          hint: const Text(
                            "Select a category",
                            style: TextStyle(
                              color: Color(0xFFAAAAAA),
                            ),
                          ),
                          decoration: const InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            filled: true,
                            fillColor: Color.fromARGB(255, 16, 44, 53),
                          ),
                          validator: (value) =>
                              value == null ? "Select a category" : null,
                          dropdownColor: const Color.fromARGB(255, 16, 44, 53),
                          value: controllerCategory,
                          onChanged: (String? newValue) {
                            setState(() {
                              controllerCategory = newValue!;
                            });
                          },
                          items: devices
                              .map<DropdownMenuItem<String>>(buildCategories)
                              .toList());
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: controllerPurpose,
                decoration: decoration("What is the purpose"),
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: controllerWhoHasAccess,
                decoration: decoration("Who has access to this information"),
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: controllerTimeStored,
                decoration: decoration("For how long is the data stored"),
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Theme(
                data: ThemeData(unselectedWidgetColor: Colors.white),
                child: CheckboxListTile(
                  checkboxShape: const RoundedRectangleBorder(
                    side: BorderSide(color: Color(0xFFFFFFFF), width: 2.0),
                  ),
                  activeColor: Color(0xFF6CBBE0),
                  checkColor: const Color(0xAAFFFFFF),
                  enableFeedback: true,
                  title: Text(
                    "Can the data identify anyone?",
                    style: TextStyle(
                      color: controllerIdentifiable
                          ? const Color(0xFFFFFFFF)
                          : const Color(0xFFAAAAAA),
                    ),
                  ),
                  value: controllerIdentifiable,
                  onChanged: (bool? value) {
                    setState(() {
                      controllerIdentifiable = value!;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: controllerWhatsDone,
                decoration: decoration("What is being done with the data?"),
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: controllerPrivacyOptions,
                decoration: decoration("URL for privacy options of the device"),
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Text(
                "Lat: " +
                    controllerLatitude.toString() +
                    ", Long: " +
                    controllerLongitude.toString(),
                style: TextStyle(fontSize: 14.0, color: Colors.grey.shade400),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 16, 44, 53),
                  padding: const EdgeInsets.only(
                      left: 10.0, top: 18.0, right: 0.0, bottom: 18.0),
                  side: const BorderSide(
                      width: 1, // the thickness
                      color: Colors.white // the color of the border
                      ),
                ),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Coordinates of the device",
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Color.fromARGB(255, 170, 170, 170)),
                    textAlign: TextAlign.start,
                  ),
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => controllerCoordinates());
                },
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 15, 81, 179),
                    padding: const EdgeInsets.only(
                        left: 0.0, top: 18.0, right: 0.0, bottom: 18.0),
                  ),
                  child: const Text(
                    "Update",
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                  onPressed: () {
                    final docDevice = FirebaseFirestore.instance
                        .collection("devices")
                        .doc(widget.device.id);
                    docDevice.update({
                      "name": controllerName.text,
                      "category": controllerCategory.toString(),
                      "purpose": controllerPurpose.text,
                      "whoHasAccess": controllerWhoHasAccess.text,
                      "timeStored": controllerTimeStored.text,
                      "identifiable": controllerIdentifiable,
                      "whatsDone": controllerWhatsDone.text,
                      "privacyOptions": controllerPrivacyOptions.text,
                      "latitude": controllerLatitude.toString(),
                      "longitude": controllerLongitude.toString(),
                      "owner": controllerOwner.text,
                      "updatedAt": DateTime.now(),
                    });
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  }),
              const SizedBox(
                height: 60,
              ),
              FutureBuilder(
                  future: readUserDocuments().first,
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
                      final users = snapshot.data!;

                      return users.map(buildDelete).first;
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
