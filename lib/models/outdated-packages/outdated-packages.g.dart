// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'outdated-packages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OutdatedPackages _$$_OutdatedPackagesFromJson(Map json) =>
    _$_OutdatedPackages(
      packages: (json['packages'] as List<dynamic>)
          .map((e) =>
              OutdatedPackage.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$$_OutdatedPackagesToJson(_$_OutdatedPackages instance) =>
    <String, dynamic>{
      'packages': instance.packages.map((e) => e.toJson()).toList(),
    };

_$_OutdatedPackage _$$_OutdatedPackageFromJson(Map json) => _$_OutdatedPackage(
      package: json['package'] as String,
      isDiscontinued: json['isDiscontinued'] as bool,
      current: PackageResolution.fromJson(
          Map<String, dynamic>.from(json['current'] as Map)),
      upgradable: PackageResolution.fromJson(
          Map<String, dynamic>.from(json['upgradable'] as Map)),
      resolvable: PackageResolution.fromJson(
          Map<String, dynamic>.from(json['resolvable'] as Map)),
      latest: PackageResolution.fromJson(
          Map<String, dynamic>.from(json['latest'] as Map)),
    );

Map<String, dynamic> _$$_OutdatedPackageToJson(_$_OutdatedPackage instance) =>
    <String, dynamic>{
      'package': instance.package,
      'isDiscontinued': instance.isDiscontinued,
      'current': instance.current.toJson(),
      'upgradable': instance.upgradable.toJson(),
      'resolvable': instance.resolvable.toJson(),
      'latest': instance.latest.toJson(),
    };

_$_PackageResolution _$$_PackageResolutionFromJson(Map json) =>
    _$_PackageResolution(
      version: json['version'] as String,
    );

Map<String, dynamic> _$$_PackageResolutionToJson(
        _$_PackageResolution instance) =>
    <String, dynamic>{
      'version': instance.version,
    };
