// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <nelson0.vieira@gmail.com>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "dart:collection";

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
  final Map<String, String> _markers = HashMap();
  final List<HashMap> _markers2 = [];

  Stream<List<Device>> readDevices() => FirebaseFirestore.instance
      .collection("devices")
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Device.fromJson(doc.data())).toList());

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
          padding: const EdgeInsets.all(35.0),
          color: const Color.fromARGB(255, 16, 44, 53),
          height: 800,
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
                height: 150,
                child: StreamBuilder(
                    stream: readDevices().first.asStream(),
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
                              "number": devices.first.category.length
                            },
                            {
                              "category": "Visual",
                              "number": devices.first.category.length
                            },
                            {
                              "category": "Audio",
                              "number": devices.first.category.length
                            },
                            {
                              "category": "Biometrics",
                              "number": devices.first.category.length
                            },
                            {
                              "category": "Location",
                              "number": devices.first.category.length
                            },
                            {
                              "category": "Presence",
                              "number": devices.first.category.length
                            },
                            {
                              "category": "Unique Identification",
                              "number": devices.first.category.length
                            },
                          ],
                          variables: {
                            "category": Variable(
                              accessor: (Map map) => map["category"] as String,
                            ),
                            "number": Variable(
                              accessor: (Map map) => map["number"] as num,
                            ),
                          },
                          marks: [IntervalMark()],
                          axes: [
                            Defaults.horizontalAxis,
                            Defaults.verticalAxis,
                          ],
                        );
                        //   Expanded(
                        //             child: Padding(
                        //               padding: const EdgeInsets.only(
                        //                   top: 24.0,
                        //                   right: 0.0,
                        //                   left: 0.0,
                        //                   bottom: 0.0),
                        //               child: ListView(
                        //                 children:
                        //                     devices.map(buildDevices).toList(),
                        //               ),
                        //             ),
                        //           );
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
    );
  }
}

// class Statistics extends StatelessWidget {
//   static const String route = "/statistics";

//   const Statistics({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           AppLocalizations.of(context)!.about,
//           style: const TextStyle(fontSize: 30),
//         ),
//         backgroundColor: const Color(0xFF334150),
//         automaticallyImplyLeading: false,
//       ),
//       body: Padding(
//         padding:
//             const EdgeInsets.only(top: 2.0, right: 4.0, left: 4.0, bottom: 4.0),
//         child: Container(
//           padding: const EdgeInsets.all(35.0),
//           color: const Color.fromARGB(255, 16, 44, 53),
//           child: Column(
//             children: [
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       Center(
//                         child: Container(
//                           margin:
//                               const EdgeInsets.only(top: 30.0, bottom: 50.0),
//                           child: Image.asset("assets/images/icon.png",
//                               width: 135.0),
//                         ),
//                       ),
//                       Align(
//                         alignment: Alignment.topLeft,
//                         child: Text(
//                           AppLocalizations.of(context)!.aboutContent,
//                           locale: const Locale("en", "UK"),
//                           textAlign: TextAlign.left,
//                           overflow: TextOverflow.visible,
//                           style: const TextStyle(
//                               color: Color.fromARGB(255, 245, 245, 245),
//                               fontSize: 16.0),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
