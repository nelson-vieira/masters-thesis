// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <nelson0.vieira@gmail.com>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "package:app/pages/about.dart";
import 'package:app/pages/encyclopedia.dart';
import 'package:app/pages/account.dart';
import 'package:app/pages/create.dart';
import 'package:app/pages/update.dart';
import 'package:app/pages/devices.dart';

class Home extends StatelessWidget {
  static const String route = "/";

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "IoT Privacy App",
            style: const TextStyle(fontSize: 30),
          ),
          backgroundColor: const Color(0xFFFF9000)),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 2.0, right: 4.0, left: 4.0, bottom: 4.0),
        child: Column(
          children: [
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(32.778295173354356, -16.737781931587615),
                  zoom: 9,
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
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Create()));
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

// Padding home() {
//   return Padding(
//     padding:
//         const EdgeInsets.only(top: 2.0, right: 4.0, left: 4.0, bottom: 4.0),
//     child: Column(
//       children: [
//         Flexible(
//           child: FlutterMap(
//             options: MapOptions(
//               center: LatLng(32.778295173354356, -16.737781931587615),
//               zoom: 9,
//             ),
//             nonRotatedChildren: [
//               AttributionWidget.defaultWidget(
//                 source: "OpenStreetMap",
//                 onSourceTapped: null,
//               ),
//             ],
//             children: [
//               TileLayer(
//                 urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
//                 userAgentPackageName: "me.nelsonvieira.iot_privacy_app",
//               ),
//             ],
//           ),
//         ),
//       ],
//     ),
//   );
// }
