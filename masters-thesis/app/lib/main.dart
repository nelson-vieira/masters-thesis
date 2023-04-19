// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <nelson0.vieira@gmail.com>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "dart:async";
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "package:location/location.dart";
import "package:app/widgets/app_bar.dart";
import "package:app/widgets/bottom_navigation_bar.dart";
import 'package:app/pages/home.dart';
import "package:app/pages/about.dart";
import 'package:app/pages/encyclopedia.dart';
import 'package:app/pages/account.dart';

void main() {
  runApp(const IotPrivacy());
}

class IotPrivacy extends StatelessWidget {
  const IotPrivacy({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "IoT Privacy App",
      theme: ThemeData(canvasColor: Color(0xFF091220)),
      home: const Home(),
      routes: <String, WidgetBuilder>{
        About.route: (context) => const About(),
        Encyclopedia.route: (context) => const Encyclopedia(),
        Account.route: (context) => const Account(),
      },
    );
  }
}

// class Index extends StatefulWidget {
//   const Index({super.key});

//   @override
//   State<Index> createState() => _IndexState();
// }

// class _IndexState extends State<Index> {
//   @override
//   void initState() {
//     super.initState();
//   }

//   static const String defaultRouteName = '/';

//   int _currentIndex = 0;

//   final bodies = [
//     Home(),
//     About(),
//     Center(
//       child: Text("FAQ"),
//     ),
//     Center(
//       child: Text("Account"),
//     ),
//   ];

//   final appbars = [
//     AppBar(
//         title: Text(
//           "IoT Privacy App",
//           style: const TextStyle(fontSize: 30),
//         ),
//         backgroundColor: const Color(0xFFFF9000)),
//     // _AppBar("About"),
//     // _AppBar("Encyclopedia"),
//     // _AppBar("Account"),
//     buildAppBar("About"),
//     buildAppBar("Encyclopedia"),
//     buildAppBar("Account"),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       //   appBar: appbars[_currentIndex],
//       //   drawer: buildDrawer(context, route),
//       body: bodies[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         backgroundColor: Color(0xFF10111A),
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.home,
//               color: Color(0xFF7EADDA),
//             ),
//             label: "Home",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.textsms_rounded,
//               color: Color(0xFF7EADDA),
//             ),
//             label: "About",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.question_answer_outlined,
//               color: Color(0xFF7EADDA),
//             ),
//             label: "FAQ",
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(
//               Icons.account_circle,
//               color: Color(0xFF7EADDA),
//             ),
//             label: "Account",
//           ),
//         ],
//         // onTap: (index) {
//         //   setState(() {
//         //     _currentIndex = index;
//         //   });
//         onTap: (index) {
//           switch (index) {
//             case 0:
//               Navigator.pushNamed(context, Home.route);
//               _currentIndex = index;
//               break;
//             case 1:
//               Navigator.pushNamed(context, About.route);
//               _currentIndex = index;
//               break;
//             case 2:
//               Navigator.pushNamed(context, Home.route);
//               _currentIndex = index;
//               break;
//             case 2:
//               Navigator.pushNamed(context, Home.route);
//               _currentIndex = index;
//               break;
//           }
//         },
//         selectedItemColor: Color.fromARGB(255, 212, 135, 19),
//       ),
//     );
//   }
// }
