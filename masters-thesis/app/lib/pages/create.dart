// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <2080511@student.uma.pt>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
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
import 'package:app/pages/update.dart';
import 'package:app/pages/devices.dart';

class Create extends StatefulWidget {
  static const String route = "/create";

  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
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

  Future createDevice(Device device) async {
    final docDevice = FirebaseFirestore.instance.collection('devices').doc();
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
          onPressed: () => Navigator.pushReplacementNamed(context, Home.route),
        ),
        title: Text(
          "Add Device",
          style: const TextStyle(fontSize: 30),
        ),
        backgroundColor: const Color(0xFFFF9000),
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
            child: Text('Create'),
            onPressed: () {
              final device = Device(
                name: controllerName.text,
                category: controllerCategory.text,
                createdAt: DateTime.parse(controllerCreatedAt.text),
              );
              createDevice(device);
              Navigator.pushReplacementNamed(context, Home.route);
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFF10111A),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Color(0xFF7EADDA),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.textsms_rounded,
              color: Color(0xFF7EADDA),
            ),
            label: "About",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.question_answer_outlined,
              color: Color(0xFF7EADDA),
            ),
            label: "FAQ",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: Color(0xFF7EADDA),
            ),
            label: "Account",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.accessibility,
              color: Color(0xFF7EADDA),
            ),
            label: "Devices",
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, Home.route);
              break;
            case 1:
              Navigator.pushReplacementNamed(context, About.route);
              break;
            case 2:
              Navigator.pushReplacementNamed(context, Encyclopedia.route);
              break;
            case 3:
              Navigator.pushReplacementNamed(context, Account.route);
              break;
            case 4:
              Navigator.pushReplacementNamed(context, Devices.route);
              break;
          }
        },
        selectedItemColor: Color.fromARGB(255, 212, 135, 19),
      ),
    );
  }
}
