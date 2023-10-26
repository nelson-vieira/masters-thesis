// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (c) 2023 Nelson Vieira
//
// @author Nelson Vieira <2080511@student.uma.pt>
// @license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class CategoryHelper {
  static String categoryName(BuildContext context, String name) {
    switch (name) {
      case "Unique identification":
        return AppLocalizations.of(context)!.categoryUniqueIdentification;
      case "Environment":
        return AppLocalizations.of(context)!.categoryEnvironment;
      case "Biometrics":
        return AppLocalizations.of(context)!.categoryBiometrics;
      case "Location":
        return AppLocalizations.of(context)!.categoryLocation;
      case "Presence":
        return AppLocalizations.of(context)!.categoryPresence;
      case "Audio":
        return AppLocalizations.of(context)!.categoryAudio;
      case "Visual":
        return AppLocalizations.of(context)!.categoryVisual;
      default:
        return AppLocalizations.of(context)!.categoryNone;
    }
  }
}
