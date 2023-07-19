import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'outdated-packages.g.dart';

@JsonSerializable()
@immutable
class OutdatedPackages extends Equatable {
  final List<OutdatedPackage> packages;

  const OutdatedPackages({
    required this.packages,
  });

  @override
  List<Object?> get props => [
        packages,
      ];

  factory OutdatedPackages.fromJson(Map<String, dynamic> json) =>
      _$OutdatedPackagesFromJson(json);

  Map<String, dynamic> toJson() => _$OutdatedPackagesToJson(this);
}

@JsonSerializable()
@immutable
class OutdatedPackage extends Equatable {
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

  @override
  List<Object?> get props => [
        package,
        isDiscontinued,
        current,
        upgradable,
        resolvable,
        latest,
      ];

  factory OutdatedPackage.fromJson(Map<String, dynamic> json) =>
      _$OutdatedPackageFromJson(json);

  Map<String, dynamic> toJson() => _$OutdatedPackageToJson(this);
}

@JsonSerializable()
@immutable
class PackageResolution extends Equatable {
  final String version;

  const PackageResolution({
    required this.version,
  });

  @override
  List<Object?> get props => [
        version,
      ];

  factory PackageResolution.fromJson(Map<String, dynamic> json) =>
      _$PackageResolutionFromJson(json);

  Map<String, dynamic> toJson() => _$PackageResolutionToJson(this);
}
