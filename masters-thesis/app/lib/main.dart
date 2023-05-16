// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <2080511@student.uma.pt>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "dart:async";
import "package:app/routes.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "package:location/location.dart";
import "package:firebase_core/firebase_core.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "firebase_options.dart";
import "package:app/widgets/app_bar.dart";
import "package:app/widgets/bottom_navigation_bar.dart";
import "package:app/pages/home.dart";
import "package:app/pages/about.dart";
import "package:app/pages/encyclopedia.dart";
import "package:app/pages/account.dart";
import "package:app/pages/auth.dart";
import "package:app/pages/create.dart";
import "package:app/pages/update.dart";
import "package:app/pages/devices.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  int index = 0;
  bool isLogged = true;

  final pages = [
    const Home(),
    const About(),
    const Encyclopedia(),

    StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          //   User user = snapshot.data;
          if (snapshot.data == null) {
            return Auth();
          }
          return Account();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    ),

    // StreamBuilder<User?>(
    //   stream: FirebaseAuth.instance.authStateChanges(),
    //   builder: (context, snapshot) {
    //     // if (snapshot.connectionState == ConnectionState.waiting) {
    //     //   return Center(
    //     //     child: CircularProgressIndicator(),
    //     //   );
    //     // } else if (snapshot.hasError) {
    //     //   return Center(
    //     //     child: Text("Something went wrong!",
    //     //         style: TextStyle(color: Colors.white),
    //     //         textAlign: TextAlign.center),
    //     //   );
    //     // } else if (snapshot.hasData) {
    //     //   return const Account();
    //     // } else {
    //     //   return const Auth();
    //     // }
    //     if (!snapshot.hasData) {
    //       return Auth();
    //     }

    //     return const Account();
    //   },
    // ),
    // (FirebaseAuth.instance.currentUser ?? false) != null
    //     ? const Account()
    //     : const Auth(),
    const Devices(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
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
          currentIndex: index,
          showSelectedLabels: true,
          showUnselectedLabels: false,
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
              label: "Encyclopedia",
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
          onTap: (index) => setState(() => this.index = index),
        ),
      ),
    );
  }
}

@immutable
class Device {
  String id;
  // Name of the device
  final String name;
  // Category of the device, can be of the types: d
  final String category;
  // What is the purpose of the data being collected
  final String purpose;
  // Who has access to the data that is being collected
  final String whoHasAccess;
  // For how long is the data bring stored, doesn't matter if it is on the cloud or on premises or other
  final String timeStored;
  // Can the data identify any individual?
  final bool identifiable;
  // What is being done with the data at the present moment
  final String whatsDone;
  // Is there any privacy options that the user can control? And what are they.
  final String privacyOptions;
  // Coordinates of the device so that it can be shown on the map
  final String latitude;
  final String longitude;
  // The device owner, can be an individual or an organization
  final String owner;
  // Metadata about this device on the database
  final DateTime createdAt;
  final DateTime updatedAt;

  Device({
    this.id = "",
    required this.name,
    required this.category,
    this.purpose = "",
    this.whoHasAccess = "",
    this.timeStored = "",
    this.identifiable = false,
    this.whatsDone = "",
    this.privacyOptions = "",
    required this.latitude,
    required this.longitude,
    required this.createdAt,
    required this.updatedAt,
  });

  // This function serves to send the data about this device to Firebase
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
        "purpose": purpose,
        "whoHasAccess": whoHasAccess,
        "timeStored": timeStored,
        "identifiable": identifiable,
        "whatsDone": whatsDone,
        "privacyOptions": privacyOptions,
        "latitude": latitude,
        "longitude": longitude,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };

  // This function serves to import the data on Firebase to be shown on the app
  static Device fromJson(Map<String, dynamic> json) => Device(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        purpose: json["purpose"],
        whoHasAccess: json["whoHasAccess"],
        timeStored: json["timeStored"],
        identifiable: json["identifiable"],
        whatsDone: json["whatsDone"],
        privacyOptions: json["privacyOptions"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        createdAt: (json["createdAt"] as Timestamp).toDate(),
        updatedAt: (json["updatedAt"] as Timestamp).toDate(),
      );
}
