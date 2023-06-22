<!---
SPDX-License-Identifier: AGPL-3.0-or-later

Copyright (c) 2023 Nelson Vieira

@author Nelson Vieira <2080511@student.uma.pt>
@license AGPL-3.0 <https://www.gnu.org/licenses/agpl-3.0.txt>
--->
# Changelog

All notable changes to this application will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this application adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Verify e-mail address before sign-in.
- Light mode.

### Changed

- Recalibrate dark mode colors.

## [0.32.0] - 2023-06-22

### Added

- Translate all text to portuguese using [flutter_localizations](https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html) package
- Add new icons to bottom navigation bar that change if page is selected or not, label is now always shown
- Created category helper class for additional global methods

### Fixed

- Missing owner field on update device form
- General improvements to codebase like removing commented code

### Changed

- `Encyclopedia` route is now called `(More) Information`
- Upgrade dependencies: [url_launcher_platform_interface](https://github.com/flutter/packages/tree/main/packages/url_launcher/url_launcher_platform_interface), [intl](https://pub.dev/packages/intl), [win32](https://pub.dev/packages/win32), [image_picker_android](https://pub.dev/packages/image_picker_android) and [file_selector_platform_interface](https://github.com/flutter/packages/tree/main/packages/image_picker/image_picker_platform_interface)

### Removed

- App bar on homepage
- Removed unused imports
- Remove unused packages: [geocoding](https://pub.dev/packages/geocoding) and [location](https://pub.dev/packages/location)

## [0.31.1] - 2023-06-15

### Added

- Display device's category name instead of purpose on devices pages.

<!-- ### Fixed -->

<!-- ### Changed -->

<!-- ### Security -->

<!-- ### Deprecated -->

<!-- ### Removed -->
