// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <2080511@student.uma.pt>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "package:firebase_core/firebase_core.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:datetime_picker_formfield/datetime_picker_formfield.dart";
import "package:intl/intl.dart";
import "package:app/main.dart";
import "package:app/models/device.dart";
import 'package:app/pages/public/home.dart';
import 'package:app/pages/public/about.dart';
import 'package:app/pages/public/encyclopedia.dart';
import 'package:app/pages/auth/account.dart';
import 'package:app/pages/devices/update.dart';
import 'package:app/pages/devices/devices.dart';
import 'package:app/pages/auth/auth.dart';

class Create extends StatefulWidget {
  static const String route = "/create";

  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  final controllerName = TextEditingController();
  final controllerCategory = TextEditingController();
  final controllerPurpose = TextEditingController();
  final controllerWhoHasAccess = TextEditingController();
  final controllerTimeStored = TextEditingController();
  bool controllerIdentifiable = false;
  final controllerWhatsDone = TextEditingController();
  final controllerPrivacyOptions = TextEditingController();
  var controllerLatitude;
  var controllerLongitude;
  final controllerOwner = TextEditingController();
  final controllerCreatedAt = TextEditingController();
  final controllerUpdatedAt = TextEditingController();
  String? selectedValue = null;

  InputDecoration decoration(String label) => InputDecoration(
        labelText: label,
        enabledBorder: const OutlineInputBorder(
          borderSide: const BorderSide(
              color: Color.fromARGB(255, 255, 255, 255), width: 0.0),
        ),
        border: OutlineInputBorder(),
        labelStyle: TextStyle(
          color: Colors.grey.shade600,
        ),
      );

  Future createDevice(Device device) async {
    final docDevice = FirebaseFirestore.instance.collection("devices").doc();
    device.id = docDevice.id;

    final json = device.toJson();
    await docDevice.set(json);
  }

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

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Text(
            "Health",
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          value: "Health"),
      DropdownMenuItem(
          child: Text(
            "Visual",
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          value: "Visual"),
      DropdownMenuItem(
          child: Text(
            "Audio",
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          value: "Audio"),
      DropdownMenuItem(
          child: Text(
            "Presence",
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          value: "Presence"),
      DropdownMenuItem(
          child: Text(
            "Location",
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          value: "Location"),
      DropdownMenuItem(
          child: Text(
            "Biometrics",
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          value: "Biometrics"),
      DropdownMenuItem(
          child: Text(
            "Environment",
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          value: "Environment"),
      DropdownMenuItem(
          child: Text(
            "Unique identification",
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          value: "Unique identification"),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back, color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Add Device",
          style: const TextStyle(fontSize: 30),
        ),
        backgroundColor: const Color(0xFF334150),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 2.0, right: 4.0, left: 4.0, bottom: 4.0),
        child: Container(
          color: const Color.fromARGB(255, 16, 44, 53),
          child: ListView(
            padding: EdgeInsets.all(16),
            children: <Widget>[
              TextField(
                controller: controllerName,
                decoration: decoration("Name"),
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              const SizedBox(height: 24),
              DropdownButtonFormField(
                  hint: const Text(
                    "Select a category",
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  decoration: const InputDecoration(
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
                  value: selectedValue,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedValue = newValue!;
                    });
                  },
                  items: dropdownItems),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: controllerPurpose,
                decoration: decoration("What is the purpose"),
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: controllerWhoHasAccess,
                decoration: decoration("Who has access to this information"),
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: controllerTimeStored,
                decoration: decoration("For how long is the data stored"),
                style: TextStyle(
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
                  title: const Text(
                    "Can the data identify anyone?",
                    style: TextStyle(
                      color: Color(0xFFFFFFFF),
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
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              TextField(
                controller: controllerPrivacyOptions,
                decoration: decoration("URL for privacy options of the device"),
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Text(
                "Lat: ${controllerLatitude == null ? "?" : controllerLatitude.toString()}, Long: ${controllerLongitude == null ? "?" : controllerLongitude.toString()}",
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
                      color: Colors.white,
                    ),
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
                height: 24,
              ),
              TextField(
                controller: controllerOwner,
                decoration: decoration("Device owner"),
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0A8A4E),
                  padding: const EdgeInsets.only(
                      left: 0.0, top: 18.0, right: 0.0, bottom: 18.0),
                ),
                onPressed: () {
                  final device = Device(
                    name: controllerName.text.trim(),
                    category: controllerCategory.text.trim(),
                    purpose: controllerPurpose.text.trim(),
                    whoHasAccess: controllerWhoHasAccess.text.trim(),
                    timeStored: controllerTimeStored.text.trim(),
                    identifiable: controllerIdentifiable,
                    whatsDone: controllerWhatsDone.text.trim(),
                    privacyOptions: controllerPrivacyOptions.text.trim(),
                    latitude: controllerLatitude.toString(),
                    longitude: controllerLongitude.toString(),
                    owner: controllerOwner.text.trim(),
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  );
                  createDevice(device);
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                child: const Text(
                  "Create device",
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
