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
import 'package:app/pages/auth/auth.dart';
import 'package:app/helpers/app.dart';
import 'package:app/pages/auth/profile.dart';
import 'package:app/pages/auth/forgot_password.dart';
import 'package:app/pages/auth/login.dart';
import 'package:app/pages/auth/register.dart';

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
        if (snapshot.hasData) {
          //   if (snapshot.data!.providerData.length == 1) {
          //     // logged in using email and password
          //     return snapshot.data.isEmailVerified
          //         ? MainPage()
          //         : VerifyEmailPage(user: snapshot.data);
          //   } else {
          // logged in using other providers
          return Profile();
          //   }
        } else {
          return Auth();
        }
      },
    );
  }
}
