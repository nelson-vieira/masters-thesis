// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <nelson0.vieira@gmail.com>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "dart:async";
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "package:location/location.dart";
import "package:app/pages/home.dart";
import "package:app/pages/about.dart";

void main() {
  runApp(const IotPrivacy());
}

class IotPrivacy extends StatelessWidget {
  const IotPrivacy({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "IoT Privacy App",
      theme: ThemeData(canvasColor: Color(0xFF091220)),
      home: const HomePage(),
      routes: <String, WidgetBuilder>{
        About.route: (context) => const About(),
      },
    );
  }
}

// class IotPrivacy extends StatefulWidget {
//     const IotPrivacy({Key? key}) : super(key: key);

//     // This widget is the home page of your application. It is stateful, meaning
//     // that it has a State object (defined below) that contains fields that affect
//     // how it looks.

//     // This class is the configuration for the state. It holds the values (in this
//     // case the title) provided by the parent (in this case the App widget) and
//     // used by the build method of the State. Fields in a Widget subclass are
//     // always marked "final".

//     //final String title;

//     @override
//     _IotPrivacyState createState() => _IotPrivacyState();

//     // @override
//     // State<IotPrivacy> createState() => _IotPrivacyState();
// }

// // Invoke "debug painting" (press "p" in the console, choose the
// // "Toggle Debug Paint" action from the Flutter Inspector in Android
// // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
// // to see the wireframe for each widget.

// class _IotPrivacyState extends State<IotPrivacy> {
//     //const App({super.key});
//     @override
//     void initState() {
//         super.initState();
//     }

//     // This widget is the root of your application.
//     @override
//     Widget build(BuildContext context) {
//         return MaterialApp(
//             debugShowCheckedModeBanner: false,
//             home: Scaffold(
//                 appBar: AppBar(
//                     // Here we take the value from the MyHomePage object that was created by
//                     // the App.build method, and use it to set our appbar title.
//                     title: Text("IoT Privacy"),
//                 ),
//                 // Map here
//                 body: Center(
//                     child: SizedBox(
//                         child: FlutterMap(
//                             options: MapOptions(
//                                 center: LatLng(32.778295173354356, -16.737781931587615),
//                                 zoom: 9,
//                             ),
//                             nonRotatedChildren: [
//                                 AttributionWidget.defaultWidget(
//                                     source: 'OpenStreetMap contributors',
//                                     onSourceTapped: null,
//                                 ),
//                             ],
//                             children: [
//                                 TileLayer(
//                                 urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                                 userAgentPackageName: 'me.nelsonvieira.iot_privacy_app',
//                                 ),
//                             ],
//                         ),
//                     ),
//                 ),
//             ),
//         );
//     }
// }

// class _IotPrivacyState extends State<IotPrivacy> {
//     //double long = 49.5;
//     //double lat = -0.09;
//     //LatLng point = LatLng(49.5, -0.09);
//     //var location = [];

    // @override
    // Widget build(BuildContext context) {
    //     return MaterialApp(
    //     home: Scaffold(
    //         body: Center(
    //         child: SizedBox(
    //             child: FlutterMap(
    //                 options: MapOptions(
    //                     center: LatLng(32.778295173354356, -16.737781931587615),
    //                     zoom: 10,
    //                 ),
    //                 nonRotatedChildren: [
    //                                 AttributionWidget.defaultWidget(
    //                                     source: 'OpenStreetMap contributors',
    //                                     onSourceTapped: null,
    //                                 ),
    //                             ],
    //                 children: [
    //                     TileLayer(
    //                     urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
    //                     userAgentPackageName: 'dev.fleaflet.flutter_map.example',
    //                     ),
    //                 ],
    //             ),
    //         ),
    //         ),
    //     ),
    //     );
    // }

//     @override
//     Widget build(BuildContext context) {
//         return Scaffold(
//             // Map here
//             body: Center(
//                 child: Column(
//                     // Invoke "debug painting" (press "p" in the console, choose the
//                     // "Toggle Debug Paint" action from the Flutter Inspector in Android
//                     // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//                     // to see the wireframe for each widget.
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                         FlutterMap(
//                             options: MapOptions(
//                                 center: LatLng(32.778295173354356, -16.737781931587615),
//                                 zoom: 11,
//                             ),
//                             nonRotatedChildren: [
//                                 AttributionWidget.defaultWidget(
//                                     source: 'OpenStreetMap contributors',
//                                     onSourceTapped: null,
//                                 ),
//                             ],
//                             children: [
//                                 TileLayer(
//                                     urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                                     userAgentPackageName: 'com.example.app',
//                                 ),
//                             ],
//                         ),
//                     ],
//                 ),
//             ),
//         );
//     }
// }
