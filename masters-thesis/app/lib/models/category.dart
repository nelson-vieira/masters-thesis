// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2024 Nelson Vieira
//
// @author Nelson Vieira <2080511@student.uma.pt>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "package:iotprivacy/helpers/app.dart";

class Category {
  String id;
  // Name of the category
  final String name;
  // Metadata about this device on the database
  final DateTime createdAt;
  final DateTime updatedAt;

  Category({
    this.id = "",
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  // This function serves to send the data about this device to Firebase
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
      };

  // This function serves to import the data on Firebase to be shown on the app
  static Category fromJson(Map<String, dynamic> json) => Category(
        id: Helper.transformString(json["id"]),
        name: Helper.transformString(json["name"]),
        createdAt: Helper.toTimestamp(json["createdAt"]).toDate(),
        updatedAt: Helper.toTimestamp(json["updatedAt"]).toDate(),
      );
}
