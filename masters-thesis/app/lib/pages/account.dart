// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <nelson0.vieira@gmail.com>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "dart:io";

import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "package:firebase_core/firebase_core.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/gestures.dart";
import "package:app/main.dart";
import "package:app/pages/home.dart";
import "package:app/pages/about.dart";
import "package:app/pages/encyclopedia.dart";
import "package:app/pages/devices.dart";
import 'package:app/pages/auth.dart';
import 'package:app/pages/helper.dart';
import 'package:app/pages/forgot_password.dart';

class Account extends StatefulWidget {
  static const String route = "/account";

  const Account({
    Key? key,
  }) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final account = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Account",
          style: TextStyle(fontSize: 30),
        ),
        backgroundColor: const Color(0xFF334150),
      ),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Signed in as"),
            SizedBox(
              height: 8,
            ),
            Text(account.email!),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
              onPressed: () => FirebaseAuth.instance.signOut(),
              child: const Text("Log out"),
            ),
          ],
        ),
      ),
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
          currentIndex: 3,
          selectedItemColor: const Color.fromARGB(255, 250, 250, 250),
          unselectedItemColor: const Color.fromARGB(255, 149, 196, 236),
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
              label: "IoT Devices",
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
