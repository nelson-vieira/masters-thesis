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
- Upgrade dependencies: [url_launcher](https://github.com/flutter/packages/tree/main/packages/url_launcher/url_launcher), [url_launcher_ios](https://github.com/flutter/packages/tree/main/packages/url_launcher/url_launcher_ios), [url_launcher_linux](https://github.com/flutter/packages/tree/main/packages/url_launcher/url_launcher_linux), [url_launcher_web](https://github.com/flutter/packages/tree/main/packages/url_launcher/url_launcher_web), [url_launcher_windows](https://github.com/flutter/packages/tree/main/packages/url_launcher/url_launcher_windows), [_flutterfire_internals](https://github.com/firebase/flutterfire/tree/master/packages/_flutterfire_internals), [cloud_firestore](https://github.com/firebase/flutterfire/tree/master/packages/cloud_firestore/cloud_firestore), [cloud_firestore_platform_interface](https://github.com/firebase/flutterfire/tree/master/packages/cloud_firestore/cloud_firestore_platform_interface), [cloud_firestore_web](https://github.com/firebase/flutterfire/tree/master/packages/cloud_firestore/cloud_firestore_web), [firebase_analytics](https://github.com/firebase/flutterfire/tree/master/packages/firebase_analytics/firebase_analytics), [firebase_analytics_platform_interface](https://github.com/firebase/flutterfire/tree/master/packages/firebase_analytics/firebase_analytics_platform_interface), [firebase_analytics_web](https://github.com/firebase/flutterfire/tree/master/packages/firebase_analytics/firebase_analytics_web), [firebase_auth](https://github.com/firebase/flutterfire/tree/master/packages/firebase_auth/firebase_auth), [firebase_auth_platform_interface](https://github.com/firebase/flutterfire/tree/master/packages/firebase_auth/firebase_auth_platform_interface), [firebase_auth_web](https://github.com/firebase/flutterfire/tree/master/packages/firebase_auth/firebase_auth_web), [firebase_core](https://github.com/firebase/flutterfire/tree/master/packages/firebase_core), [firebase_core_web](https://github.com/firebase/flutterfire/tree/master/packages/firebase_core/firebase_core_web), [firebase_performance](https://github.com/firebase/flutterfire/tree/master/packages/firebase_performance/firebase_performance), [firebase_performance_platform_interface](https://github.com/firebase/flutterfire/tree/master/packages/firebase_performance/firebase_performance_platform_interface), [firebase_performance_web](https://github.com/firebase/flutterfire/tree/master/packages/firebase_performance/firebase_performance_web), [plugin_platform_interface](https://github.com/flutter/packages/tree/main/packages/plugin_platform_interface), [collection](https://github.com/dart-lang/collection), [meta](https://github.com/dart-lang/sdk/tree/main/pkg/meta), [sqflite_common](https://github.com/tekartik/sqflite/tree/master/sqflite_common), [stack_trace](https://github.com/dart-lang/stack_trace), [stream_channel](https://github.com/dart-lang/stream_channel), [test_api](https://github.com/dart-lang/test/tree/master/pkgs/test_api), [web](https://github.com/dart-lang/web), [win32](https://github.com/dart-windows/win32), [provider](https://github.com/rrousselGit/provider), [camera](https://github.com/flutter/packages/tree/main/packages/camera/camera), [camera_android](https://github.com/flutter/packages/tree/main/packages/camera/camera_android), [camera_avfoundation](https://github.com/flutter/packages/tree/main/packages/camera/camera_avfoundation), [image_picker_android](https://github.com/flutter/packages/tree/main/packages/image_picker/image_picker_android), [image_picker_ios](https://github.com/flutter/packages/tree/main/packages/image_picker/image_picker_ios), [uuid](https://github.com/Daegalus/dart-uuid)

### Removed

- Removed unused code
- Removed dependencies: [quiver](https://github.com/google/quiver-dart)

## [0.33.0] - 2023-07-21

### Added

- Add device `Statistics` page
- Add [graphic](https://github.com/entronad/graphic) package

### Fixed

- Fix Dart linter warnings
- Fix RenderBox bug on devices page

### Changed

- Using StreamBuilder to get categories in real time from Firestore used on device's form
- Upgrade dependencies: [url_launcher_android](https://github.com/flutter/packages/tree/main/packages/url_launcher/url_launcher_android), [file_selector_windows](https://github.com/flutter/packages/tree/main/packages/file_selector/file_selector_windows), [file_selector_macos](https://github.com/flutter/packages/tree/main/packages/file_selector/file_selector_macos), [file_selector_linux](https://github.com/flutter/packages/tree/main/packages/file_selector/file_selector_linux), [cloud_firestore_web](https://github.com/firebase/flutterfire/tree/master/packages/cloud_firestore/cloud_firestore_web), [cloud_firestore_platform_interface](https://github.com/firebase/flutterfire/tree/master/packages/cloud_firestore/cloud_firestore_platform_interface), [cloud_firestore](https://github.com/firebase/flutterfire/tree/master/packages/cloud_firestore/cloud_firestore), [win32](https://github.com/dart-windows/win32), [font_awesome_flutter](https://github.com/fluttercommunity/font_awesome_flutter), [flutter_lints](https://github.com/flutter/packages/tree/main/packages/flutter_lints), [permission_handler_windows](https://github.com/Baseflow/flutter-permission-handler/tree/main/permission_handler_windows), [permission_handler_platform_interface](https://github.com/Baseflow/flutter-permission-handler/tree/main/permission_handler_platform_interface), [permission_handler_apple](https://github.com/Baseflow/flutter-permission-handler/tree/main/permission_handler_apple), [permission_handler_android](https://github.com/Baseflow/flutter-permission-handler/tree/main/permission_handler_android), [permission_handler](https://github.com/Baseflow/flutter-permission-handler/tree/main/permission_handler), [camera_android](https://github.com/flutter/packages/tree/main/packages/camera/camera_android), [flutter_cache_manager](https://github.com/Baseflow/flutter_cache_manager/tree/develop/flutter_cache_manager), [geolocator_android](https://github.com/Baseflow/flutter-geolocator/tree/main/geolocator_android), [url_launcher_web](https://github.com/flutter/packages/tree/main/packages/url_launcher/url_launcher_web), [url_launcher_windows](https://github.com/flutter/packages/tree/main/packages/url_launcher/url_launcher_windows), [url_launcher](https://github.com/flutter/packages/tree/main/packages/url_launcher/url_launcher), [xdg_directories](https://github.com/flutter/packages/tree/main/packages/xdg_directories), [url_launcher_macos](https://github.com/flutter/packages/tree/main/packages/url_launcher/url_launcher_macos), [path_provider_foundation](https://github.com/flutter/packages/tree/main/packages/path_provider/path_provider_foundation), [firebase_performance_web](https://github.com/firebase/flutterfire/tree/master/packages/firebase_performance/firebase_performance_web), [firebase_performance_platform_interface](https://github.com/firebase/flutterfire/tree/master/packages/firebase_performance/firebase_performance_platform_interface), [firebase_core](https://github.com/firebase/flutterfire/tree/master/packages/firebase_core), [firebase_auth_web](https://github.com/firebase/flutterfire/tree/master/packages/firebase_auth/firebase_auth_web), [firebase_auth_platform_interface](https://github.com/firebase/flutterfire/tree/master/packages/firebase_auth/firebase_auth_platform_interface), [firebase_auth](https://github.com/firebase/flutterfire/tree/master/packages/firebase_auth/firebase_auth), [firebase_analytics_web](https://github.com/firebase/flutterfire/tree/master/packages/firebase_analytics/firebase_analytics_web), [firebase_analytics_platform_interface](https://github.com/firebase/flutterfire/tree/master/packages/firebase_analytics/firebase_analytics_platform_interface), [firebase_analytics](https://github.com/firebase/flutterfire/tree/master/packages/firebase_analytics/firebase_analytics), [file_selector_macos](https://github.com/flutter/packages/tree/main/packages/file_selector/file_selector_macos), [file](https://github.com/google/file.dart/tree/master/packages/file), [image_picker_android](https://github.com/flutter/packages/tree/main/packages/image_picker/image_picker_android)
- Upgrade [Flutter SDK](https://docs.flutter.dev/tools/sdk)

### Removed

- Removed unused code

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
- Upgrade dependencies: [url_launcher_platform_interface](https://github.com/flutter/packages/tree/main/packages/url_launcher/url_launcher_platform_interface), [intl](https://github.com/dart-lang/i18n/tree/main/pkgs/intl), [win32](https://github.com/dart-windows/win32), [image_picker_android](https://github.com/flutter/packages/tree/main/packages/image_picker/image_picker_android) and [file_selector_platform_interface](https://github.com/flutter/packages/tree/main/packages/image_picker/image_picker_platform_interface)

### Removed

- App bar on homepage
- Removed unused imports
- Remove unused packages: [geocoding](https://github.com/baseflow/flutter-geocoding/tree/main/geocoding) and [location](https://github.com/Lyokone/flutterlocation)

## [0.31.1] - 2023-06-15

### Added

- Display device's category name instead of purpose on devices pages.

<!-- ### Fixed -->

<!-- ### Changed -->

<!-- ### Security -->

<!-- ### Deprecated -->

<!-- ### Removed -->
