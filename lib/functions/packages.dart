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

  // store pubspec.yaml file content, to restore in case of error
  final pubspecFileContent = pubspecFile.readAsStringSync();

  final updatedPubspecFileContent = _updatePubspecFileContent(
    pubspecFileContent,
    packageVersionsToChange,
  );
  // write updated pubspec file
  pubspecFile.writeAsStringSync(updatedPubspecFileContent);

  // run `flutter pub get` to update the lock file
  final processResult = await runFlutterPubGet(projectDirectoryPath);

  // in case of error, restore pubspec.yaml file content and throw the error
  if (processResult.stderr.toString().isNotEmpty) {
    pubspecFile.writeAsStringSync(pubspecFileContent);
    throw Exception(processResult.stderr);
  }
}

String _updatePubspecFileContent(
  String pubspecFileContent,
  Map<String, String> packageVersionsToChange,
) {
  // update the pubspec file based on the selected versions
  return packageVersionsToChange.entries.fold(
    pubspecFileContent,
    (updatedContent, entry) {
      final packageName = entry.key;
      final newPackageVersion = entry.value;
      // replace current package version with new package version
      // for example: `package_name: ^1.0.0`
      // new version: `package_name: ^1.3.7`
      final oldVersionPattern = '${RegExp.escape(packageName)}:.*';
      final newVersionPattern = '$packageName: ^$newPackageVersion';
      return updatedContent.replaceFirst(
        RegExp(oldVersionPattern),
        newVersionPattern,
      );
    },
  );
}
