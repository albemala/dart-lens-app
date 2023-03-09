import 'package:freezed_annotation/freezed_annotation.dart';

part 'outdated-packages.freezed.dart';
part 'outdated-packages.g.dart';

@freezed
class OutdatedPackages with _$OutdatedPackages {
  const factory OutdatedPackages({
    required List<OutdatedPackage> packages,
  }) = _OutdatedPackages;

  factory OutdatedPackages.fromJson(Map<String, dynamic> json) =>
      _$OutdatedPackagesFromJson(json);
}

@freezed
class OutdatedPackage with _$OutdatedPackage {
  const factory OutdatedPackage({
    required String package,
    required bool isDiscontinued,
    required PackageResolution current,
    required PackageResolution upgradable,
    required PackageResolution resolvable,
    required PackageResolution latest,
  }) = _OutdatedPackage;

  factory OutdatedPackage.fromJson(Map<String, dynamic> json) =>
      _$OutdatedPackageFromJson(json);
}

@freezed
class PackageResolution with _$PackageResolution {
  const factory PackageResolution({
    required String version,
  }) = _PackageResolution;

  factory PackageResolution.fromJson(Map<String, dynamic> json) =>
      _$PackageResolutionFromJson(json);
}
