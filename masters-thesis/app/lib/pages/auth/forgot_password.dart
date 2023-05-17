// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <nelson0.vieira@gmail.com>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:email_validator/email_validator.dart";
import "package:app/main.dart";
import 'package:app/pages/auth/auth.dart';
import 'package:app/helpers/app.dart';

class ForgotPassword extends StatefulWidget {
  static const String route = "/forgot_password";

  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = GlobalKey<FormState>();
  final controllerEmail = TextEditingController();

  @override
  void dispose() {
    controllerEmail.dispose();

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

  Future resetPassword() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: controllerEmail.text.trim(),
      );
      Helper.showSnackBar("Password reset email sent!");
      //   navigatorKey.currentState!.popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      //   if (e.code == "user-not-found") {
      //     print("No user found for that email.");
      //   } else if (e.code == "wrong-password") {
      //     print("Wrong password provided for that user.");
      //   }
      // } catch (e) {
      print(e);

      Helper.showSnackBar(e.message);

      //   navigatorKey.currentState!.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Reset Password",
          style: TextStyle(fontSize: 30),
        ),
        backgroundColor: const Color(0xFF334150),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            TextFormField(
              controller: controllerEmail,
              decoration: decoration('Email'),
              style: const TextStyle(
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              textInputAction: TextInputAction.done,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
                  email != null && !EmailValidator.validate(email)
                      ? "Please enter a valid email address"
                      : null,
            ),
            const SizedBox(
              height: 32,
            ),
            ElevatedButton(
              onPressed: resetPassword,
              child: const Text("Reset password"),
            ),
          ],
        ),
      ),
    );
  }
}
