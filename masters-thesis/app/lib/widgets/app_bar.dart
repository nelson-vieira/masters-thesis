import "package:flutter/material.dart";
import "package:app/widgets/drawer.dart";

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
      title: Text(
        title,
        style: TextStyle(fontSize: 30),
      ),
      backgroundColor: Color(0xFFFF9000));
}
