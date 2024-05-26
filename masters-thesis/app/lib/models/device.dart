// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2024 Nelson Vieira
//
// @author Nelson Vieira <2080511@student.uma.pt>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "package:iotprivacy/helpers/app.dart";

class Device {
  String id;
  // Name of the device
  final String name;
  // Category of the device, can be of the types: health, visual, audio, presence,
  // location, biometrics, environment or unique identification
  final String category;
  // What is the purpose of the data being collected
  final String purpose;
  // Who has access to the data that is being collected
  final String whoHasAccess;
  // For how long is the data bring stored, doesn't matter if it is on the cloud
  // or on premises or other
  final String timeStored;
  // Can the data identify any individual?
  final bool identifiable;
  // What is being done with the data at the present moment
  final String whatsDone;
  // Is there any privacy options that the user can control? And what are they.
  final String privacyOptions;
  // Coordinates of the device so that it can be shown on the map
  final String latitude;
  final String longitude;
  // The device owner, can be an individual or an organization
  final String owner;
  // Metadata about this device on the database
  final DateTime createdAt;
  final DateTime updatedAt;

  Device({
    this.id = "",
    required this.name,
    required this.category,
    this.purpose = "",
    this.whoHasAccess = "",
    this.timeStored = "",
    this.identifiable = false,
    this.whatsDone = "",
    this.privacyOptions = "",
    required this.latitude,
    required this.longitude,
    this.owner = "",
    required this.createdAt,
    required this.updatedAt,
  });

  // This function serves to send the data about this device to Firebase
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
        "purpose": purpose,
        "whoHasAccess": whoHasAccess,
        "timeStored": timeStored,
        "identifiable": identifiable,
        "whatsDone": whatsDone,
        "privacyOptions": privacyOptions,
        "latitude": latitude,
        "longitude": longitude,
        "owner": owner,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };

  // This function serves to import the data on Firebase to be shown on the app
  static Device fromJson(Map<String, dynamic> json) => Device(
        id: Helper.transformString(json["id"]),
        name: Helper.transformString(json["name"]),
        category: Helper.transformString(json["category"]),
        purpose: Helper.transformString(json["purpose"]),
        whoHasAccess: Helper.transformString(json["whoHasAccess"]),
        timeStored: Helper.transformString(json["timeStored"]),
        identifiable: Helper.toBool(json["identifiable"]),
        whatsDone: Helper.transformString(json["whatsDone"]),
        privacyOptions: Helper.transformString(json["privacyOptions"]),
        latitude: Helper.transformString(json["latitude"]),
        longitude: Helper.transformString(json["longitude"]),
        owner: Helper.transformString(json["owner"]),
        createdAt: Helper.toTimestamp(json["createdAt"]).toDate(),
        updatedAt: Helper.toTimestamp(json["updatedAt"]).toDate(),
      );
}
