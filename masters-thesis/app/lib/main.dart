// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <2080511@student.uma.pt>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "dart:async";
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

class IotPrivacy extends StatelessWidget {
  const IotPrivacy({Key? key}) : super(key: key);

  // This widget is the root of the application.
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
        Create.route: (context) => const Create(),
        Devices.route: (context) => const Devices(),
      },
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
