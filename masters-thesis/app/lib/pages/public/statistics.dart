// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <nelson0.vieira@gmail.com>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:graphic/graphic.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:iotprivacy/models/device.dart";

class Statistics extends StatefulWidget {
  static const String route = "/statistics";

  const Statistics({Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Estatísticas",
          style: const TextStyle(fontSize: 30),
        ),
        backgroundColor: const Color(0xFF334150),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 2.0, right: 4.0, left: 4.0, bottom: 4.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: const Color.fromARGB(255, 16, 44, 53),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Text(
                    "Per category",
                    locale: const Locale("en", "UK"),
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 245, 245, 245),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 300,
                    child: FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection("devices")
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                                child: Text(
                              AppLocalizations.of(context)!
                                  .firebaseError("${snapshot.error}"),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17.0,
                              ),
                              textAlign: TextAlign.center,
                            ));
                          } else if (snapshot.hasData) {
                            final devices = snapshot.data!;

                            return Chart(
                              data: [
                                {
                                  "category": "Environment",
                                  "number": devices.docs
                                      .where((element) =>
                                          element.get("category") ==
                                          "1qyoLqyrgmLTpLklqgFX")
                                      .length
                                },
                                {
                                  "category": "Visual",
                                  "number": devices.docs
                                      .where((element) =>
                                          element.get("category") ==
                                          "vfWA43iLPsUj6ZW3D5Rg")
                                      .length
                                },
                                {
                                  "category": "Audio",
                                  "number": devices.docs
                                      .where((element) =>
                                          element.get("category") ==
                                          "rhSmoONpwDl8B1mrXBZL")
                                      .length
                                },
                                {
                                  "category": "Biometrics",
                                  "number": devices.docs
                                      .where((element) =>
                                          element.get("category") ==
                                          "6yYW2K9Fv9AogHPfut5l")
                                      .length
                                },
                                {
                                  "category": "Location",
                                  "number": devices.docs
                                      .where((element) =>
                                          element.get("category") ==
                                          "WnvAzxPaI5Z8hFzUE228")
                                      .length
                                },
                                {
                                  "category": "Presence",
                                  "number": devices.docs
                                      .where((element) =>
                                          element.get("category") ==
                                          "bvf9p6MYF1DwxgDab2Mp")
                                      .length
                                },
                                {
                                  "category": "Unique Identification",
                                  "number": devices.docs
                                      .where((element) =>
                                          element.get("category") ==
                                          "08gNFyCLyxSxiYIcdFx0")
                                      .length
                                },
                              ],
                              variables: {
                                "category": Variable(
                                  accessor: (Map map) =>
                                      map["category"] as String,
                                ),
                                "number": Variable(
                                  accessor: (Map map) => map["number"] as num,
                                ),
                              },
                              transforms: [
                                Sort(
                                    compare: (tuple1, tuple2) =>
                                        tuple1["number"] - tuple2["number"])
                              ],
                              marks: [
                                IntervalMark(
                                  label: LabelEncode(
                                      encoder: (tuple) =>
                                          Label(tuple["category"].toString())),
                                  shape: ShapeEncode(
                                      value: RectShape(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                  )),
                                  color: ColorEncode(
                                      variable: "category",
                                      values: Defaults.colors10),
                                  elevation: ElevationEncode(value: 5),
                                  transition: Transition(
                                      duration: const Duration(seconds: 2),
                                      curve: Curves.elasticOut),
                                  entrance: {MarkEntrance.y},
                                )
                              ],
                              coord: PolarCoord(startRadius: 0.15),
                              axes: [
                                Defaults.horizontalAxis,
                                Defaults.verticalAxis,
                              ],
                              selections: {
                                "tap": PointSelection(
                                  on: {
                                    GestureType.hover,
                                    GestureType.tap,
                                  },
                                  dim: Dim.x,
                                )
                              },
                              tooltip: TooltipGuide(
                                backgroundColor: Colors.black,
                                elevation: 5,
                                textStyle: Defaults.textStyle,
                                variables: ["category", "number"],
                              ),
                              crosshair: CrosshairGuide(),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Text(
                    "Per identifiability",
                    locale: const Locale("en", "UK"),
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 245, 245, 245),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 350,
                    height: 300,
                    child: FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection("devices")
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                                child: Text(
                              AppLocalizations.of(context)!
                                  .firebaseError("${snapshot.error}"),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17.0,
                              ),
                              textAlign: TextAlign.center,
                            ));
                          } else if (snapshot.hasData) {
                            final devices = snapshot.data!;

                            return Chart(
                              data: [
                                {
                                  "identifiable": "Identifiable",
                                  "bool": devices.docs
                                      .where((element) =>
                                          element.get("identifiable") == true)
                                      .length
                                },
                                {
                                  "identifiable": "Not identifiable",
                                  "bool": devices.docs
                                      .where((element) =>
                                          element.get("identifiable") == false)
                                      .length
                                },
                              ],
                              variables: {
                                "identifiable": Variable(
                                  accessor: (Map map) =>
                                      map["identifiable"] as String,
                                ),
                                "bool": Variable(
                                  accessor: (Map map) => map["bool"] as num,
                                  scale: LinearScale(min: -8, max: 8),
                                ),
                              },
                              transforms: [
                                Sort(
                                  compare: (a, b) =>
                                      ((b["bool"] as num) - (a["bool"] as num))
                                          .toInt(),
                                )
                              ],
                              marks: [
                                IntervalMark(
                                  label: LabelEncode(
                                      encoder: (tuple) => Label(
                                            tuple["bool"].toString(),
                                            LabelStyle(
                                                textStyle: Defaults.runeStyle),
                                          )),
                                  shape: ShapeEncode(value: FunnelShape()),
                                  color: ColorEncode(
                                      variable: "identifiable",
                                      values: Defaults.colors10),
                                  modifiers: [SymmetricModifier()],
                                )
                              ],
                              coord: RectCoord(
                                  transposed: true, verticalRange: [1, 0]),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Text(
                    "Per privacy options",
                    locale: const Locale("en", "UK"),
                    overflow: TextOverflow.visible,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 245, 245, 245),
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 350,
                    height: 300,
                    child: FutureBuilder(
                        future: FirebaseFirestore.instance
                            .collection("devices")
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                                child: Text(
                              AppLocalizations.of(context)!
                                  .firebaseError("${snapshot.error}"),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17.0,
                              ),
                              textAlign: TextAlign.center,
                            ));
                          } else if (snapshot.hasData) {
                            final devices = snapshot.data!;

                            return Chart(
                              data: [
                                {
                                  "privacyOptions": "Has privacy options",
                                  "bool": devices.docs
                                      .where((element) =>
                                          element.get("privacyOptions") != "")
                                      .length
                                },
                                {
                                  "privacyOptions": "No privacy options",
                                  "bool": devices.docs
                                      .where((element) =>
                                          element.get("privacyOptions") == "")
                                      .length
                                },
                              ],
                              variables: {
                                "privacyOptions": Variable(
                                  accessor: (Map map) =>
                                      map["privacyOptions"] as String,
                                ),
                                "bool": Variable(
                                  accessor: (Map map) => map["bool"] as num,
                                ),
                              },
                              marks: [
                                IntervalMark(
                                  shape: ShapeEncode(
                                      value: RectShape(labelPosition: 0.5)),
                                  color: ColorEncode(
                                      variable: 'bool',
                                      values: Defaults.colors10),
                                  label: LabelEncode(
                                      encoder: (tuple) => Label(
                                            tuple['bool'].toString(),
                                            LabelStyle(
                                                textStyle: const TextStyle(
                                                    fontSize: 6)),
                                          )),
                                  modifiers: [StackModifier()],
                                )
                              ],
                              coord: RectCoord(
                                horizontalRangeUpdater:
                                    Defaults.horizontalRangeEvent,
                              ),
                              axes: [
                                Defaults.horizontalAxis,
                                Defaults.verticalAxis,
                              ],
                              selections: {
                                'tap': PointSelection(
                                  variable: 'privacyOptions',
                                )
                              },
                              tooltip: TooltipGuide(multiTuples: true),
                              crosshair: CrosshairGuide(),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
