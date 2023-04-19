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

// AppBar buildAppBar(String title) {
// //   final Function e;

//   return AppBar(
//       //   leading: Drawer(
//       //     child: ListView(
//       //       children: <Widget>[
//       //         const DrawerHeader(
//       //           child: Center(
//       //             child: Text("IoT Privacy"),
//       //           ),
//       //         ),
//       //         _buildMenuItem(
//       //           context,
//       //           const Text('Home'),
//       //           HomePage.route,
//       //           currentRoute,
//       //         ),
//       //         _buildMenuItem(
//       //           context,
//       //           const Text("About"),
//       //           About.route,
//       //           currentRoute,
//       //         ),
//       //       ],
//       //     ),
//       //   ),
//       leading: BackButton(color: Colors.black),
//       title: Text(
//         title,
//         style: const TextStyle(fontSize: 30),
//       ),
//       backgroundColor: const Color(0xFFFF9000));
// }
tap(BuildContext context, String route, String currentRoute) {
  final isSelected = route == currentRoute;

  if (isSelected) {
    Navigator.pop(context);
  } else {
    Navigator.pushReplacementNamed(context, route);
  }
}

BottomNavigationBar buildBottomNavigationBar(
    BuildContext context, String route, String currentRoute) {
  final isSelected = route == currentRoute;
  return BottomNavigationBar(
    backgroundColor: Color(0xFF10111A),
    items: const [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          color: Color(0xFF7EADDA),
        ),
        label: "Home",
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.textsms_rounded,
          color: Color(0xFF7EADDA),
        ),
        label: "About",
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.question_answer_outlined,
          color: Color(0xFF7EADDA),
        ),
        label: "FAQ",
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.account_circle,
          color: Color(0xFF7EADDA),
        ),
        label: "Account",
      ),
    ],
    // onTap: (index) {
    //   setState(() {
    //     _currentIndex = index;
    //   });
    onTap: (index) {
      if (isSelected) {
        Navigator.pop(context);
      } else {
        Navigator.pushReplacementNamed(context, route);
      }
    },
    selectedItemColor: Color.fromARGB(255, 212, 135, 19),
  );
}
