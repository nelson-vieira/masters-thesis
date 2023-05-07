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
import 'package:app/pages/home.dart';
import 'package:app/pages/about.dart';
import 'package:app/pages/encyclopedia.dart';

class Account extends StatelessWidget {
  static const String route = "/account";

  const Account({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back, color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () => Navigator.pushReplacementNamed(context, Home.route),
        ),
        title: Text(
          "Account",
          style: const TextStyle(fontSize: 30),
        ),
        backgroundColor: const Color(0xFF334150),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 2.0, right: 4.0, left: 4.0, bottom: 4.0),
        child: Container(
          padding: EdgeInsets.all(35.0),
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 30.0, bottom: 20.0),
                  child: const Text(
                    "About",
                    locale: Locale("en", "UK"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Color.fromARGB(255, 245, 245, 245),
                        fontSize: 22.0),
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 50.0),
                  child: Image.asset("assets/icon.png", width: 120.0),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "About",
                  locale: Locale("en", "UK"),
                  textAlign: TextAlign.left,
                  overflow: TextOverflow.visible,
                  style: TextStyle(
                      color: Color.fromARGB(255, 245, 245, 245),
                      fontSize: 16.0),
                ),
              )
            ],
          ),
        ),
      ),
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
          }
        },
        selectedItemColor: Color.fromARGB(255, 212, 135, 19),
      ),
    );
  }
}
