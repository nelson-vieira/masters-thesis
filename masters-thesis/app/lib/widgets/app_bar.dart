// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <nelson0.vieira@gmail.com>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "package:flutter/material.dart";

// Widget _buildMenuItem(
//     BuildContext context, Widget title, String routeName, String currentRoute) {
//   final isSelected = routeName == currentRoute;

//   return ListTile(
//     title: title,
//     selected: isSelected,
//     onTap: () {
//       if (isSelected) {
//         Navigator.pop(context);
//       } else {
//         Navigator.pushReplacementNamed(context, routeName);
//       }
//     },
//   );
// }

// void isHomepage(String bool) {
//   if (bool == "Yes") {
//     return;
//   }
// }

AppBar buildAppBar(String title) {
//   final Function e;

  return AppBar(
      //   leading: Drawer(
      //     child: ListView(
      //       children: <Widget>[
      //         const DrawerHeader(
      //           child: Center(
      //             child: Text("IoT Privacy"),
      //           ),
      //         ),
      //         _buildMenuItem(
      //           context,
      //           const Text('Home'),
      //           HomePage.route,
      //           currentRoute,
      //         ),
      //         _buildMenuItem(
      //           context,
      //           const Text("About"),
      //           About.route,
      //           currentRoute,
      //         ),
      //       ],
      //     ),
      //   ),
      leading: BackButton(color: Colors.black),
      title: Text(
        title,
        style: const TextStyle(fontSize: 30),
      ),
      backgroundColor: const Color(0xFFFF9000));
}
