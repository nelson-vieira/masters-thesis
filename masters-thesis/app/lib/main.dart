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

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

String? _currentJwtToken = "";

class _MainState extends State<Main> {
//   Stream<User> userStream;
//   User initialUser;

//   final authenticatedUserStream = FirebaseAuth.instance
//       .authStateChanges()
//       .map<String>((user) {
//         // Store jwt token on user update.
//         () async {
//           _currentJwtToken = await user?.getIdToken();
//         }();
//         return user?.uid ?? '';
//       })
//       .map((users) =>
//           FirebaseFirestore.instance.collection("users").snapshots() = users.isNotEmpty ? users.first : null)
//       .asBroadcastStream();

//   final authUserSub = authenticatedUserStream.listen((_) {});

//   @override
//   void initState() {
//     super.initState();
//     userStream = artStoreFirebaseUserStream()
//       ..listen((user) => initialUser ?? setState(() => initialUser = user));
//   }

//   @override
//   void dispose() {
//     authUserSub.cancel();

//     super.dispose();
//   }

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
        if (snapshot.connectionState == ConnectionState.waiting) {
          //   User user = snapshot.data;
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          if (snapshot.data == null) {
            return const Auth();
          } else {
            return const Account();
          }
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
