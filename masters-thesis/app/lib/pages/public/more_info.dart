// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <nelson0.vieira@gmail.com>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import "package:iotprivacy/pages/public/statistics.dart";

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
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Text(
                            AppLocalizations.of(context)!.infoIntro,
                            locale: const Locale("en", "UK"),
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.visible,
                            style: const TextStyle(
                              color: Color.fromARGB(255, 245, 245, 245),
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      ),
                      FirebaseAuth.instance.currentUser != null
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 20.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .howToAddDeviceQ,
                                        locale: const Locale("en", "UK"),
                                        overflow: TextOverflow.visible,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 245, 245, 245),
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .howToAddDeviceA,
                                    locale: const Locale("en", "UK"),
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.visible,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 245, 245, 245),
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
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
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .whatDigitalPrivacyQ,
                                        locale: const Locale("en", "UK"),
                                        overflow: TextOverflow.visible,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 245, 245, 245),
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .whatDigitalPrivacyA,
                                    locale: const Locale("en", "UK"),
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.visible,
                                    style: const TextStyle(
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
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .whatInternetOfThingsQ,
                                        locale: const Locale("en", "UK"),
                                        overflow: TextOverflow.visible,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 245, 245, 245),
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .whatInternetOfThingsA,
                                    locale: const Locale("en", "UK"),
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.visible,
                                    style: const TextStyle(
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
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .whatTypeOfDataQ,
                                        locale: const Locale("en", "UK"),
                                        overflow: TextOverflow.visible,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Color.fromARGB(
                                              255, 245, 245, 245),
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    AppLocalizations.of(context)!
                                        .whatTypeOfDataA,
                                    locale: const Locale("en", "UK"),
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.visible,
                                    style: const TextStyle(
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
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xFF0A8A4E),
        label: Text(
          "Estatísticas",
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        tooltip: AppLocalizations.of(context)!.addDeviceTooltip,
        icon: const Icon(Icons.graphic_eq_outlined),
        onPressed: () {
          Navigator.of(context).pushNamed(Statistics.route);
        },
      ),
    );
  }
}
