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
import 'package:app/pages/public/home.dart';
import 'package:app/pages/public/about.dart';
import 'package:app/pages/public/encyclopedia.dart';
import 'package:app/pages/devices/devices.dart';
import "package:app/pages/auth.dart";
import 'package:app/pages/public/account.dart';
import 'package:app/helpers/helper.dart';
import "package:app/pages/forgot_password.dart";

class Login extends StatefulWidget {
  static const String route = "/login";
  final VoidCallback onClickRegister;

  const Login({
    Key? key,
    required this.onClickRegister,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
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

    Navigator.of(context).pushNamed(Account.route);
    // navigatorKey.currentState!.pushNamed(Account.route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Log In",
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
          Center(
            child: GestureDetector(
              child: Text(
                "Forgot Password?",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Color.fromARGB(255, 75, 191, 206),
                ),
              ),
              onTap: () =>
                  Navigator.of(context).pushNamed(ForgotPassword.route),
            ),
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
    );
  }
}
