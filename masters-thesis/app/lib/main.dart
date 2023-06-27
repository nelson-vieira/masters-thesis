// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <2080511@student.uma.pt>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "package:iotprivacy/config/routes.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:firebase_core/firebase_core.dart";
import "config/firebase_options.dart";
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import "package:iotprivacy/pages/public/home.dart";
import "package:iotprivacy/pages/public/about.dart";
import 'package:iotprivacy/pages/public/more_info.dart';
import "package:iotprivacy/pages/auth/account.dart";
import "package:iotprivacy/pages/devices/devices.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const Main());
}

final navigatorKey = GlobalKey<NavigatorState>();

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //   scaffoldMessengerKey: Helper.messengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: "IoT Privacy App",
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("en", "UK"),
        Locale("pt", "PT"),
      ],
      theme: ThemeData(
        fontFamily: "Jost",
        canvasColor: const Color(0xFF091220),
        // colorScheme: const ColorScheme(
        //   brightness: Brightness.dark,
        //   primary: Color.fromARGB(255, 212, 10, 10),
        //   onPrimary: Color.fromARGB(255, 212, 10, 10),
        //   secondary: Color.fromARGB(255, 212, 10, 10),
        //   onSecondary: Color.fromARGB(255, 212, 10, 10),
        //   error: Color.fromARGB(255, 212, 10, 10),
        //   onError: Color.fromARGB(255, 212, 10, 10),
        //   background: Color.fromARGB(255, 212, 10, 10),
        //   onBackground: Color.fromARGB(255, 212, 10, 10),
        //   surface: Color.fromARGB(255, 212, 10, 10),
        //   onSurface: Color.fromARGB(255, 212, 10, 10),
        // ),
      ),
      initialRoute: Home.route,
      home: const IotPrivacy(),
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class IotPrivacy extends StatefulWidget {
  const IotPrivacy({super.key});

  @override
  State<IotPrivacy> createState() => _IotPrivacyState();
}

class _IotPrivacyState extends State<IotPrivacy> {
  int _currentIndex = 0;

  final pages = <Widget>[
    const Home(),
    const About(),
    const MoreInfo(),
    const Account(),
    const Devices(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          // Sets the background color of the bottom navigation bar
          canvasColor: const Color(0xFF334150),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(
            color: Color.fromARGB(255, 250, 250, 250),
          ),
          unselectedLabelStyle: const TextStyle(
            color: Color.fromARGB(255, 149, 196, 236),
          ),
          selectedFontSize: 12.0,
          unselectedFontSize: 12.0,
          selectedItemColor: const Color.fromARGB(255, 250, 250, 250),
          unselectedItemColor: Color.fromARGB(255, 149, 196, 236),
          selectedIconTheme: const IconThemeData(
            color: Color.fromARGB(255, 250, 250, 250),
          ),
          unselectedIconTheme: const IconThemeData(
            color: Color.fromARGB(255, 149, 196, 236),
          ),
          items: [
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.house_outlined,
              ),
              label: AppLocalizations.of(context)!.home,
              activeIcon: const Icon(
                Icons.house,
              ),
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.info_outline_rounded,
              ),
              label: AppLocalizations.of(context)!.about,
              activeIcon: const Icon(
                Icons.info,
              ),
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.book_outlined,
              ),
              label: AppLocalizations.of(context)!.info,
              activeIcon: const Icon(
                Icons.menu_book_rounded,
              ),
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.account_circle_outlined,
              ),
              label: AppLocalizations.of(context)!.account,
              activeIcon: const Icon(
                Icons.account_circle,
              ),
            ),
            BottomNavigationBarItem(
              icon: const Icon(
                Icons.account_tree_outlined,
              ),
              label: AppLocalizations.of(context)!.devices,
              activeIcon: const Icon(
                Icons.account_tree,
              ),
            ),
          ],
          onTap: (index) => setState(() => _currentIndex = index),
        ),
      ),
    );
  }
}
