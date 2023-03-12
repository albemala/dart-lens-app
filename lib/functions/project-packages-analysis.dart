import 'dart:io';

import 'package:dart_lens/functions/outdated-packages.dart';
import 'package:dart_lens/models/outdated-packages/outdated-packages.dart';
import 'package:dart_lens/models/package/package.dart';
import 'package:path/path.dart' as path;
import 'package:pub_api_client/pub_api_client.dart';
import 'package:pubspec_parse/pubspec_parse.dart';

Future<List<Package>> getPackages(
  String projectDirectoryPath,
) async {
  print('Exploring packages at $projectDirectoryPath');

  final pubspecFile = File(path.join(projectDirectoryPath, 'pubspec.yaml'));
  if (!pubspecFile.existsSync()) {
    throw Exception('pubspec.yaml does not exist');
  }

  final pubspecFileContent = pubspecFile.readAsStringSync();
  final pubspec = Pubspec.parse(pubspecFileContent);

  final outdatedPackages = await runFlutterPubOutdated(projectDirectoryPath);
  print('Outdated packages: $outdatedPackages');
  if (outdatedPackages == null) return [];

  final packages = <Package>[];
  for (final dependency in pubspec.dependencies.entries) {
    final packageName = dependency.key;
    final packageInfo = dependency.value;
    final package = await _createPackage(
      packageName,
      packageInfo,
      DependencyType.dependency,
      outdatedPackages,
    );
    packages.add(package);
  }
  for (final devDependency in pubspec.devDependencies.entries) {
    final packageName = devDependency.key;
    final packageInfo = devDependency.value;
    final package = await _createPackage(
      packageName,
      packageInfo,
      DependencyType.devDependency,
      outdatedPackages,
    );
    packages.add(package);
  }
  for (final package in packages) {
    print('Package: $package');
  }
  return packages;
}

Future<Package> _createPackage(
  String packageName,
  Dependency dependency,
  DependencyType type,
  OutdatedPackages outdatedPackages,
) async {
  if (dependency is HostedDependency) {
    return _createHostedPackage(
      packageName,
      dependency,
      type,
      outdatedPackages,
    );
  } else if (dependency is GitDependency) {
    return _createGitPackage(
      packageName,
      dependency,
      type,
    );
  } else if (dependency is PathDependency) {
    return _createPathPackage(
      packageName,
      dependency,
      type,
    );
  } else if (dependency is SdkDependency) {
    return _createSdkPackage(
      packageName,
      dependency,
      type,
    );
  } else {
    throw Exception('Unknown dependency type');
  }
}

Future<Package> _createHostedPackage(
  String packageName,
  HostedDependency dependency,
  DependencyType type,
  OutdatedPackages outdatedPackages,
) async {
  final client = PubClient();
  final info = await client.packageInfo(packageName);
  final installedVersion = dependency.version.toString().replaceFirst('^', '');
  final resolvableVersion = findResolvableVersion(
    packageName,
    outdatedPackages,
  );
  return Package(
    type: PackageType.hosted,
    dependencyType: type,
    name: packageName,
    installedVersion: installedVersion,
    resolvableVersion: resolvableVersion ?? installedVersion,
    latestVersion: info.latest,
    availableVersions: info.versions.reversed.toList(),
    url: info.url,
    changelogUrl: info.changelogUrl,
    description: info.description,
  );
}

Future<Package> _createGitPackage(
  String packageName,
  GitDependency dependency,
  DependencyType type,
) async {
  return Package(
    type: PackageType.git,
    dependencyType: type,
    name: packageName,
    installedVersion: dependency.ref,
    resolvableVersion: null,
    latestVersion: null,
    availableVersions: null,
    url: null,
    changelogUrl: null,
    description: null,
  );
}

Future<Package> _createPathPackage(
  String packageName,
  PathDependency dependency,
  DependencyType type,
) async {
  return Package(
    type: PackageType.path,
    dependencyType: type,
    name: packageName,
    installedVersion: dependency.path,
    resolvableVersion: null,
    latestVersion: null,
    availableVersions: null,
    url: null,
    changelogUrl: null,
    description: null,
  );
}

Future<Package> _createSdkPackage(
  String packageName,
  SdkDependency dependency,
  DependencyType type,
) async {
  return Package(
    type: PackageType.sdk,
    dependencyType: type,
    name: packageName,
    installedVersion: dependency.sdk,
    resolvableVersion: null,
    latestVersion: null,
    availableVersions: null,
    url: null,
    changelogUrl: null,
    description: null,
  );
}
