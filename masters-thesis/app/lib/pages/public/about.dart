// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <nelson0.vieira@gmail.com>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "package:flutter/material.dart";
import "package:url_launcher/url_launcher.dart";
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class About extends StatelessWidget {
  static const String route = "/about";

  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.about,
          style: const TextStyle(fontSize: 30),
        ),
        backgroundColor: const Color(0xFF334150),
        automaticallyImplyLeading: false,
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
                      Center(
                        child: Container(
                          margin:
                              const EdgeInsets.only(top: 30.0, bottom: 50.0),
                          child: Image.asset("assets/images/icon.png",
                              width: 135.0),
                        ),
                      ),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "This application gives users information about IoT devices in their surroundings like the type of information these devices collect and what privacy options are available. It will show the geolocation of the IoT devices, what type of device it is, what type of data is being collect by the device. The application will not detect the devices by itself, this will be done by the users.",
                          locale: Locale("en", "UK"),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                              color: Color.fromARGB(255, 245, 245, 245),
                              fontSize: 16.0),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "You can access the source code of this application on the following link:",
                          locale: Locale("en", "UK"),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                              color: Color.fromARGB(255, 245, 245, 245),
                              fontSize: 16.0),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          if (!await launchUrl(Uri.parse(
                              "https://github.com/nelson-vieira/masters-thesis/tree/master/masters-thesis/app"))) {
                            throw Exception("Could not launch repository url");
                          }
                        },
                        child: const Text(
                          "https://github.com/nelson-vieira/masters-thesis/tree/master/masters-thesis/app",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Color.fromARGB(255, 75, 191, 206),
                            decoration: TextDecoration.underline,
                          ),
                          textAlign: TextAlign.start,
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
