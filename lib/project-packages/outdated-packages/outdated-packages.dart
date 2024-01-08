import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'outdated-packages.g.dart';

@JsonSerializable()
@immutable
class OutdatedPackages {
  final List<OutdatedPackage> packages;

  const OutdatedPackages({
    required this.packages,
  });

  factory OutdatedPackages.fromJson(Map<String, dynamic> json) =>
      _$OutdatedPackagesFromJson(json);

  Map<String, dynamic> toJson() => _$OutdatedPackagesToJson(this);
}

@JsonSerializable()
@immutable
class OutdatedPackage {
  final String package;
  final bool isDiscontinued;
  final PackageResolution? current;
  final PackageResolution? upgradable;
  final PackageResolution? resolvable;
  final PackageResolution? latest;

  const OutdatedPackage({
    required this.package,
    required this.isDiscontinued,
    required this.current,
    required this.upgradable,
    required this.resolvable,
    required this.latest,
  });

  factory OutdatedPackage.fromJson(Map<String, dynamic> json) =>
      _$OutdatedPackageFromJson(json);

  Map<String, dynamic> toJson() => _$OutdatedPackageToJson(this);
}

@JsonSerializable()
@immutable
class PackageResolution {
  final String version;

  const PackageResolution({
    required this.version,
  });

  factory PackageResolution.fromJson(Map<String, dynamic> json) =>
      _$PackageResolutionFromJson(json);

  Map<String, dynamic> toJson() => _$PackageResolutionToJson(this);
}
