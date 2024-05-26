// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2024 Nelson Vieira
//
// @author Nelson Vieira <2080511@student.uma.pt>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:geolocator/geolocator.dart";

class LocationService {
  static final LocationService instance = LocationService();

  Future<Position> getCurrentLocation(BuildContext context) async {
    bool _serviceEnabled;
    LocationPermission _locationPermission;

    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!_serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Location is not enabled!")));
      }
    }

    _locationPermission = await Geolocator.checkPermission();
    if (_locationPermission == LocationPermission.denied) {
      _locationPermission = await Geolocator.requestPermission();
      if (_locationPermission != LocationPermission.always ||
          _locationPermission != LocationPermission.whileInUse) {
        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //     content: Text("Location permissions are permanently denied.")));
        return Future.microtask(() => throw PlatformException(
            code: "PERMISSION_DENIED",
            message: "Location permissions are denied",
            details: null));
      }
    }

    Position currentLocation = await Geolocator.getCurrentPosition();
    return currentLocation;
  }
}
