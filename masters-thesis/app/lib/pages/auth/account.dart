// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <2080511@student.uma.pt>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "package:flutter/material.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:iotprivacy/pages/auth/auth.dart";
import "package:iotprivacy/pages/auth/profile.dart";

class Account extends StatefulWidget {
  static const String route = "/account";

  const Account({
    Key? key,
  }) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              AppLocalizations.of(context)!.errorOccured,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17.0,
              ),
            ),
          );
        } else if (snapshot.hasData) {
          return const Profile();
        } else {
          return const Auth();
        }
      },
    );
  }
}
