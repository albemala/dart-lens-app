import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pub_api_client/pub_api_client.dart';

part 'package.freezed.dart';

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

@freezed
class Package with _$Package {
  const factory Package({
    required DependencyType dependencyType,
    required PackageType type,

    /// The name of the package
    required String name,

    /// The version that is currently installed
    required String? installedVersion,

    /// The most recent version that can be installed
    required String? resolvableVersion,

    /// The most recent version that is available on pub.dev
    required PackageVersion? latestVersion,

    /// All versions that are available on pub.dev
    required List<PackageVersion>? availableVersions,

    /// The url to the pub.dev page of the package
    required String? url,

    /// The url to the changelog of the package
    required String? changelogUrl,

    /// The description of the package
    required String? description,
  }) = _Package;
}
