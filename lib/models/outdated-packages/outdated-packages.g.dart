// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outdated-packages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutdatedPackages _$OutdatedPackagesFromJson(Map json) => OutdatedPackages(
      packages: (json['packages'] as List<dynamic>)
          .map((e) =>
              OutdatedPackage.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$OutdatedPackagesToJson(OutdatedPackages instance) =>
    <String, dynamic>{
      'packages': instance.packages.map((e) => e.toJson()).toList(),
    };

OutdatedPackage _$OutdatedPackageFromJson(Map json) => OutdatedPackage(
      package: json['package'] as String,
      isDiscontinued: json['isDiscontinued'] as bool,
      current: json['current'] == null
          ? null
          : PackageResolution.fromJson(
              Map<String, dynamic>.from(json['current'] as Map)),
      upgradable: json['upgradable'] == null
          ? null
          : PackageResolution.fromJson(
              Map<String, dynamic>.from(json['upgradable'] as Map)),
      resolvable: json['resolvable'] == null
          ? null
          : PackageResolution.fromJson(
              Map<String, dynamic>.from(json['resolvable'] as Map)),
      latest: json['latest'] == null
          ? null
          : PackageResolution.fromJson(
              Map<String, dynamic>.from(json['latest'] as Map)),
    );

Map<String, dynamic> _$OutdatedPackageToJson(OutdatedPackage instance) =>
    <String, dynamic>{
      'package': instance.package,
      'isDiscontinued': instance.isDiscontinued,
      'current': instance.current?.toJson(),
      'upgradable': instance.upgradable?.toJson(),
      'resolvable': instance.resolvable?.toJson(),
      'latest': instance.latest?.toJson(),
    };

PackageResolution _$PackageResolutionFromJson(Map json) => PackageResolution(
      version: json['version'] as String,
    );

Map<String, dynamic> _$PackageResolutionToJson(PackageResolution instance) =>
    <String, dynamic>{
      'version': instance.version,
    };
