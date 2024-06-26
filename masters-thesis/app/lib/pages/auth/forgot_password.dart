// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2024 Nelson Vieira
//
// @author Nelson Vieira <2080511@student.uma.pt>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:email_validator/email_validator.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:iotprivacy/main.dart";
import "package:iotprivacy/helpers/app.dart";

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
      Helper.showSnackBar(AppLocalizations.of(context)!.resetPassword);
      //   navigatorKey.currentState!.popUntil((route) => route.isFirst);
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Color.fromARGB(255, 255, 255, 255)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          AppLocalizations.of(context)!.resetPassword,
          style: const TextStyle(fontSize: 30),
        ),
        backgroundColor: const Color(0xFF334150),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 2.0, right: 4.0, left: 4.0, bottom: 4.0),
        child: Container(
          color: const Color.fromARGB(255, 16, 44, 53),
          child: Form(
            key: formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: <Widget>[
                TextFormField(
                  controller: controllerEmail,
                  decoration: decoration(AppLocalizations.of(context)!.email),
                  style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  textInputAction: TextInputAction.done,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? AppLocalizations.of(context)!.emailValidation
                          : null,
                ),
                const SizedBox(
                  height: 32,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 10, 118, 138),
                    padding: const EdgeInsets.only(
                        left: 0.0, top: 18.0, right: 0.0, bottom: 18.0),
                  ),
                  onPressed: resetPassword,
                  child: Text(
                    AppLocalizations.of(context)!.resetPassword,
                    style: const TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
