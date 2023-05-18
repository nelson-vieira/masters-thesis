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
  final controllerLatitude = TextEditingController();
  final controllerLongitude = TextEditingController();
  final controllerOwner = TextEditingController();
  final controllerCreatedAt = TextEditingController();
  final controllerUpdatedAt = TextEditingController();

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
      body: ListView(
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
          TextField(
            controller: controllerCategory,
            decoration: decoration("Category"),
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
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
            height: 24,
          ),
          TextField(
            controller: controllerLatitude,
            decoration: decoration("Latitude of the device"),
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          TextField(
            controller: controllerLongitude,
            decoration: decoration("Longitude of the device"),
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
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
            child: const Text("Create Device"),
            onPressed: () {
              final device = Device(
                name: controllerName.text,
                category: controllerCategory.text,
                purpose: controllerPurpose.text,
                whoHasAccess: controllerWhoHasAccess.text,
                timeStored: controllerTimeStored.text,
                identifiable: controllerIdentifiable,
                whatsDone: controllerWhatsDone.text,
                privacyOptions: controllerPrivacyOptions.text,
                latitude: controllerLatitude.text,
                longitude: controllerLongitude.text,
                owner: controllerOwner.text,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              );
              createDevice(device);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
