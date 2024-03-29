// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <2080511@student.uma.pt>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "package:flutter/material.dart";
import "package:iotprivacy/pages/auth/login.dart";
import "package:iotprivacy/pages/auth/register.dart";

class Auth extends StatefulWidget {
  static const String route = "/auth";

  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool isLoginPage = true;

  @override
  Widget build(BuildContext context) => isLoginPage
      ? Login(onClickRegister: toggle)
      : Register(onClickLogIn: toggle);

  void toggle() => setState(() => isLoginPage = !isLoginPage);
}
