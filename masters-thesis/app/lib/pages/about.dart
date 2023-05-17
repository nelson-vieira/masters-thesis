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
import "package:app/pages/home.dart";
import "package:app/pages/encyclopedia.dart";
import "package:app/pages/account.dart";
import 'package:app/pages/devices/devices.dart';
import "package:app/pages/auth.dart";

class About extends StatelessWidget {
  static const String route = "/about";

  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Ipsum lip = Ipsum();
    String paragraphs = lip.paragraphs(1);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About",
          style: const TextStyle(fontSize: 30),
        ),
        backgroundColor: const Color(0xFF334150),
        automaticallyImplyLeading: false,
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
                        child: Container(
                          margin: EdgeInsets.only(top: 30.0, bottom: 50.0),
                          child: Image.asset("assets/icon.png", width: 120.0),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          paragraphs,
                          locale: Locale("en", "UK"),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                              color: Color.fromARGB(255, 245, 245, 245),
                              fontSize: 16.0),
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
