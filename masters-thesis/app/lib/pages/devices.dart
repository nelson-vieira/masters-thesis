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
import 'package:app/pages/showdevice.dart';
import 'package:app/pages/auth.dart';

class Devices extends StatefulWidget {
  static const String route = "/devices";

  const Devices({super.key});

  @override
  State<Devices> createState() => _DevicesState();
}

class _DevicesState extends State<Devices> {
  Stream<List<Device>> readDevices() => FirebaseFirestore.instance
      .collection('devices')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Device.fromJson(doc.data())).toList());

  Widget buildDevices(Device device) => ListTile(
        textColor: Color.fromARGB(255, 255, 255, 255),
        leading: CircleAvatar(child: Text('${device.category}')),
        title: Text(device.name),
        subtitle: Text(device.createdAt.toIso8601String()),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ShowDevice(device: device)));
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Devices",
          style: TextStyle(fontSize: 30),
        ),
        backgroundColor: const Color(0xFF334150),
      ),
      body: FutureBuilder(
          future: readDevices().first,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong! ${snapshot.error}');
            } else if (snapshot.hasData) {
              final devices = snapshot.data!;

              return ListView(
                children: devices.map(buildDevices).toList(),
              );
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
                Navigator.of(context).pushNamed(Home.route);
                break;
              case 1:
                Navigator.of(context).pushNamed(About.route);
                break;
              case 2:
                Navigator.of(context).pushNamed(Encyclopedia.route);
                break;
              case 3:
                Navigator.of(context).pushNamed(Auth.route);
                break;
              case 4:
                Navigator.of(context).pushNamed(Devices.route);
                break;
            }
          },
        ),
      ),
    );
  }
}
