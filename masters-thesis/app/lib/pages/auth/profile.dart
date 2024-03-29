// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <2080511@student.uma.pt>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:iotprivacy/main.dart";

class Profile extends StatefulWidget {
  static const String route = "/account";

  const Profile({
    Key? key,
  }) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final account = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.account,
          style: const TextStyle(fontSize: 30),
        ),
        backgroundColor: const Color(0xFF334150),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 2.0, right: 4.0, left: 4.0, bottom: 4.0),
        child: Container(
          color: const Color.fromARGB(255, 16, 44, 53),
          child: Center(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              children: <Widget>[
                Text(
                  AppLocalizations.of(context)!.signedInAs,
                  style: const TextStyle(fontSize: 16.0, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  account.email!,
                  style: const TextStyle(fontSize: 16.0, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 10, 118, 138),
                    padding: const EdgeInsets.only(
                        left: 0.0, top: 18.0, right: 0.0, bottom: 18.0),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                    FirebaseAuth.instance.signOut();
                    navigatorKey.currentState!
                        .popUntil((route) => route.isFirst);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.signOut,
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
