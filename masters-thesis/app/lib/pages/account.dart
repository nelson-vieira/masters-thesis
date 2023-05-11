// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <nelson0.vieira@gmail.com>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "dart:io";

import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";
import "package:firebase_core/firebase_core.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/gestures.dart";
import "package:app/main.dart";
import "package:app/pages/home.dart";
import "package:app/pages/about.dart";
import "package:app/pages/encyclopedia.dart";
import "package:app/pages/devices.dart";
import 'package:app/pages/auth.dart';
import 'package:app/pages/helper.dart';
import 'package:app/pages/forgot_password.dart';

class Account extends StatefulWidget {
  static const String route = "/account";
  final VoidCallback onClickRegister;

  const Account({
    Key? key,
    required this.onClickRegister,
  }) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPassword.dispose();

    super.dispose();
  }

  InputDecoration decoration(String label) => InputDecoration(
        labelText: label,
        enabledBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(color: Color.fromARGB(255, 255, 255, 255), width: 0.0),
        ),
        border: const OutlineInputBorder(),
        labelStyle: TextStyle(
          color: Colors.grey.shade600,
        ),
      );

  Future signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: controllerEmail.text.trim(),
        password: controllerPassword.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      //   if (e.code == "user-not-found") {
      //     print("No user found for that email.");
      //   } else if (e.code == "wrong-password") {
      //     print("Wrong password provided for that user.");
      //   }
      // } catch (e) {
      print(e);

      Helper.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () => Navigator.pushReplacementNamed(context, Home.route),
        ),
        title: const Text(
          "Account",
          style: TextStyle(fontSize: 30),
        ),
        backgroundColor: const Color(0xFF334150),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          TextField(
            controller: controllerEmail,
            decoration: decoration("Email"),
            textInputAction: TextInputAction.next,
            style: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: controllerPassword,
            decoration: decoration("Password"),
            textInputAction: TextInputAction.done,
            style: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          ElevatedButton(
            onPressed: signIn,
            child: const Text("Log in"),
          ),
          const SizedBox(
            height: 24,
          ),
          GestureDetector(
            child: Text(
              "Forgot Password?",
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Color.fromARGB(255, 75, 191, 206),
              ),
            ),
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ForgotPassword())),
          ),
          const SizedBox(
            height: 24,
          ),
          Center(
            child: RichText(
              text: TextSpan(
                text: "No account? ",
                style: const TextStyle(color: Colors.white),
                children: [
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.onClickRegister,
                    text: "Register",
                    style: const TextStyle(
                      decoration: TextDecoration.underline,
                      color: Color.fromARGB(255, 75, 191, 206),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: const Color(0xFF334150),
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            primaryColorDark: const Color(0xFF334150),
            textTheme: Theme.of(context).textTheme.copyWith(
                labelSmall: const TextStyle(
                    color: Color.fromARGB(255, 223, 141,
                        18)))), // sets the inactive color of the `BottomNavigationBar`
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: 3,
          selectedItemColor: const Color.fromARGB(255, 250, 250, 250),
          unselectedItemColor: const Color.fromARGB(255, 149, 196, 236),
          selectedIconTheme: const IconThemeData(
            color: Color.fromARGB(255, 250, 250, 250),
          ),
          unselectedIconTheme: const IconThemeData(
            color: Color.fromARGB(255, 149, 196, 236),
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.format_quote,
              ),
              label: "About",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.question_mark,
              ),
              label: "FAQ",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_circle,
              ),
              label: "Account",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_tree_outlined,
              ),
              label: "IoT Devices",
            ),
          ],
          onTap: (index) {
            switch (index) {
              case 0:
                Navigator.pushReplacementNamed(context, Home.route);
                break;
              case 1:
                Navigator.pushReplacementNamed(context, About.route);
                break;
              case 2:
                Navigator.pushReplacementNamed(context, Encyclopedia.route);
                break;
              case 3:
                Navigator.pushReplacementNamed(context, Auth.route);
                break;
              case 4:
                Navigator.pushReplacementNamed(context, Devices.route);
                break;
            }
          },
        ),
      ),
    );
  }
}
