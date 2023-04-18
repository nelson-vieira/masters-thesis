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

Padding about() {
  return Padding(
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
                    color: Color.fromARGB(255, 245, 245, 245), fontSize: 22.0),
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
                  color: Color.fromARGB(255, 245, 245, 245), fontSize: 16.0),
            ),
          )
        ],
      ),
    ),
  );
}
