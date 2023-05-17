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
import "package:app/main.dart";
import 'package:app/pages/public/home.dart';
import 'package:app/pages/public/about.dart';
import 'package:app/pages/public/account.dart';
import 'package:app/pages/devices/devices.dart';
import 'package:app/pages/auth/auth.dart';

class Encyclopedia extends StatelessWidget {
  static const String route = "/encyclopedia";

  const Encyclopedia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Ipsum lip = Ipsum();
    String sentences = lip.sentences(1);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Encyclopedia",
          style: const TextStyle(fontSize: 30),
        ),
        backgroundColor: const Color(0xFF334150),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 2.0, right: 4.0, left: 4.0, bottom: 4.0),
        child: Container(
          padding: EdgeInsets.all(35.0),
          color: const Color.fromARGB(255, 16, 44, 53),
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
    );
  }
}
