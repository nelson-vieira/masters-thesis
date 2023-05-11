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
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import "package:app/main.dart";
import "package:app/pages/home.dart";
import "package:app/pages/about.dart";
import 'package:app/pages/encyclopedia.dart';
import 'package:app/pages/account.dart';
import 'package:app/pages/create.dart';
import 'package:app/pages/devices.dart';
import 'package:app/pages/showdevice.dart';
import 'package:app/pages/auth.dart';

class Update extends StatefulWidget {
  static const String route = "/update";

  final Device device;
  const Update({super.key, required this.device});

  @override
  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  final controllerName = TextEditingController();
  final controllerCategory = TextEditingController();
  final controllerCreatedAt = TextEditingController();

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

  @override
  initState() {
    // https://github.com/flutter/flutter/issues/9969
    controllerName.text = widget.device.name;
    controllerCategory.text = widget.device.category;
    controllerCreatedAt.text = widget.device.createdAt.toIso8601String();
    super.initState();
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
          "Update",
          style: const TextStyle(fontSize: 30),
        ),
        backgroundColor: const Color(0xFF334150),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            controller: controllerName,
            decoration: decoration('Name'),
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: controllerCategory,
            decoration: decoration('Category'),
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          DateTimeField(
            controller: controllerCreatedAt,
            decoration: decoration('Created At'),
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            format: DateFormat('yyyy-MM-dd'),
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
              child: Text('Update'),
              onPressed: () {
                final docDevice = FirebaseFirestore.instance
                    .collection('devices')
                    .doc(widget.device.id);
                docDevice.update({
                  'name': controllerName.text,
                  'category': controllerCategory.text,
                  'createdAt': DateTime.parse(controllerCreatedAt.text),
                });
              }),
          const SizedBox(
            height: 32,
          ),
          ElevatedButton(
              child: Text('Delete'),
              onPressed: () {
                final docDevice = FirebaseFirestore.instance
                    .collection('devices')
                    .doc(widget.device.id);
                docDevice.delete();
              }),
        ],
      ),
    );
  }
}
