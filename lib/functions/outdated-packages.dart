import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:dart_lens/functions/commands.dart';
import 'package:dart_lens/models/outdated-packages/outdated-packages.dart';

/// Runs `flutter pub outdated --json` on [projectDirectoryPath]
/// and parses the output
Future<OutdatedPackages?> getOutdatedPackages(
  String projectDirectoryPath,
) async {
  final flutterPubOutdatedResult =
      await runFlutterPubOutdated(projectDirectoryPath);
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
    print(e);
    print(s);
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
