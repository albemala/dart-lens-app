import 'dart:io';

import 'package:collection/collection.dart';
import 'package:dart_lens/models/package/package.dart';
import 'package:path/path.dart' as path;

Future<void> applyPackageVersionChanges(
  String projectDirectoryPath,
  List<Package> packages,
  Map<String, String> packageVersionsToChange,
) async {
  final pubspecFile = File(path.join(projectDirectoryPath, 'pubspec.yaml'));
  if (!pubspecFile.existsSync()) {
    throw Exception('pubspec.yaml does not exist');
  }

  var pubspecFileContent = pubspecFile.readAsStringSync();
  // update the pubspec file based on the selected versions
  packageVersionsToChange.forEach((packageName, newPackageVersion) {
    final currentPackageVersion = packages
        .firstWhereOrNull((package) => package.name == packageName)
        ?.installedVersion;
    if (currentPackageVersion == null) return;
    // create regex to find package in pubspec file
    final matchPackageRegex = RegExp(
      '(${RegExp.escape(packageName)}:\\s*[\\^]*)(${RegExp.escape(currentPackageVersion)})',
    );
    // find package in pubspec file
    final match = matchPackageRegex.firstMatch(pubspecFileContent);
    final packageMatch = match?.group(0);
    final packageNameMatch = match?.group(1);
    if (packageMatch == null || packageNameMatch == null) return;
    // replace version
    pubspecFileContent = pubspecFileContent.replaceFirst(
      packageMatch,
      '$packageNameMatch$newPackageVersion',
    );
  });
  // write updated pubspec file
  pubspecFile.writeAsStringSync(pubspecFileContent);

  // run `flutter pub get` to update the lock file
  await runFlutterPubGet(projectDirectoryPath);
}

Future<void> runFlutterPubGet(String directoryPath) async {
  final flutterPubGetProcess = await Process.run(
    'flutter',
    ['pub', 'get'],
    workingDirectory: directoryPath,
  );
  print('flutter pub get output: ${flutterPubGetProcess.stdout}');
  print('flutter pub get error: ${flutterPubGetProcess.stderr}');
}
