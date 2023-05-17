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
import "package:app/pages/home.dart";
import "package:app/pages/about.dart";
import "package:app/pages/encyclopedia.dart";
import "package:app/pages/account.dart";
import "package:app/pages/update.dart";
import "package:app/pages/devices.dart";
import "package:app/pages/auth.dart";

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
  final controllerIdentifiable = TextEditingController();
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
    bool controllerIdentifiableBool =
        controllerIdentifiable.text.toLowerCase() == "true";
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
            keyboardType: TextInputType.number,
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
            keyboardType: TextInputType.number,
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
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          TextField(
            controller: controllerIdentifiable,
            decoration: decoration("Can the data identify anyone?"),
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          TextField(
            controller: controllerWhatsDone,
            decoration: decoration("What is being done with the data?"),
            keyboardType: TextInputType.number,
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
            keyboardType: TextInputType.number,
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
            keyboardType: TextInputType.number,
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
            keyboardType: TextInputType.number,
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
            height: 24,
          ),
          DateTimeField(
            controller: controllerCreatedAt,
            decoration: decoration("Created At"),
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            format: DateFormat("yyyy-MM-dd"),
            onShowPicker: (context, currentValue) async {
              final time = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );
              return DateTimeField.convert(time);
            },
          ),
          const SizedBox(
            height: 24,
          ),
          DateTimeField(
            controller: controllerUpdatedAt,
            decoration: decoration("Updated At"),
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            format: DateFormat("yyyy-MM-dd"),
            onShowPicker: (context, currentValue) async {
              final time = await showTimePicker(
                context: context,
                initialTime:
                    TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
              );
              return DateTimeField.convert(time);
            },
          ),
          const SizedBox(
            height: 32,
          ),
          ElevatedButton(
            child: Text("Create"),
            onPressed: () {
              final device = Device(
                name: controllerName.text,
                category: controllerCategory.text,
                purpose: controllerPurpose.text,
                whoHasAccess: controllerWhoHasAccess.text,
                timeStored: controllerTimeStored.text,
                identifiable: controllerIdentifiableBool,
                whatsDone: controllerWhatsDone.text,
                privacyOptions: controllerPrivacyOptions.text,
                latitude: controllerLatitude.text,
                longitude: controllerLongitude.text,
                owner: controllerOwner.text,
                createdAt: DateTime.parse(controllerCreatedAt.text),
                updatedAt: DateTime.parse(controllerUpdatedAt.text),
              );
              createDevice(device);
              Navigator.of(context).pushNamed(Devices.route);
            },
          ),
        ],
      ),
    );
  }
}
