// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <2080511@student.uma.pt>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "package:flutter/material.dart";
import "package:app/main.dart";
import "package:app/pages/home.dart";
import "package:app/pages/about.dart";
import "package:app/pages/encyclopedia.dart";
import "package:app/pages/auth.dart";
import "package:app/pages/devices.dart";

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case Home.route:
        return MaterialPageRoute(builder: (_) => const Home());
      case About.route:
        // if (args is String) {
        //   return MaterialPageRoute(
        //     builder: (_) => About(
        //       data: args,
        //     ),
        //   );
        // }
        // return _errorRoute();
        return MaterialPageRoute(builder: (_) => const About());
      case Encyclopedia.route:
        return MaterialPageRoute(builder: (_) => const Encyclopedia());
      case Auth.route:
        return MaterialPageRoute(builder: (_) => const Auth());
      case Devices.route:
        return MaterialPageRoute(builder: (_) => const Devices());
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
