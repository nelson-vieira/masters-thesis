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
import "package:ipsum/ipsum.dart";
import 'package:app/pages/home.dart';
import 'package:app/pages/about.dart';
import 'package:app/pages/account.dart';

class Encyclopedia extends StatelessWidget {
  static const String route = "/encyclopedia";

  const Encyclopedia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Ipsum lip = Ipsum();
    String sentences = lip.sentences(1);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
                color: Color.fromARGB(255, 255, 255, 255)),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, Home.route),
          ),
          title: Text(
            "Encyclopedia",
            style: const TextStyle(fontSize: 30),
          ),
          backgroundColor: const Color(0xFFFF9000)),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 2.0, right: 4.0, left: 4.0, bottom: 4.0),
        child: Container(
          padding: EdgeInsets.all(35.0),
          color: Color.fromARGB(255, 18, 180, 132),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Text(
                            "Want to learn more about privacy in the Internet of Things? You have come to the right place, below you can learn how you to better protect your privacy and also learn new terms.",
                            locale: Locale("en", "UK"),
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                              color: Color.fromARGB(255, 245, 245, 245),
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "Item 1",
                                        locale: Locale("en", "UK"),
                                        overflow: TextOverflow.visible,
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 245, 245, 245),
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    sentences,
                                    locale: Locale("en", "UK"),
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.visible,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 245, 245, 245),
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "Item 2",
                                        locale: Locale("en", "UK"),
                                        overflow: TextOverflow.visible,
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 245, 245, 245),
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    sentences,
                                    locale: Locale("en", "UK"),
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.visible,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 245, 245, 245),
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "Item 3",
                                        locale: Locale("en", "UK"),
                                        overflow: TextOverflow.visible,
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 245, 245, 245),
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    sentences,
                                    locale: Locale("en", "UK"),
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.visible,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 245, 245, 245),
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "Item 4",
                                        locale: Locale("en", "UK"),
                                        overflow: TextOverflow.visible,
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 245, 245, 245),
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    sentences,
                                    locale: Locale("en", "UK"),
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.visible,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 245, 245, 245),
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "Item 5",
                                        locale: Locale("en", "UK"),
                                        overflow: TextOverflow.visible,
                                        style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 245, 245, 245),
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    sentences,
                                    locale: Locale("en", "UK"),
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.visible,
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 245, 245, 245),
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
