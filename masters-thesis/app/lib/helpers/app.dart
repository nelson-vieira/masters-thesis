// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2024 Nelson Vieira
//
// @author Nelson Vieira <2080511@student.uma.pt>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";

class Helper {
//   final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String? text) {
    final messengerKey = GlobalKey<ScaffoldMessengerState>();
    if (text == null) return;

    final snackBar = SnackBar(
      content: Text(text),
      backgroundColor: Colors.red,
    );

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static String transformString(var val) {
    try {
      if (val == null) {
        return "";
      }
      if (val is String) {
        return val;
      } else {
        return val.toString();
      }
    } catch (error) {
      print('Error');
      return "";
    }
  }

  static bool toBool(var val) {
    try {
      if (val == null) {
        return false;
      }
      if (val is bool) {
        return val;
      } else {
        return false;
      }
    } catch (error) {
      print('Error');
      return false;
    }
  }

  static Timestamp toTimestamp(var val) {
    try {
      if (val == null) {
        return Timestamp.now();
      }
      if (val is Timestamp) {
        return val;
      } else {
        return Timestamp.now();
      }
    } catch (error) {
      print('Error');
      return Timestamp.now();
    }
  }

  static int toInt(var val) {
    try {
      if (val == null) {
        return 0;
      }
      if (val is int) {
        return val;
      } else {
        return 0;
      }
    } catch (error) {
      print('Error');
      return 0;
    }
  }
}
