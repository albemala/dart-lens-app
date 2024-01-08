import 'package:flutter/foundation.dart';

enum PackageType {
  hosted,
  git,
  path,
  sdk,
}

enum DependencyType {
  dependency,
  devDependency,
}

@immutable
class Package {
  final DependencyType dependencyType;
  final PackageType type;

  /// The name of the package
  final String name;

  /// The version that is currently installed
  final String? installedVersion;

  /// The most recent version that can be installed
  final String? resolvableVersion;

  /// The most recent version that is available on pub.dev
  final String? latestVersion;

  /// All versions that are available on pub.dev
  final List<String>? availableVersions;

  /// The url to the pub.dev page of the package
  final String? url;

  /// The url to the changelog of the package
  final String? changelogUrl;

  /// The description of the package
  final String? description;

  const Package({
    required this.dependencyType,
    required this.type,
    required this.name,
    required this.installedVersion,
    required this.resolvableVersion,
    required this.latestVersion,
    required this.availableVersions,
    required this.url,
    required this.changelogUrl,
    required this.description,
  });
}
