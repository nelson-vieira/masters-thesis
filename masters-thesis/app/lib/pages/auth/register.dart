// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <2080511@student.uma.pt>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "package:email_validator/email_validator.dart";
import "package:flutter/material.dart";
import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/gestures.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:iotprivacy/main.dart";
import "package:iotprivacy/models/user.dart";
import "package:iotprivacy/helpers/app.dart";

class Register extends StatefulWidget {
  static const String route = "/register";
  final VoidCallback onClickLogIn;

  const Register({
    Key? key,
    required this.onClickLogIn,
  }) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final formKey = GlobalKey<FormState>();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerPasswordConfirm = TextEditingController();

  @override
  void dispose() {
    controllerEmail.dispose();
    controllerPassword.dispose();
    controllerPasswordConfirm.dispose();

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

  showSnackBar(String? text) {
    if (text == null) return;

    SnackBar(
      content: Text(text),
      duration: const Duration(
        seconds: 5,
      ),
    );
  }

  Future createUser(UserDocument user) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      UserCredential result =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: controllerEmail.text.trim(),
        password: controllerPassword.text.trim(),
      );
      final docUser = FirebaseFirestore.instance.collection("users").doc();
      user.id = result.user!.uid;

      final json = user.toJson();
      await docUser.set(json);
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
          AppLocalizations.of(context)!.createAccount,
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
                  textInputAction: TextInputAction.next,
                  decoration: decoration(AppLocalizations.of(context)!.email),
                  style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? AppLocalizations.of(context)!.emailValidation
                          : null,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: controllerPassword,
                  textInputAction: TextInputAction.next,
                  decoration:
                      decoration(AppLocalizations.of(context)!.password),
                  obscureText: true,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (password) =>
                      password != null && password.length < 8
                          ? AppLocalizations.of(context)!.passwordValidation
                          : null,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: controllerPasswordConfirm,
                  textInputAction: TextInputAction.done,
                  decoration: decoration(
                      AppLocalizations.of(context)!.passwordConfirmation),
                  obscureText: true,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (password) {
                    if (password!.isEmpty ||
                        password != controllerPassword.text) {
                      return AppLocalizations.of(context)!.passwordValidation2;
                    }
                    return null;
                  },
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
                  onPressed: () {
                    final user = UserDocument(
                      email: controllerEmail.text.trim(),
                      role: "user",
                      createdAt: DateTime.now(),
                      updatedAt: DateTime.now(),
                      lastLogin: DateTime.now(),
                    );
                    createUser(user);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.signUp,
                    style: const TextStyle(fontSize: 16.0, color: Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: AppLocalizations.of(context)!.goToLogin,
                      style: const TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = widget.onClickLogIn,
                          text: AppLocalizations.of(context)!.signIn,
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
      ),
    );
  }
}
