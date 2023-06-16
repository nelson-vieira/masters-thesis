// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <2080511@student.uma.pt>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "dart:async";
import "package:iotprivacy/config/routes.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "package:location/location.dart";
import "package:firebase_core/firebase_core.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "config/firebase_options.dart";
import "package:iotprivacy/widgets/app_bar.dart";
import "package:iotprivacy/widgets/bottom_navigation_bar.dart";
import "package:iotprivacy/pages/public/home.dart";
import "package:iotprivacy/pages/public/about.dart";
import "package:iotprivacy/pages/public/encyclopedia.dart";
import "package:iotprivacy/pages/auth/account.dart";
import "package:iotprivacy/pages/auth/auth.dart";
import "package:iotprivacy/pages/devices/create.dart";
import "package:iotprivacy/pages/devices/update.dart";
import "package:iotprivacy/pages/devices/devices.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const Main());
}

final navigatorKey = GlobalKey<NavigatorState>();

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //   scaffoldMessengerKey: Helper.messengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: "IoT Privacy App",
      theme: ThemeData(
        fontFamily: "Jost",
        canvasColor: const Color(0xFF091220),
        // colorScheme: const ColorScheme(
        //   brightness: Brightness.dark,
        //   primary: Color.fromARGB(255, 212, 10, 10),
        //   onPrimary: Color.fromARGB(255, 212, 10, 10),
        //   secondary: Color.fromARGB(255, 212, 10, 10),
        //   onSecondary: Color.fromARGB(255, 212, 10, 10),
        //   error: Color.fromARGB(255, 212, 10, 10),
        //   onError: Color.fromARGB(255, 212, 10, 10),
        //   background: Color.fromARGB(255, 212, 10, 10),
        //   onBackground: Color.fromARGB(255, 212, 10, 10),
        //   surface: Color.fromARGB(255, 212, 10, 10),
        //   onSurface: Color.fromARGB(255, 212, 10, 10),
        // ),
      ),
      initialRoute: Home.route,
      home: const IotPrivacy(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class IotPrivacy extends StatefulWidget {
  const IotPrivacy({super.key});

  @override
  State<IotPrivacy> createState() => _IotPrivacyState();
}

class _IotPrivacyState extends State<IotPrivacy> {
  int _currentIndex = 0;

  final pages = [
    const Home(),
    const About(),
    const Encyclopedia(),
    const Account(),
    const Devices(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          // Sets the background color of the bottom navigation bar
          canvasColor: const Color(0xFF334150),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          selectedLabelStyle: const TextStyle(
            color: Color.fromARGB(255, 250, 250, 250),
          ),
          unselectedLabelStyle: const TextStyle(
            color: Color.fromARGB(255, 149, 196, 236),
          ),
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
                Icons.info_outline_rounded,
              ),
              label: "About",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.menu_book_rounded,
              ),
              label: "Information",
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
              label: "IoT Devices",
            ),
          ],
          onTap: (index) => setState(() => _currentIndex = index),
        ),
      ),
    );
  }
}
