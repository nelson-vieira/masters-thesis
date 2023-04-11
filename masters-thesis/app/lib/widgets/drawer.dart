import "package:flutter/material.dart";
import "package:app/pages/home.dart";
import "package:app/pages/about.dart";

Widget _buildMenuItem(
    BuildContext context, Widget title, String routeName, String currentRoute) {
  final isSelected = routeName == currentRoute;

  return ListTile(
    title: title,
    selected: isSelected,
    onTap: () {
      if (isSelected) {
        Navigator.pop(context);
      } else {
        Navigator.pushReplacementNamed(context, routeName);
      }
    },
  );
}

Drawer buildDrawer(BuildContext context, String currentRoute) {
  return Drawer(
    child: ListView(
      children: <Widget>[
        const DrawerHeader(
          child: Center(
            child: Text("IoT Privacy"),
          ),
        ),
        _buildMenuItem(
          context,
          const Text('Home'),
          HomePage.route,
          currentRoute,
        ),
        _buildMenuItem(
          context,
          const Text("About"),
          About.route,
          currentRoute,
        ),
      ],
    ),
  );
}
