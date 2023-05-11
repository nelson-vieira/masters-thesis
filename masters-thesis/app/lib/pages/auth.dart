// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <nelson0.vieira@gmail.com>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "package:flutter/material.dart";
import 'package:app/pages/login.dart';
import 'package:app/pages/register.dart';

class Auth extends StatefulWidget {
  static const String route = "/auth";

  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool isLogged = true;

  @override
  Widget build(BuildContext context) => isLogged
      ? Login(onClickRegister: toggle)
      : Register(onClickLogIn: toggle);

  void toggle() => setState(() => isLogged = !isLogged);
}
