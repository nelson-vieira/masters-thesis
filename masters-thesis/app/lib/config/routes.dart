// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <2080511@student.uma.pt>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "package:flutter/material.dart";
import "package:app/main.dart";
import "package:app/models/device.dart";
import 'package:app/pages/public/home.dart';
import 'package:app/pages/public/about.dart';
import 'package:app/pages/public/encyclopedia.dart';
import 'package:app/pages/auth/auth.dart';
import 'package:app/pages/devices/devices.dart';
import 'package:app/pages/devices/show.dart';
import 'package:app/pages/devices/update.dart';
import 'package:app/pages/devices/create.dart';
import 'package:app/pages/auth/account.dart';
import 'package:app/pages/auth/forgot_password.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case Home.route:
        return MaterialPageRoute(builder: (_) => const Home());
      case About.route:
        return MaterialPageRoute(builder: (_) => const About());
      case Encyclopedia.route:
        return MaterialPageRoute(builder: (_) => const Encyclopedia());
      case Auth.route:
        return MaterialPageRoute(builder: (_) => const Auth());
      case Devices.route:
        return MaterialPageRoute(builder: (_) => const Devices());
      case Create.route:
        return MaterialPageRoute(builder: (_) => const Create());
      case Account.route:
        return MaterialPageRoute(builder: (_) => const Account());
      case ForgotPassword.route:
        return MaterialPageRoute(builder: (_) => const ForgotPassword());
      case ShowDevice.route:
        if (args is Device) {
          return MaterialPageRoute(
            builder: (_) => ShowDevice(
              device: args,
            ),
          );
        }
        return _errorRoute();
      case Update.route:
        if (args is Device) {
          return MaterialPageRoute(
            builder: (_) => Update(
              device: args,
            ),
          );
        }
        return _errorRoute();
      default:
        return _errorRoute();
    }
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(builder: (_) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Error"),
      ),
      body: const Center(
        child: Text("ERROR"),
      ),
    );
  });
}