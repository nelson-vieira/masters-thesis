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
import 'package:app/pages/auth.dart';

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
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: const Color(0xFF334150),
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            primaryColorDark: const Color(0xFF334150),
            textTheme: Theme.of(context).textTheme.copyWith(
                labelSmall: const TextStyle(
                    color: Color.fromARGB(255, 223, 141,
                        18)))), // sets the inactive color of the `BottomNavigationBar`
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: 4,
          selectedItemColor: const Color.fromARGB(255, 250, 250, 250),
          unselectedItemColor: Color.fromARGB(255, 149, 196, 236),
          selectedIconTheme: const IconThemeData(
            color: Color.fromARGB(255, 250, 250, 250),
          ),
          unselectedIconTheme: const IconThemeData(
            color: Color.fromARGB(255, 149, 196, 236),
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.format_quote,
              ),
              label: "About",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.question_mark,
              ),
              label: "FAQ",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
              ),
              label: "Account",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_tree_outlined,
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
                Navigator.pushReplacementNamed(context, Auth.route);
                break;
              case 4:
                Navigator.pushReplacementNamed(context, Devices.route);
                break;
            }
          },
        ),
      ),
    );
  }
}
