import 'dart:io';

import 'package:dart_lens/functions/commands.dart';
import 'package:path/path.dart' as path;

Future<void> applyPackageVersionChanges(
  String projectDirectoryPath,
  Map<String, String> packageVersionsToChange,
) async {
  final pubspecFile = File(path.join(projectDirectoryPath, 'pubspec.yaml'));
  if (!pubspecFile.existsSync()) {
    throw Exception('pubspec.yaml does not exist');
  }

  var pubspecFileContent = pubspecFile.readAsStringSync();
  // update the pubspec file based on the selected versions
  packageVersionsToChange.forEach((packageName, newPackageVersion) {
    // replace current package version with new package version
    // for example: `package_name: ^1.0.0`
    // new version: `package_name: ^1.3.7`
    final oldVersionPattern = '${RegExp.escape(packageName)}:.*';
    final newVersionPattern = '$packageName: ^$newPackageVersion';
    pubspecFileContent = pubspecFileContent.replaceFirst(
      RegExp(oldVersionPattern),
      newVersionPattern,
    );
  });
  // write updated pubspec file
  pubspecFile.writeAsStringSync(pubspecFileContent);

  // run `flutter pub get` to update the lock file
  await runFlutterPubGet(projectDirectoryPath);
}
