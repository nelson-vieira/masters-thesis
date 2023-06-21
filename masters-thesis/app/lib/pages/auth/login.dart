// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <nelson0.vieira@gmail.com>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/gestures.dart";
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import "package:iotprivacy/main.dart";
import "package:iotprivacy/helpers/app.dart";
import "package:iotprivacy/pages/auth/forgot_password.dart";

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

      FirebaseFirestore.instance
          .collection("users")
          .where("email", isEqualTo: controllerEmail.text.trim())
          .get()
          .then((value) => value.docs.first
              .data()
              .update("lastLogin", (value) => DateTime.now));
    } on FirebaseAuthException catch (e) {
      print(e);

      Helper.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.signIn,
          style: const TextStyle(fontSize: 30),
        ),
        backgroundColor: const Color(0xFF334150),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 2.0, right: 4.0, left: 4.0, bottom: 4.0),
        child: Container(
          color: const Color.fromARGB(255, 16, 44, 53),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: <Widget>[
              TextField(
                controller: controllerEmail,
                decoration: decoration(AppLocalizations.of(context)!.email),
                textInputAction: TextInputAction.next,
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: controllerPassword,
                decoration: decoration(AppLocalizations.of(context)!.password),
                textInputAction: TextInputAction.done,
                obscureText: true,
                style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0A8A4E),
                  padding: const EdgeInsets.only(
                      left: 0.0, top: 18.0, right: 0.0, bottom: 18.0),
                ),
                onPressed: signIn,
                child: Text(
                  AppLocalizations.of(context)!.signIn,
                  style: const TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Center(
                child: GestureDetector(
                  child: Text(
                    AppLocalizations.of(context)!.forgotPassword,
                    style: const TextStyle(
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
                    text: AppLocalizations.of(context)!.noAccount,
                    style: const TextStyle(color: Colors.white),
                    children: [
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = widget.onClickRegister,
                        text: AppLocalizations.of(context)!.register,
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
        ),
      ),
    );
  }
}
