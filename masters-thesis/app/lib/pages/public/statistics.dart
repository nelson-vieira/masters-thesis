// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2024 Nelson Vieira
//
// @author Nelson Vieira <2080511@student.uma.pt>
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
          AppLocalizations.of(context)!.statistics,
          style: const TextStyle(fontSize: 30),
        ),
        backgroundColor: const Color(0xFF334150),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 2.0, right: 4.0, left: 4.0, bottom: 4.0),
        child: Container(
          padding: const EdgeInsets.only(
              top: 35.0, right: 16.0, left: 16.0, bottom: 16.0),
          color: const Color.fromARGB(255, 16, 44, 53),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.perCategory,
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
                                  AppLocalizations.of(context)!.categoryColumn:
                                      AppLocalizations.of(context)!
                                          .categoryEnvironment,
                                  AppLocalizations.of(context)!.numberColumn:
                                      devices.docs
                                          .where((element) =>
                                              element.get("category") ==
                                              "1qyoLqyrgmLTpLklqgFX")
                                          .length
                                },
                                {
                                  AppLocalizations.of(context)!.categoryColumn:
                                      AppLocalizations.of(context)!
                                          .categoryVisual,
                                  AppLocalizations.of(context)!.numberColumn:
                                      devices.docs
                                          .where((element) =>
                                              element.get("category") ==
                                              "vfWA43iLPsUj6ZW3D5Rg")
                                          .length
                                },
                                {
                                  AppLocalizations.of(context)!.categoryColumn:
                                      AppLocalizations.of(context)!
                                          .categoryAudio,
                                  AppLocalizations.of(context)!.numberColumn:
                                      devices.docs
                                          .where((element) =>
                                              element.get("category") ==
                                              "rhSmoONpwDl8B1mrXBZL")
                                          .length
                                },
                                {
                                  AppLocalizations.of(context)!.categoryColumn:
                                      AppLocalizations.of(context)!
                                          .categoryBiometrics,
                                  AppLocalizations.of(context)!.numberColumn:
                                      devices.docs
                                          .where((element) =>
                                              element.get("category") ==
                                              "6yYW2K9Fv9AogHPfut5l")
                                          .length
                                },
                                {
                                  AppLocalizations.of(context)!.categoryColumn:
                                      AppLocalizations.of(context)!
                                          .categoryLocation,
                                  AppLocalizations.of(context)!.numberColumn:
                                      devices.docs
                                          .where((element) =>
                                              element.get("category") ==
                                              "WnvAzxPaI5Z8hFzUE228")
                                          .length
                                },
                                {
                                  AppLocalizations.of(context)!.categoryColumn:
                                      AppLocalizations.of(context)!
                                          .categoryPresence,
                                  AppLocalizations.of(context)!.numberColumn:
                                      devices.docs
                                          .where((element) =>
                                              element.get("category") ==
                                              "bvf9p6MYF1DwxgDab2Mp")
                                          .length
                                },
                                {
                                  AppLocalizations.of(context)!.categoryColumn:
                                      AppLocalizations.of(context)!
                                          .categoryUniqueIdentification,
                                  AppLocalizations.of(context)!.numberColumn:
                                      devices.docs
                                          .where((element) =>
                                              element.get("category") ==
                                              "08gNFyCLyxSxiYIcdFx0")
                                          .length
                                },
                              ],
                              variables: {
                                AppLocalizations.of(context)!.categoryColumn:
                                    Variable(
                                  accessor: (Map map) => map[
                                      AppLocalizations.of(context)!
                                          .categoryColumn] as String,
                                ),
                                AppLocalizations.of(context)!.numberColumn:
                                    Variable(
                                  accessor: (Map map) => map[
                                      AppLocalizations.of(context)!
                                          .numberColumn] as num,
                                ),
                              },
                              transforms: [
                                Sort(
                                    compare: (tuple1, tuple2) =>
                                        tuple1[AppLocalizations.of(context)!
                                            .numberColumn] -
                                        tuple2[AppLocalizations.of(context)!
                                            .numberColumn])
                              ],
                              marks: [
                                IntervalMark(
                                  label: LabelEncode(
                                      encoder: (tuple) => Label(tuple[
                                              AppLocalizations.of(context)!
                                                  .categoryColumn]
                                          .toString())),
                                  shape: ShapeEncode(
                                      value: RectShape(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                  )),
                                  color: ColorEncode(
                                      variable: AppLocalizations.of(context)!
                                          .categoryColumn,
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
                                variables: [
                                  AppLocalizations.of(context)!.categoryColumn,
                                  AppLocalizations.of(context)!.numberColumn
                                ],
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
                    AppLocalizations.of(context)!.perIdentifiability,
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
                                  AppLocalizations.of(context)!
                                          .identifiableColumn:
                                      AppLocalizations.of(context)!
                                          .yesIdentifiable,
                                  AppLocalizations.of(context)!.boolColumn:
                                      devices.docs
                                          .where((element) =>
                                              element.get("identifiable") ==
                                              true)
                                          .length
                                },
                                {
                                  AppLocalizations.of(context)!
                                          .identifiableColumn:
                                      AppLocalizations.of(context)!
                                          .noIdentifiable,
                                  AppLocalizations.of(context)!.boolColumn:
                                      devices.docs
                                          .where(
                                              (element) =>
                                                  element.get("identifiable") ==
                                                  false)
                                          .length
                                },
                              ],
                              variables: {
                                AppLocalizations.of(context)!
                                    .identifiableColumn: Variable(
                                  accessor: (Map map) => map[
                                      AppLocalizations.of(context)!
                                          .identifiableColumn] as String,
                                ),
                                AppLocalizations.of(context)!.boolColumn:
                                    Variable(
                                  accessor: (Map map) => map[
                                      AppLocalizations.of(context)!
                                          .boolColumn] as num,
                                ),
                              },
                              marks: [
                                IntervalMark(
                                  position: Varset(AppLocalizations.of(context)!
                                          .boolColumn) /
                                      Varset(AppLocalizations.of(context)!
                                          .identifiableColumn),
                                  label: LabelEncode(
                                      encoder: (tuple) => Label(
                                            "${tuple[AppLocalizations.of(context)!.identifiableColumn].toString()} - ${tuple[AppLocalizations.of(context)!.boolColumn].toString()}",
                                            LabelStyle(
                                                textStyle: const TextStyle(
                                              fontSize: 10,
                                            )),
                                          )),
                                  color: ColorEncode(
                                      variable: AppLocalizations.of(context)!
                                          .identifiableColumn,
                                      values: Defaults.colors10),
                                  modifiers: [StackModifier()],
                                  transition: Transition(
                                      duration: const Duration(seconds: 2)),
                                  entrance: {MarkEntrance.y},
                                )
                              ],
                              coord: PolarCoord(transposed: true, dimCount: 1),
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
                    AppLocalizations.of(context)!.perPrivacyOptions,
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
                                  AppLocalizations.of(context)!
                                          .privacyOptionsColumn:
                                      AppLocalizations.of(context)!
                                          .yesPrivacyOptions,
                                  AppLocalizations.of(context)!.boolColumn:
                                      devices.docs
                                          .where((element) =>
                                              element.get("privacyOptions") !=
                                              "")
                                          .length
                                },
                                {
                                  AppLocalizations.of(context)!
                                          .privacyOptionsColumn:
                                      AppLocalizations.of(context)!
                                          .noPrivacyOptions,
                                  AppLocalizations.of(context)!.boolColumn:
                                      devices.docs
                                          .where((element) =>
                                              element.get("privacyOptions") ==
                                              "")
                                          .length
                                },
                              ],
                              variables: {
                                AppLocalizations.of(context)!
                                    .privacyOptionsColumn: Variable(
                                  accessor: (Map map) => map[
                                      AppLocalizations.of(context)!
                                          .privacyOptionsColumn] as String,
                                ),
                                AppLocalizations.of(context)!.boolColumn:
                                    Variable(
                                  accessor: (Map map) => map[
                                      AppLocalizations.of(context)!
                                          .boolColumn] as num,
                                ),
                              },
                              marks: [
                                IntervalMark(
                                  shape: ShapeEncode(
                                      value: RectShape(
                                    histogram: true,
                                  )),
                                  transition: Transition(
                                      duration: const Duration(seconds: 3)),
                                  color: ColorEncode(
                                      variable: AppLocalizations.of(context)!
                                          .boolColumn,
                                      values: Defaults.colors10),
                                  label: LabelEncode(
                                      encoder: (tuple) => Label(
                                            tuple[AppLocalizations.of(context)!
                                                    .boolColumn]
                                                .toString(),
                                            LabelStyle(
                                                textStyle: const TextStyle(
                                              fontSize: 6,
                                            )),
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
                                "tap": PointSelection(
                                  variable: AppLocalizations.of(context)!
                                      .privacyOptionsColumn,
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
