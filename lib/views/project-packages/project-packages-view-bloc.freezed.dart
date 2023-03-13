// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project-packages-view-bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ProjectPackagesViewModel {
  List<PackageViewModel> get dependencies => throw _privateConstructorUsedError;
  List<PackageViewModel> get devDependencies =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProjectPackagesViewModelCopyWith<ProjectPackagesViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectPackagesViewModelCopyWith<$Res> {
  factory $ProjectPackagesViewModelCopyWith(ProjectPackagesViewModel value,
          $Res Function(ProjectPackagesViewModel) then) =
      _$ProjectPackagesViewModelCopyWithImpl<$Res, ProjectPackagesViewModel>;
  @useResult
  $Res call(
      {List<PackageViewModel> dependencies,
      List<PackageViewModel> devDependencies});
}

/// @nodoc
class _$ProjectPackagesViewModelCopyWithImpl<$Res,
        $Val extends ProjectPackagesViewModel>
    implements $ProjectPackagesViewModelCopyWith<$Res> {
  _$ProjectPackagesViewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dependencies = null,
    Object? devDependencies = null,
  }) {
    return _then(_value.copyWith(
      dependencies: null == dependencies
          ? _value.dependencies
          : dependencies // ignore: cast_nullable_to_non_nullable
              as List<PackageViewModel>,
      devDependencies: null == devDependencies
          ? _value.devDependencies
          : devDependencies // ignore: cast_nullable_to_non_nullable
              as List<PackageViewModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProjectPackagesViewModelCopyWith<$Res>
    implements $ProjectPackagesViewModelCopyWith<$Res> {
  factory _$$_ProjectPackagesViewModelCopyWith(
          _$_ProjectPackagesViewModel value,
          $Res Function(_$_ProjectPackagesViewModel) then) =
      __$$_ProjectPackagesViewModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<PackageViewModel> dependencies,
      List<PackageViewModel> devDependencies});
}

/// @nodoc
class __$$_ProjectPackagesViewModelCopyWithImpl<$Res>
    extends _$ProjectPackagesViewModelCopyWithImpl<$Res,
        _$_ProjectPackagesViewModel>
    implements _$$_ProjectPackagesViewModelCopyWith<$Res> {
  __$$_ProjectPackagesViewModelCopyWithImpl(_$_ProjectPackagesViewModel _value,
      $Res Function(_$_ProjectPackagesViewModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dependencies = null,
    Object? devDependencies = null,
  }) {
    return _then(_$_ProjectPackagesViewModel(
      dependencies: null == dependencies
          ? _value._dependencies
          : dependencies // ignore: cast_nullable_to_non_nullable
              as List<PackageViewModel>,
      devDependencies: null == devDependencies
          ? _value._devDependencies
          : devDependencies // ignore: cast_nullable_to_non_nullable
              as List<PackageViewModel>,
    ));
  }
}

/// @nodoc

class _$_ProjectPackagesViewModel extends _ProjectPackagesViewModel {
  const _$_ProjectPackagesViewModel(
      {required final List<PackageViewModel> dependencies,
      required final List<PackageViewModel> devDependencies})
      : _dependencies = dependencies,
        _devDependencies = devDependencies,
        super._();

  final List<PackageViewModel> _dependencies;
  @override
  List<PackageViewModel> get dependencies {
    if (_dependencies is EqualUnmodifiableListView) return _dependencies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dependencies);
  }

  final List<PackageViewModel> _devDependencies;
  @override
  List<PackageViewModel> get devDependencies {
    if (_devDependencies is EqualUnmodifiableListView) return _devDependencies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_devDependencies);
  }

  @override
  String toString() {
    return 'ProjectPackagesViewModel(dependencies: $dependencies, devDependencies: $devDependencies)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProjectPackagesViewModel &&
            const DeepCollectionEquality()
                .equals(other._dependencies, _dependencies) &&
            const DeepCollectionEquality()
                .equals(other._devDependencies, _devDependencies));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_dependencies),
      const DeepCollectionEquality().hash(_devDependencies));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProjectPackagesViewModelCopyWith<_$_ProjectPackagesViewModel>
      get copyWith => __$$_ProjectPackagesViewModelCopyWithImpl<
          _$_ProjectPackagesViewModel>(this, _$identity);
}

abstract class _ProjectPackagesViewModel extends ProjectPackagesViewModel {
  const factory _ProjectPackagesViewModel(
          {required final List<PackageViewModel> dependencies,
          required final List<PackageViewModel> devDependencies}) =
      _$_ProjectPackagesViewModel;
  const _ProjectPackagesViewModel._() : super._();

  @override
  List<PackageViewModel> get dependencies;
  @override
  List<PackageViewModel> get devDependencies;
  @override
  @JsonKey(ignore: true)
  _$$_ProjectPackagesViewModelCopyWith<_$_ProjectPackagesViewModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PackageViewModel {
  String get name => throw _privateConstructorUsedError;
  String? get installedVersion => throw _privateConstructorUsedError;
  String? get installableVersion =>
      throw _privateConstructorUsedError; // required String? resolvableVersion,
// required PackageVersion? latestVersion,
  List<PackageVersionViewModel>? get availableVersions =>
      throw _privateConstructorUsedError;
  bool? get isLatestVersionInstalled => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String? get changelogUrl => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PackageViewModelCopyWith<PackageViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PackageViewModelCopyWith<$Res> {
  factory $PackageViewModelCopyWith(
          PackageViewModel value, $Res Function(PackageViewModel) then) =
      _$PackageViewModelCopyWithImpl<$Res, PackageViewModel>;
  @useResult
  $Res call(
      {String name,
      String? installedVersion,
      String? installableVersion,
      List<PackageVersionViewModel>? availableVersions,
      bool? isLatestVersionInstalled,
      String? url,
      String? changelogUrl,
      String? description});
}

/// @nodoc
class _$PackageViewModelCopyWithImpl<$Res, $Val extends PackageViewModel>
    implements $PackageViewModelCopyWith<$Res> {
  _$PackageViewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? installedVersion = freezed,
    Object? installableVersion = freezed,
    Object? availableVersions = freezed,
    Object? isLatestVersionInstalled = freezed,
    Object? url = freezed,
    Object? changelogUrl = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      installedVersion: freezed == installedVersion
          ? _value.installedVersion
          : installedVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      installableVersion: freezed == installableVersion
          ? _value.installableVersion
          : installableVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      availableVersions: freezed == availableVersions
          ? _value.availableVersions
          : availableVersions // ignore: cast_nullable_to_non_nullable
              as List<PackageVersionViewModel>?,
      isLatestVersionInstalled: freezed == isLatestVersionInstalled
          ? _value.isLatestVersionInstalled
          : isLatestVersionInstalled // ignore: cast_nullable_to_non_nullable
              as bool?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      changelogUrl: freezed == changelogUrl
          ? _value.changelogUrl
          : changelogUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PackageViewModelCopyWith<$Res>
    implements $PackageViewModelCopyWith<$Res> {
  factory _$$_PackageViewModelCopyWith(
          _$_PackageViewModel value, $Res Function(_$_PackageViewModel) then) =
      __$$_PackageViewModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String? installedVersion,
      String? installableVersion,
      List<PackageVersionViewModel>? availableVersions,
      bool? isLatestVersionInstalled,
      String? url,
      String? changelogUrl,
      String? description});
}

/// @nodoc
class __$$_PackageViewModelCopyWithImpl<$Res>
    extends _$PackageViewModelCopyWithImpl<$Res, _$_PackageViewModel>
    implements _$$_PackageViewModelCopyWith<$Res> {
  __$$_PackageViewModelCopyWithImpl(
      _$_PackageViewModel _value, $Res Function(_$_PackageViewModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? installedVersion = freezed,
    Object? installableVersion = freezed,
    Object? availableVersions = freezed,
    Object? isLatestVersionInstalled = freezed,
    Object? url = freezed,
    Object? changelogUrl = freezed,
    Object? description = freezed,
  }) {
    return _then(_$_PackageViewModel(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      installedVersion: freezed == installedVersion
          ? _value.installedVersion
          : installedVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      installableVersion: freezed == installableVersion
          ? _value.installableVersion
          : installableVersion // ignore: cast_nullable_to_non_nullable
              as String?,
      availableVersions: freezed == availableVersions
          ? _value._availableVersions
          : availableVersions // ignore: cast_nullable_to_non_nullable
              as List<PackageVersionViewModel>?,
      isLatestVersionInstalled: freezed == isLatestVersionInstalled
          ? _value.isLatestVersionInstalled
          : isLatestVersionInstalled // ignore: cast_nullable_to_non_nullable
              as bool?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      changelogUrl: freezed == changelogUrl
          ? _value.changelogUrl
          : changelogUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_PackageViewModel extends _PackageViewModel {
  const _$_PackageViewModel(
      {required this.name,
      required this.installedVersion,
      required this.installableVersion,
      required final List<PackageVersionViewModel>? availableVersions,
      required this.isLatestVersionInstalled,
      required this.url,
      required this.changelogUrl,
      required this.description})
      : _availableVersions = availableVersions,
        super._();

  @override
  final String name;
  @override
  final String? installedVersion;
  @override
  final String? installableVersion;
// required String? resolvableVersion,
// required PackageVersion? latestVersion,
  final List<PackageVersionViewModel>? _availableVersions;
// required String? resolvableVersion,
// required PackageVersion? latestVersion,
  @override
  List<PackageVersionViewModel>? get availableVersions {
    final value = _availableVersions;
    if (value == null) return null;
    if (_availableVersions is EqualUnmodifiableListView)
      return _availableVersions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? isLatestVersionInstalled;
  @override
  final String? url;
  @override
  final String? changelogUrl;
  @override
  final String? description;

  @override
  String toString() {
    return 'PackageViewModel(name: $name, installedVersion: $installedVersion, installableVersion: $installableVersion, availableVersions: $availableVersions, isLatestVersionInstalled: $isLatestVersionInstalled, url: $url, changelogUrl: $changelogUrl, description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PackageViewModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.installedVersion, installedVersion) ||
                other.installedVersion == installedVersion) &&
            (identical(other.installableVersion, installableVersion) ||
                other.installableVersion == installableVersion) &&
            const DeepCollectionEquality()
                .equals(other._availableVersions, _availableVersions) &&
            (identical(
                    other.isLatestVersionInstalled, isLatestVersionInstalled) ||
                other.isLatestVersionInstalled == isLatestVersionInstalled) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.changelogUrl, changelogUrl) ||
                other.changelogUrl == changelogUrl) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      installedVersion,
      installableVersion,
      const DeepCollectionEquality().hash(_availableVersions),
      isLatestVersionInstalled,
      url,
      changelogUrl,
      description);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PackageViewModelCopyWith<_$_PackageViewModel> get copyWith =>
      __$$_PackageViewModelCopyWithImpl<_$_PackageViewModel>(this, _$identity);
}

abstract class _PackageViewModel extends PackageViewModel {
  const factory _PackageViewModel(
      {required final String name,
      required final String? installedVersion,
      required final String? installableVersion,
      required final List<PackageVersionViewModel>? availableVersions,
      required final bool? isLatestVersionInstalled,
      required final String? url,
      required final String? changelogUrl,
      required final String? description}) = _$_PackageViewModel;
  const _PackageViewModel._() : super._();

  @override
  String get name;
  @override
  String? get installedVersion;
  @override
  String? get installableVersion;
  @override // required String? resolvableVersion,
// required PackageVersion? latestVersion,
  List<PackageVersionViewModel>? get availableVersions;
  @override
  bool? get isLatestVersionInstalled;
  @override
  String? get url;
  @override
  String? get changelogUrl;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$_PackageViewModelCopyWith<_$_PackageViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PackageVersionViewModel {
  String get version => throw _privateConstructorUsedError;
  bool get isInstalled => throw _privateConstructorUsedError;
  bool get isInstallable => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PackageVersionViewModelCopyWith<PackageVersionViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PackageVersionViewModelCopyWith<$Res> {
  factory $PackageVersionViewModelCopyWith(PackageVersionViewModel value,
          $Res Function(PackageVersionViewModel) then) =
      _$PackageVersionViewModelCopyWithImpl<$Res, PackageVersionViewModel>;
  @useResult
  $Res call({String version, bool isInstalled, bool isInstallable});
}

/// @nodoc
class _$PackageVersionViewModelCopyWithImpl<$Res,
        $Val extends PackageVersionViewModel>
    implements $PackageVersionViewModelCopyWith<$Res> {
  _$PackageVersionViewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = null,
    Object? isInstalled = null,
    Object? isInstallable = null,
  }) {
    return _then(_value.copyWith(
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      isInstalled: null == isInstalled
          ? _value.isInstalled
          : isInstalled // ignore: cast_nullable_to_non_nullable
              as bool,
      isInstallable: null == isInstallable
          ? _value.isInstallable
          : isInstallable // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PackageVersionViewModelCopyWith<$Res>
    implements $PackageVersionViewModelCopyWith<$Res> {
  factory _$$_PackageVersionViewModelCopyWith(_$_PackageVersionViewModel value,
          $Res Function(_$_PackageVersionViewModel) then) =
      __$$_PackageVersionViewModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String version, bool isInstalled, bool isInstallable});
}

/// @nodoc
class __$$_PackageVersionViewModelCopyWithImpl<$Res>
    extends _$PackageVersionViewModelCopyWithImpl<$Res,
        _$_PackageVersionViewModel>
    implements _$$_PackageVersionViewModelCopyWith<$Res> {
  __$$_PackageVersionViewModelCopyWithImpl(_$_PackageVersionViewModel _value,
      $Res Function(_$_PackageVersionViewModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = null,
    Object? isInstalled = null,
    Object? isInstallable = null,
  }) {
    return _then(_$_PackageVersionViewModel(
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      isInstalled: null == isInstalled
          ? _value.isInstalled
          : isInstalled // ignore: cast_nullable_to_non_nullable
              as bool,
      isInstallable: null == isInstallable
          ? _value.isInstallable
          : isInstallable // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_PackageVersionViewModel extends _PackageVersionViewModel {
  const _$_PackageVersionViewModel(
      {required this.version,
      required this.isInstalled,
      required this.isInstallable})
      : super._();

  @override
  final String version;
  @override
  final bool isInstalled;
  @override
  final bool isInstallable;

  @override
  String toString() {
    return 'PackageVersionViewModel(version: $version, isInstalled: $isInstalled, isInstallable: $isInstallable)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PackageVersionViewModel &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.isInstalled, isInstalled) ||
                other.isInstalled == isInstalled) &&
            (identical(other.isInstallable, isInstallable) ||
                other.isInstallable == isInstallable));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, version, isInstalled, isInstallable);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PackageVersionViewModelCopyWith<_$_PackageVersionViewModel>
      get copyWith =>
          __$$_PackageVersionViewModelCopyWithImpl<_$_PackageVersionViewModel>(
              this, _$identity);
}

abstract class _PackageVersionViewModel extends PackageVersionViewModel {
  const factory _PackageVersionViewModel(
      {required final String version,
      required final bool isInstalled,
      required final bool isInstallable}) = _$_PackageVersionViewModel;
  const _PackageVersionViewModel._() : super._();

  @override
  String get version;
  @override
  bool get isInstalled;
  @override
  bool get isInstallable;
  @override
  @JsonKey(ignore: true)
  _$$_PackageVersionViewModelCopyWith<_$_PackageVersionViewModel>
      get copyWith => throw _privateConstructorUsedError;
}
