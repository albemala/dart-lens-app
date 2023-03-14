// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'outdated-packages.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OutdatedPackages _$OutdatedPackagesFromJson(Map<String, dynamic> json) {
  return _OutdatedPackages.fromJson(json);
}

/// @nodoc
mixin _$OutdatedPackages {
  List<OutdatedPackage> get packages => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OutdatedPackagesCopyWith<OutdatedPackages> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutdatedPackagesCopyWith<$Res> {
  factory $OutdatedPackagesCopyWith(
          OutdatedPackages value, $Res Function(OutdatedPackages) then) =
      _$OutdatedPackagesCopyWithImpl<$Res, OutdatedPackages>;
  @useResult
  $Res call({List<OutdatedPackage> packages});
}

/// @nodoc
class _$OutdatedPackagesCopyWithImpl<$Res, $Val extends OutdatedPackages>
    implements $OutdatedPackagesCopyWith<$Res> {
  _$OutdatedPackagesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? packages = null,
  }) {
    return _then(_value.copyWith(
      packages: null == packages
          ? _value.packages
          : packages // ignore: cast_nullable_to_non_nullable
              as List<OutdatedPackage>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OutdatedPackagesCopyWith<$Res>
    implements $OutdatedPackagesCopyWith<$Res> {
  factory _$$_OutdatedPackagesCopyWith(
          _$_OutdatedPackages value, $Res Function(_$_OutdatedPackages) then) =
      __$$_OutdatedPackagesCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<OutdatedPackage> packages});
}

/// @nodoc
class __$$_OutdatedPackagesCopyWithImpl<$Res>
    extends _$OutdatedPackagesCopyWithImpl<$Res, _$_OutdatedPackages>
    implements _$$_OutdatedPackagesCopyWith<$Res> {
  __$$_OutdatedPackagesCopyWithImpl(
      _$_OutdatedPackages _value, $Res Function(_$_OutdatedPackages) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? packages = null,
  }) {
    return _then(_$_OutdatedPackages(
      packages: null == packages
          ? _value._packages
          : packages // ignore: cast_nullable_to_non_nullable
              as List<OutdatedPackage>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_OutdatedPackages implements _OutdatedPackages {
  const _$_OutdatedPackages({required final List<OutdatedPackage> packages})
      : _packages = packages;

  factory _$_OutdatedPackages.fromJson(Map<String, dynamic> json) =>
      _$$_OutdatedPackagesFromJson(json);

  final List<OutdatedPackage> _packages;
  @override
  List<OutdatedPackage> get packages {
    if (_packages is EqualUnmodifiableListView) return _packages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_packages);
  }

  @override
  String toString() {
    return 'OutdatedPackages(packages: $packages)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OutdatedPackages &&
            const DeepCollectionEquality().equals(other._packages, _packages));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_packages));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OutdatedPackagesCopyWith<_$_OutdatedPackages> get copyWith =>
      __$$_OutdatedPackagesCopyWithImpl<_$_OutdatedPackages>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OutdatedPackagesToJson(
      this,
    );
  }
}

abstract class _OutdatedPackages implements OutdatedPackages {
  const factory _OutdatedPackages(
      {required final List<OutdatedPackage> packages}) = _$_OutdatedPackages;

  factory _OutdatedPackages.fromJson(Map<String, dynamic> json) =
      _$_OutdatedPackages.fromJson;

  @override
  List<OutdatedPackage> get packages;
  @override
  @JsonKey(ignore: true)
  _$$_OutdatedPackagesCopyWith<_$_OutdatedPackages> get copyWith =>
      throw _privateConstructorUsedError;
}

OutdatedPackage _$OutdatedPackageFromJson(Map<String, dynamic> json) {
  return _OutdatedPackage.fromJson(json);
}

/// @nodoc
mixin _$OutdatedPackage {
  String get package => throw _privateConstructorUsedError;
  bool get isDiscontinued => throw _privateConstructorUsedError;
  PackageResolution? get current => throw _privateConstructorUsedError;
  PackageResolution? get upgradable => throw _privateConstructorUsedError;
  PackageResolution? get resolvable => throw _privateConstructorUsedError;
  PackageResolution? get latest => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OutdatedPackageCopyWith<OutdatedPackage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OutdatedPackageCopyWith<$Res> {
  factory $OutdatedPackageCopyWith(
          OutdatedPackage value, $Res Function(OutdatedPackage) then) =
      _$OutdatedPackageCopyWithImpl<$Res, OutdatedPackage>;
  @useResult
  $Res call(
      {String package,
      bool isDiscontinued,
      PackageResolution? current,
      PackageResolution? upgradable,
      PackageResolution? resolvable,
      PackageResolution? latest});

  $PackageResolutionCopyWith<$Res>? get current;
  $PackageResolutionCopyWith<$Res>? get upgradable;
  $PackageResolutionCopyWith<$Res>? get resolvable;
  $PackageResolutionCopyWith<$Res>? get latest;
}

/// @nodoc
class _$OutdatedPackageCopyWithImpl<$Res, $Val extends OutdatedPackage>
    implements $OutdatedPackageCopyWith<$Res> {
  _$OutdatedPackageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? package = null,
    Object? isDiscontinued = null,
    Object? current = freezed,
    Object? upgradable = freezed,
    Object? resolvable = freezed,
    Object? latest = freezed,
  }) {
    return _then(_value.copyWith(
      package: null == package
          ? _value.package
          : package // ignore: cast_nullable_to_non_nullable
              as String,
      isDiscontinued: null == isDiscontinued
          ? _value.isDiscontinued
          : isDiscontinued // ignore: cast_nullable_to_non_nullable
              as bool,
      current: freezed == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as PackageResolution?,
      upgradable: freezed == upgradable
          ? _value.upgradable
          : upgradable // ignore: cast_nullable_to_non_nullable
              as PackageResolution?,
      resolvable: freezed == resolvable
          ? _value.resolvable
          : resolvable // ignore: cast_nullable_to_non_nullable
              as PackageResolution?,
      latest: freezed == latest
          ? _value.latest
          : latest // ignore: cast_nullable_to_non_nullable
              as PackageResolution?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PackageResolutionCopyWith<$Res>? get current {
    if (_value.current == null) {
      return null;
    }

    return $PackageResolutionCopyWith<$Res>(_value.current!, (value) {
      return _then(_value.copyWith(current: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PackageResolutionCopyWith<$Res>? get upgradable {
    if (_value.upgradable == null) {
      return null;
    }

    return $PackageResolutionCopyWith<$Res>(_value.upgradable!, (value) {
      return _then(_value.copyWith(upgradable: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PackageResolutionCopyWith<$Res>? get resolvable {
    if (_value.resolvable == null) {
      return null;
    }

    return $PackageResolutionCopyWith<$Res>(_value.resolvable!, (value) {
      return _then(_value.copyWith(resolvable: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PackageResolutionCopyWith<$Res>? get latest {
    if (_value.latest == null) {
      return null;
    }

    return $PackageResolutionCopyWith<$Res>(_value.latest!, (value) {
      return _then(_value.copyWith(latest: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_OutdatedPackageCopyWith<$Res>
    implements $OutdatedPackageCopyWith<$Res> {
  factory _$$_OutdatedPackageCopyWith(
          _$_OutdatedPackage value, $Res Function(_$_OutdatedPackage) then) =
      __$$_OutdatedPackageCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String package,
      bool isDiscontinued,
      PackageResolution? current,
      PackageResolution? upgradable,
      PackageResolution? resolvable,
      PackageResolution? latest});

  @override
  $PackageResolutionCopyWith<$Res>? get current;
  @override
  $PackageResolutionCopyWith<$Res>? get upgradable;
  @override
  $PackageResolutionCopyWith<$Res>? get resolvable;
  @override
  $PackageResolutionCopyWith<$Res>? get latest;
}

/// @nodoc
class __$$_OutdatedPackageCopyWithImpl<$Res>
    extends _$OutdatedPackageCopyWithImpl<$Res, _$_OutdatedPackage>
    implements _$$_OutdatedPackageCopyWith<$Res> {
  __$$_OutdatedPackageCopyWithImpl(
      _$_OutdatedPackage _value, $Res Function(_$_OutdatedPackage) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? package = null,
    Object? isDiscontinued = null,
    Object? current = freezed,
    Object? upgradable = freezed,
    Object? resolvable = freezed,
    Object? latest = freezed,
  }) {
    return _then(_$_OutdatedPackage(
      package: null == package
          ? _value.package
          : package // ignore: cast_nullable_to_non_nullable
              as String,
      isDiscontinued: null == isDiscontinued
          ? _value.isDiscontinued
          : isDiscontinued // ignore: cast_nullable_to_non_nullable
              as bool,
      current: freezed == current
          ? _value.current
          : current // ignore: cast_nullable_to_non_nullable
              as PackageResolution?,
      upgradable: freezed == upgradable
          ? _value.upgradable
          : upgradable // ignore: cast_nullable_to_non_nullable
              as PackageResolution?,
      resolvable: freezed == resolvable
          ? _value.resolvable
          : resolvable // ignore: cast_nullable_to_non_nullable
              as PackageResolution?,
      latest: freezed == latest
          ? _value.latest
          : latest // ignore: cast_nullable_to_non_nullable
              as PackageResolution?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_OutdatedPackage implements _OutdatedPackage {
  const _$_OutdatedPackage(
      {required this.package,
      required this.isDiscontinued,
      required this.current,
      required this.upgradable,
      required this.resolvable,
      required this.latest});

  factory _$_OutdatedPackage.fromJson(Map<String, dynamic> json) =>
      _$$_OutdatedPackageFromJson(json);

  @override
  final String package;
  @override
  final bool isDiscontinued;
  @override
  final PackageResolution? current;
  @override
  final PackageResolution? upgradable;
  @override
  final PackageResolution? resolvable;
  @override
  final PackageResolution? latest;

  @override
  String toString() {
    return 'OutdatedPackage(package: $package, isDiscontinued: $isDiscontinued, current: $current, upgradable: $upgradable, resolvable: $resolvable, latest: $latest)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OutdatedPackage &&
            (identical(other.package, package) || other.package == package) &&
            (identical(other.isDiscontinued, isDiscontinued) ||
                other.isDiscontinued == isDiscontinued) &&
            (identical(other.current, current) || other.current == current) &&
            (identical(other.upgradable, upgradable) ||
                other.upgradable == upgradable) &&
            (identical(other.resolvable, resolvable) ||
                other.resolvable == resolvable) &&
            (identical(other.latest, latest) || other.latest == latest));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, package, isDiscontinued, current,
      upgradable, resolvable, latest);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OutdatedPackageCopyWith<_$_OutdatedPackage> get copyWith =>
      __$$_OutdatedPackageCopyWithImpl<_$_OutdatedPackage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OutdatedPackageToJson(
      this,
    );
  }
}

abstract class _OutdatedPackage implements OutdatedPackage {
  const factory _OutdatedPackage(
      {required final String package,
      required final bool isDiscontinued,
      required final PackageResolution? current,
      required final PackageResolution? upgradable,
      required final PackageResolution? resolvable,
      required final PackageResolution? latest}) = _$_OutdatedPackage;

  factory _OutdatedPackage.fromJson(Map<String, dynamic> json) =
      _$_OutdatedPackage.fromJson;

  @override
  String get package;
  @override
  bool get isDiscontinued;
  @override
  PackageResolution? get current;
  @override
  PackageResolution? get upgradable;
  @override
  PackageResolution? get resolvable;
  @override
  PackageResolution? get latest;
  @override
  @JsonKey(ignore: true)
  _$$_OutdatedPackageCopyWith<_$_OutdatedPackage> get copyWith =>
      throw _privateConstructorUsedError;
}

PackageResolution _$PackageResolutionFromJson(Map<String, dynamic> json) {
  return _PackageResolution.fromJson(json);
}

/// @nodoc
mixin _$PackageResolution {
  String get version => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PackageResolutionCopyWith<PackageResolution> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PackageResolutionCopyWith<$Res> {
  factory $PackageResolutionCopyWith(
          PackageResolution value, $Res Function(PackageResolution) then) =
      _$PackageResolutionCopyWithImpl<$Res, PackageResolution>;
  @useResult
  $Res call({String version});
}

/// @nodoc
class _$PackageResolutionCopyWithImpl<$Res, $Val extends PackageResolution>
    implements $PackageResolutionCopyWith<$Res> {
  _$PackageResolutionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = null,
  }) {
    return _then(_value.copyWith(
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PackageResolutionCopyWith<$Res>
    implements $PackageResolutionCopyWith<$Res> {
  factory _$$_PackageResolutionCopyWith(_$_PackageResolution value,
          $Res Function(_$_PackageResolution) then) =
      __$$_PackageResolutionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String version});
}

/// @nodoc
class __$$_PackageResolutionCopyWithImpl<$Res>
    extends _$PackageResolutionCopyWithImpl<$Res, _$_PackageResolution>
    implements _$$_PackageResolutionCopyWith<$Res> {
  __$$_PackageResolutionCopyWithImpl(
      _$_PackageResolution _value, $Res Function(_$_PackageResolution) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = null,
  }) {
    return _then(_$_PackageResolution(
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PackageResolution implements _PackageResolution {
  const _$_PackageResolution({required this.version});

  factory _$_PackageResolution.fromJson(Map<String, dynamic> json) =>
      _$$_PackageResolutionFromJson(json);

  @override
  final String version;

  @override
  String toString() {
    return 'PackageResolution(version: $version)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PackageResolution &&
            (identical(other.version, version) || other.version == version));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, version);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PackageResolutionCopyWith<_$_PackageResolution> get copyWith =>
      __$$_PackageResolutionCopyWithImpl<_$_PackageResolution>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PackageResolutionToJson(
      this,
    );
  }
}

abstract class _PackageResolution implements PackageResolution {
  const factory _PackageResolution({required final String version}) =
      _$_PackageResolution;

  factory _PackageResolution.fromJson(Map<String, dynamic> json) =
      _$_PackageResolution.fromJson;

  @override
  String get version;
  @override
  @JsonKey(ignore: true)
  _$$_PackageResolutionCopyWith<_$_PackageResolution> get copyWith =>
      throw _privateConstructorUsedError;
}
