// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <nelson0.vieira@gmail.com>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MoreInfo extends StatelessWidget {
  static const String route = "/more_info";

  const MoreInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.moreInfo,
          style: const TextStyle(fontSize: 30),
        ),
        backgroundColor: const Color(0xFF334150),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 2.0, right: 4.0, left: 4.0, bottom: 4.0),
        child: Container(
          padding: const EdgeInsets.all(35.0),
          color: const Color.fromARGB(255, 16, 44, 53),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20.0),
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
                      FirebaseAuth.instance.currentUser != null
                          ? const Padding(
                              padding: EdgeInsets.only(bottom: 20.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 8.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "How to add a device?",
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
                                    "You can insert a device by insert the device data: the name of the device, category of the device, what is the purpose of data collection, who has access to the data, for how long is the data stored, can the data identify an individual, what is currently being done with the data collected, privacy options of the device, device coordinates, and who is the device owner (in the case of an organization).",
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
                            )
                          : Container(),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 20.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 8.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "What is Digital Privacy?",
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
                                    "Digital privacy is the right of the individual to govern how personal information is collected, stored, and used, it frequently involves handling sensitive information with care, and as such, organizations must be open and honest about the kind of data they plan to gather, why they need it, and where and with whom they plan to share it. Users should have the right to control their shared information.",
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
                              padding: EdgeInsets.only(bottom: 20.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 8.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "What is Internet of Things?",
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
                                    "An open and comprehensive network of intelligent objects that have the capacity to auto-organize, share information, data and resources, reacting and acting in face of situations and changes in the environment.",
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
                              padding: EdgeInsets.only(bottom: 20.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 8.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        "What type of data can IoT devices collect?",
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
                                    "Internet of Things devices can collect visual, audio, presence, location, biometrics, environment and unique identification data.",
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
