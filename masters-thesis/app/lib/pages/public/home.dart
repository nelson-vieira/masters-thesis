// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2024 Nelson Vieira
//
// @author Nelson Vieira <2080511@student.uma.pt>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:geolocator/geolocator.dart";
import "package:iotprivacy/models/device.dart";
import "package:iotprivacy/pages/devices/show.dart";
import "package:iotprivacy/pages/devices/create.dart";
import "package:iotprivacy/helpers/location_service.dart";

class Home extends StatefulWidget {
  static const String route = "/";

  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Marker> _markers = <Marker>[];
  Position? _currentPosition;

  String _locationText = "User location appears here!";

  late LatLng latLng = LatLng(32.778295173354356, -16.737781931587615);
//   LatLng _initialLatLng = LatLng(32.778295173354356, -16.737781931587615);
  late MapOptions options;

  @override
  void initState() {
    // This function runs whenever this page is loaded, very important so that
    // the data can be ready to show on the page
    getMarkersData();
    _getCurrentLocation();
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  Image markerImage(Device device) {
    switch (device.category) {
      case "08gNFyCLyxSxiYIcdFx0":
        return Image.asset("assets/images/unique_identification_marker.png",
            width: 200.0);
      case "1qyoLqyrgmLTpLklqgFX":
        return Image.asset("assets/images/environment_marker.png",
            width: 200.0);
      case "6yYW2K9Fv9AogHPfut5l":
        return Image.asset("assets/images/biometrics_marker.png", width: 200.0);
      case "WnvAzxPaI5Z8hFzUE228":
        return Image.asset("assets/images/location_marker.png", width: 200.0);
      case "bvf9p6MYF1DwxgDab2Mp":
        return Image.asset("assets/images/presence_marker.png", width: 200.0);
      case "rhSmoONpwDl8B1mrXBZL":
        return Image.asset("assets/images/audio_marker.png", width: 200.0);
      case "vfWA43iLPsUj6ZW3D5Rg":
        return Image.asset("assets/images/visual_marker.png", width: 200.0);
      default:
        return Image.asset("assets/images/icon.png", width: 120.0);
    }
  }

  // Function to create a Marker and add to list
  void createMarker(Device device) async {
    final Marker marker = Marker(
      point:
          LatLng(double.parse(device.latitude), double.parse(device.longitude)),
      builder: (context) => GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(ShowDevice.route, arguments: device);
        },
        child: markerImage(device),
      ),
      width: 27.0,
      height: 41.85,
      anchorPos: AnchorPos.exactly(Anchor(13.5, 0.0)),
    );
    // Only adds to the marker list with setState method
    setState(() {
      _markers.add(marker);
    });
  }

  // This function gets all devices from database and for each one, createMarker
  // is called which creates the Marker
  getMarkersData() async {
    await FirebaseFirestore.instance.collection("devices").get().then((data) {
      if (data.docs.isNotEmpty) {
        for (int i = 0; i < data.docs.length; i++) {
          createMarker(Device.fromJson(data.docs[i].data()));
        }
      }
    });
  }

  void _getCurrentLocation() async {
    try {
      _currentPosition =
          await LocationService.instance.getCurrentLocation(context);
    } catch (e) {
      print(e);
    }

    setState(() {
      _locationText =
          "Lat: ${_currentPosition!.latitude.toString()}, Long: ${_currentPosition!.longitude.toString()}";
    });
  }

//   Future<Position> getCurrentLocation() async {
//     bool _serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!_serviceEnabled) {
//       return Future.error("Location is disabled");
//     }

//     var locationPermission = await Geolocator.checkPermission();
//     if (locationPermission == LocationPermission.denied) {
//       locationPermission = await Geolocator.requestPermission();
//       if (locationPermission == LocationPermission.deniedForever) {
//         return Future.error("Location permission is denied");
//       }
//     }

//     // if (permission == LocationPermission.deniedForever) {
//     //   return Future.error("Location permanently denied");
//     // }

//     // currentLatLng =
//     //     LatLng(_currentPosition!.latitude, _currentPosition!.longitude);
//     return await Geolocator.getCurrentPosition();
//   }

//   getLatLng() {
//     getCurrentLocation().then((value) {
//       setState(() {
//         latLng = LatLng(value.latitude, value.longitude);
//         options = MapOptions(
//           center: latLng != null
//               ? latLng
//               : LatLng(32.778295173354356, -16.737781931587615),
//           interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
//           zoom: 9,
//         );
//       });
//       streamLocation();
//     });
//   }

//   void streamLocation() {
//     LocationSettings locationSettings = const LocationSettings(
//       accuracy: LocationAccuracy.high,
//       distanceFilter: 100,
//     );

//     Geolocator.getPositionStream(locationSettings: locationSettings)
//         .listen((Position position) {
//       setState(() {
//         latLng = LatLng(position.latitude, position.longitude);
//       });
//     });
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //   appBar: AppBar(
      //     title: Text(
      //       AppLocalizations.of(context)!.appTitle,
      //       style: TextStyle(fontSize: 30),
      //     ),
      //     backgroundColor: const Color(0xFF334150),
      //   ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 2.0, right: 4.0, left: 4.0, bottom: 4.0),
        child: Column(
          children: [
            Flexible(
              child: FlutterMap(
                options: MapOptions(
                  center: latLng,
                  interactiveFlags:
                      InteractiveFlag.all & ~InteractiveFlag.rotate,
                  zoom: 9,
                ),
                nonRotatedChildren: [
                  AttributionWidget.defaultWidget(
                    source: "OpenStreetMap",
                    onSourceTapped: null,
                  ),
                ],
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    userAgentPackageName: "me.nelsonvieira.iotprivacy",
                  ),
                  MarkerLayer(markers: _markers),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 22.0, right: 0.0, left: 15.0, bottom: 0.0),
                    child: FloatingActionButton(
                      child: const Icon(Icons.location_searching),
                      onPressed: () {
                        _getCurrentLocation();
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Text(
            //   _locationText,
            //   style: const TextStyle(
            //     color: Color.fromARGB(255, 245, 245, 245),
            //   ),
            // ),
            // Row(
            //   children: [
            //     ElevatedButton.icon(
            //         icon: markerImage(device),
            //         label: Text(
            //           "",
            //           style: const TextStyle(
            //               color: Color.fromARGB(255, 245, 245, 245),
            //               fontSize: 16.0),
            //         ),
            //         onPressed: () {
            //           _getLocation().then((value) {
            //             lat = "${value.latitude}";
            //             long = "${value.longitude}";
            //             setState(() {
            //               locationMessage = "Lat: $lat, Long: $long";
            //             });
            //             // _liveLocation();
            //           });
            //         },
            //         child: const Text("Location")),
            //   ],
            // ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FirebaseAuth.instance.currentUser != null
          ? FloatingActionButton.extended(
              backgroundColor: const Color(0xFF0A8A4E),
              label: Text(
                AppLocalizations.of(context)!.addDevice,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              tooltip: AppLocalizations.of(context)!.addDeviceTooltip,
              icon: const Icon(Icons.account_tree_outlined),
              onPressed: () {
                Navigator.of(context).pushNamed(Create.route);
              },
            )
          : Container(),
    );
  }
}
