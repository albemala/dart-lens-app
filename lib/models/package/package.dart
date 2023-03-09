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
    required String name,
    required String? installedVersion,
    required String? resolvableVersion,
    required PackageVersion? latestVersion,
    required List<PackageVersion>? availableVersions,
    required String? url,
    required String? changelogUrl,
    required String? description,
  }) = _Package;
}
