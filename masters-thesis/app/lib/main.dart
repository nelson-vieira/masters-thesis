// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <2080511@student.uma.pt>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "dart:async";
import 'package:app/routes.dart';
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "package:location/location.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import "package:app/widgets/app_bar.dart";
import "package:app/widgets/bottom_navigation_bar.dart";
import 'package:app/pages/home.dart';
import "package:app/pages/about.dart";
import 'package:app/pages/encyclopedia.dart';
import 'package:app/pages/account.dart';
import 'package:app/pages/auth.dart';
import 'package:app/pages/create.dart';
import 'package:app/pages/update.dart';
import 'package:app/pages/devices.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const IotPrivacy());
}

final navigatorKey = GlobalKey<NavigatorState>();

class IotPrivacy extends StatelessWidget {
  const IotPrivacy({Key? key}) : super(key: key);

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: "IoT Privacy App",
      theme: ThemeData(
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
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class Device {
  String id;
  final String name;
  final String category;
  final DateTime createdAt;

  Device({
    this.id = "",
    required this.name,
    required this.category,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
        "createdAt": createdAt,
      };

  static Device fromJson(Map<String, dynamic> json) => Device(
        id: json['id'],
        name: json['name'],
        category: json['category'],
        createdAt: (json['createdAt'] as Timestamp).toDate(),
      );
}
