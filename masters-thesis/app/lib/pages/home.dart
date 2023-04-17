// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <nelson0.vieira@gmail.com>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "package:app/widgets/drawer.dart";
import "package:app/widgets/app_bar.dart";
import "package:app/pages/about.dart";
import "package:app/pages/home2.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const String route = "/";

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final tabs = [
    paddingHome(),
    paddingAbout(),
    Center(
      child: Text("FAQ"),
    ),
    Center(
      child: Text("Account"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar("IoT Privacy App"),
      //   drawer: buildDrawer(context, route),
      body: tabs[_currentIndex],
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
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Color.fromARGB(255, 212, 135, 19),
      ),
    );
  }
}

// class HomePage extends StatelessWidget {
//   static const String route = "/";

//   const HomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: buildAppBar("IoT Privacy App"),
//       //   drawer: buildDrawer(context, route),
//       body: Padding(
//         padding:
//             const EdgeInsets.only(top: 2.0, right: 4.0, left: 4.0, bottom: 4.0),
//         child: Column(
//           children: [
//             Flexible(
//               child: FlutterMap(
//                 options: MapOptions(
//                   center: LatLng(32.778295173354356, -16.737781931587615),
//                   zoom: 9,
//                 ),
//                 nonRotatedChildren: [
//                   AttributionWidget.defaultWidget(
//                     source: "OpenStreetMap",
//                     onSourceTapped: null,
//                   ),
//                 ],
//                 children: [
//                   TileLayer(
//                     urlTemplate:
//                         "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
//                     userAgentPackageName: "me.nelsonvieira.iot_privacy_app",
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//           backgroundColor: Color.fromARGB(255, 16, 17, 26),
//           items: const [
//             BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//             BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.textsms_rounded,
//                 color: Color.fromARGB(255, 126, 173, 218),
//               ),
//               label: "About",
//               backgroundColor: Color(0xFFFFFFFF),
//               activeIcon: Text("data"),
//             ),
//             BottomNavigationBarItem(
//               icon: IconButton(
//                 onPressed: () {
//                   Navigator.push(context,
//                       MaterialPageRoute(builder: (context) => About()));
//                 },
//                 icon: Icon.question_answer,
//                 color: Color.fromARGB(255, 126, 173, 218),
//               ),
//               label: "FAQ",
//               backgroundColor: Color(0xFFFFFFFF),
//               activeIcon: ,
//             ),
//           ]),
//     );
//   }
// }
