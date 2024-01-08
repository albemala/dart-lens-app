import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:dart_lens/commands.dart';
import 'package:dart_lens/project-packages/outdated-packages/outdated-packages.dart';
import 'package:flutter/foundation.dart';

/// Runs `flutter pub outdated --json` on [projectDirectoryPath]
/// and parses the output
Future<OutdatedPackages?> getOutdatedPackages({
  required String flutterBinaryPath,
  required String projectDirectoryPath,
}) async {
  final flutterPubOutdatedResult = await runFlutterPubOutdated(
    flutterBinaryPath: flutterBinaryPath,
    workingDirectory: projectDirectoryPath,
  );
  final flutterPubOutdatedJson = flutterPubOutdatedResult.stdout.toString();
  try {
    final flutterPubOutdatedMap = jsonDecode(flutterPubOutdatedJson) as Map;
    final outdatedPackages = OutdatedPackages.fromJson(
      Map<String, dynamic>.from(
        flutterPubOutdatedMap,
      ),
    );
    return outdatedPackages;
  } catch (e, s) {
    if (kDebugMode) print(e);
    if (kDebugMode) print(s);
    return null;
  }
}

String? findResolvableVersion(
  String packageName,
  OutdatedPackages outdatedPackages,
) {
  final outdatedPackage = outdatedPackages.packages.firstWhereOrNull(
    (package) => package.package == packageName,
  );
  if (outdatedPackage == null) return null;
  return outdatedPackage.resolvable?.version;
}
