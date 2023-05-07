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
import "package:app/main.dart";
import "package:app/pages/home.dart";
import "package:app/pages/about.dart";
import 'package:app/pages/encyclopedia.dart';
import 'package:app/pages/account.dart';
import 'package:app/pages/create.dart';
import 'package:app/pages/update.dart';
import 'package:app/pages/devices.dart';

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
        FirebaseFirestore.instance.collection('devices').doc(widget.device.id);
    final snapshot = await docDevice.get();

    if (snapshot.exists) {
      return Device.fromJson(snapshot.data()!);
    }
  }

  Widget buildDevice(Device device) => Column(
        children: [
          ListTile(
            textColor: Color.fromARGB(255, 255, 255, 255),
            leading: CircleAvatar(child: Text('${device.category}')),
            title: Text(device.name),
            subtitle: Text(device.createdAt.toIso8601String()),
          ),
          FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Update(device: device)));
              }),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back, color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => const Devices()));
          },
        ),
        title: Text(
          widget.device.name,
          style: const TextStyle(fontSize: 30),
        ),
        backgroundColor: const Color(0xFF334150),
      ),
      body: FutureBuilder<Device?>(
          future: readDevice(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong! ${snapshot.error}');
            } else if (snapshot.hasData) {
              final device = snapshot.data!;

              return device == null
                  ? Center(child: Text('No Device'))
                  : buildDevice(device);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
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
