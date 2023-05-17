// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <2080511@student.uma.pt>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "package:flutter/material.dart";

final messengerKey = GlobalKey<ScaffoldMessengerState>();

class Helper {
  static showSnackBar(String? text) {
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

//   static bool toBool(var val) {
//     try {
//       if (val == null) {
//         return false;
//       }
//       if (val is bool) {
//         return val;
//       } else {
//         return false;
//       }
//     } catch (error) {
//       print('Error');
//       return false;
//     }
//   }
}
