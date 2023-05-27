// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <2080511@student.uma.pt>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import 'package:app/helpers/app.dart';
import "package:cloud_firestore/cloud_firestore.dart";

class UserDocument {
  String id;
  // Email of the user
  final String email;
  // Role of the user
  final String role;
  // User metadata
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime lastLogin;

  UserDocument({
    this.id = "",
    required this.email,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    required this.lastLogin,
  });

  // This function serves to send the data about this device to Firebase
  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "role": role,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "lastLogin": lastLogin,
      };

  // This function serves to import the data on Firebase to be shown on the app
  static UserDocument fromJson(Map<String, dynamic> json) => UserDocument(
        id: Helper.transformString(json["id"]),
        email: Helper.transformString(json["name"]),
        role: Helper.transformString(json["role"]),
        createdAt: (json["createdAt"] as Timestamp).toDate(),
        updatedAt: (json["updatedAt"] as Timestamp).toDate(),
        lastLogin: (json["updatedAt"] as Timestamp).toDate(),
      );
}
