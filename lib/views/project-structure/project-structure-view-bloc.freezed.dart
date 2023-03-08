// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project-structure-view-bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ProjectStructureViewModel {
  String get projectPath => throw _privateConstructorUsedError;
  List<DirectoryViewModel> get directories =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProjectStructureViewModelCopyWith<ProjectStructureViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectStructureViewModelCopyWith<$Res> {
  factory $ProjectStructureViewModelCopyWith(ProjectStructureViewModel value,
          $Res Function(ProjectStructureViewModel) then) =
      _$ProjectStructureViewModelCopyWithImpl<$Res, ProjectStructureViewModel>;
  @useResult
  $Res call({String projectPath, List<DirectoryViewModel> directories});
}

/// @nodoc
class _$ProjectStructureViewModelCopyWithImpl<$Res,
        $Val extends ProjectStructureViewModel>
    implements $ProjectStructureViewModelCopyWith<$Res> {
  _$ProjectStructureViewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectPath = null,
    Object? directories = null,
  }) {
    return _then(_value.copyWith(
      projectPath: null == projectPath
          ? _value.projectPath
          : projectPath // ignore: cast_nullable_to_non_nullable
              as String,
      directories: null == directories
          ? _value.directories
          : directories // ignore: cast_nullable_to_non_nullable
              as List<DirectoryViewModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProjectStructureViewModelCopyWith<$Res>
    implements $ProjectStructureViewModelCopyWith<$Res> {
  factory _$$_ProjectStructureViewModelCopyWith(
          _$_ProjectStructureViewModel value,
          $Res Function(_$_ProjectStructureViewModel) then) =
      __$$_ProjectStructureViewModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String projectPath, List<DirectoryViewModel> directories});
}

/// @nodoc
class __$$_ProjectStructureViewModelCopyWithImpl<$Res>
    extends _$ProjectStructureViewModelCopyWithImpl<$Res,
        _$_ProjectStructureViewModel>
    implements _$$_ProjectStructureViewModelCopyWith<$Res> {
  __$$_ProjectStructureViewModelCopyWithImpl(
      _$_ProjectStructureViewModel _value,
      $Res Function(_$_ProjectStructureViewModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectPath = null,
    Object? directories = null,
  }) {
    return _then(_$_ProjectStructureViewModel(
      projectPath: null == projectPath
          ? _value.projectPath
          : projectPath // ignore: cast_nullable_to_non_nullable
              as String,
      directories: null == directories
          ? _value._directories
          : directories // ignore: cast_nullable_to_non_nullable
              as List<DirectoryViewModel>,
    ));
  }
}

/// @nodoc

class _$_ProjectStructureViewModel extends _ProjectStructureViewModel {
  const _$_ProjectStructureViewModel(
      {required this.projectPath,
      required final List<DirectoryViewModel> directories})
      : _directories = directories,
        super._();

  @override
  final String projectPath;
  final List<DirectoryViewModel> _directories;
  @override
  List<DirectoryViewModel> get directories {
    if (_directories is EqualUnmodifiableListView) return _directories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_directories);
  }

  @override
  String toString() {
    return 'ProjectStructureViewModel(projectPath: $projectPath, directories: $directories)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProjectStructureViewModel &&
            (identical(other.projectPath, projectPath) ||
                other.projectPath == projectPath) &&
            const DeepCollectionEquality()
                .equals(other._directories, _directories));
  }

  @override
  int get hashCode => Object.hash(runtimeType, projectPath,
      const DeepCollectionEquality().hash(_directories));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProjectStructureViewModelCopyWith<_$_ProjectStructureViewModel>
      get copyWith => __$$_ProjectStructureViewModelCopyWithImpl<
          _$_ProjectStructureViewModel>(this, _$identity);
}

abstract class _ProjectStructureViewModel extends ProjectStructureViewModel {
  const factory _ProjectStructureViewModel(
          {required final String projectPath,
          required final List<DirectoryViewModel> directories}) =
      _$_ProjectStructureViewModel;
  const _ProjectStructureViewModel._() : super._();

  @override
  String get projectPath;
  @override
  List<DirectoryViewModel> get directories;
  @override
  @JsonKey(ignore: true)
  _$$_ProjectStructureViewModelCopyWith<_$_ProjectStructureViewModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$DirectoryViewModel {
  String get path => throw _privateConstructorUsedError;
  List<FileViewModel> get files => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $DirectoryViewModelCopyWith<DirectoryViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DirectoryViewModelCopyWith<$Res> {
  factory $DirectoryViewModelCopyWith(
          DirectoryViewModel value, $Res Function(DirectoryViewModel) then) =
      _$DirectoryViewModelCopyWithImpl<$Res, DirectoryViewModel>;
  @useResult
  $Res call({String path, List<FileViewModel> files});
}

/// @nodoc
class _$DirectoryViewModelCopyWithImpl<$Res, $Val extends DirectoryViewModel>
    implements $DirectoryViewModelCopyWith<$Res> {
  _$DirectoryViewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? files = null,
  }) {
    return _then(_value.copyWith(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      files: null == files
          ? _value.files
          : files // ignore: cast_nullable_to_non_nullable
              as List<FileViewModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_DirectoryViewModelCopyWith<$Res>
    implements $DirectoryViewModelCopyWith<$Res> {
  factory _$$_DirectoryViewModelCopyWith(_$_DirectoryViewModel value,
          $Res Function(_$_DirectoryViewModel) then) =
      __$$_DirectoryViewModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String path, List<FileViewModel> files});
}

/// @nodoc
class __$$_DirectoryViewModelCopyWithImpl<$Res>
    extends _$DirectoryViewModelCopyWithImpl<$Res, _$_DirectoryViewModel>
    implements _$$_DirectoryViewModelCopyWith<$Res> {
  __$$_DirectoryViewModelCopyWithImpl(
      _$_DirectoryViewModel _value, $Res Function(_$_DirectoryViewModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? path = null,
    Object? files = null,
  }) {
    return _then(_$_DirectoryViewModel(
      path: null == path
          ? _value.path
          : path // ignore: cast_nullable_to_non_nullable
              as String,
      files: null == files
          ? _value._files
          : files // ignore: cast_nullable_to_non_nullable
              as List<FileViewModel>,
    ));
  }
}

/// @nodoc

class _$_DirectoryViewModel extends _DirectoryViewModel {
  const _$_DirectoryViewModel(
      {required this.path, required final List<FileViewModel> files})
      : _files = files,
        super._();

  @override
  final String path;
  final List<FileViewModel> _files;
  @override
  List<FileViewModel> get files {
    if (_files is EqualUnmodifiableListView) return _files;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_files);
  }

  @override
  String toString() {
    return 'DirectoryViewModel(path: $path, files: $files)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DirectoryViewModel &&
            (identical(other.path, path) || other.path == path) &&
            const DeepCollectionEquality().equals(other._files, _files));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, path, const DeepCollectionEquality().hash(_files));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DirectoryViewModelCopyWith<_$_DirectoryViewModel> get copyWith =>
      __$$_DirectoryViewModelCopyWithImpl<_$_DirectoryViewModel>(
          this, _$identity);
}

abstract class _DirectoryViewModel extends DirectoryViewModel {
  const factory _DirectoryViewModel(
      {required final String path,
      required final List<FileViewModel> files}) = _$_DirectoryViewModel;
  const _DirectoryViewModel._() : super._();

  @override
  String get path;
  @override
  List<FileViewModel> get files;
  @override
  @JsonKey(ignore: true)
  _$$_DirectoryViewModelCopyWith<_$_DirectoryViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FileViewModel {
  String get name => throw _privateConstructorUsedError;
  List<EntityViewModel> get entities => throw _privateConstructorUsedError;
  List<String> get imports => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FileViewModelCopyWith<FileViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FileViewModelCopyWith<$Res> {
  factory $FileViewModelCopyWith(
          FileViewModel value, $Res Function(FileViewModel) then) =
      _$FileViewModelCopyWithImpl<$Res, FileViewModel>;
  @useResult
  $Res call(
      {String name, List<EntityViewModel> entities, List<String> imports});
}

/// @nodoc
class _$FileViewModelCopyWithImpl<$Res, $Val extends FileViewModel>
    implements $FileViewModelCopyWith<$Res> {
  _$FileViewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? entities = null,
    Object? imports = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      entities: null == entities
          ? _value.entities
          : entities // ignore: cast_nullable_to_non_nullable
              as List<EntityViewModel>,
      imports: null == imports
          ? _value.imports
          : imports // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FileViewModelCopyWith<$Res>
    implements $FileViewModelCopyWith<$Res> {
  factory _$$_FileViewModelCopyWith(
          _$_FileViewModel value, $Res Function(_$_FileViewModel) then) =
      __$$_FileViewModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name, List<EntityViewModel> entities, List<String> imports});
}

/// @nodoc
class __$$_FileViewModelCopyWithImpl<$Res>
    extends _$FileViewModelCopyWithImpl<$Res, _$_FileViewModel>
    implements _$$_FileViewModelCopyWith<$Res> {
  __$$_FileViewModelCopyWithImpl(
      _$_FileViewModel _value, $Res Function(_$_FileViewModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? entities = null,
    Object? imports = null,
  }) {
    return _then(_$_FileViewModel(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      entities: null == entities
          ? _value._entities
          : entities // ignore: cast_nullable_to_non_nullable
              as List<EntityViewModel>,
      imports: null == imports
          ? _value._imports
          : imports // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$_FileViewModel extends _FileViewModel {
  const _$_FileViewModel(
      {required this.name,
      required final List<EntityViewModel> entities,
      required final List<String> imports})
      : _entities = entities,
        _imports = imports,
        super._();

  @override
  final String name;
  final List<EntityViewModel> _entities;
  @override
  List<EntityViewModel> get entities {
    if (_entities is EqualUnmodifiableListView) return _entities;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_entities);
  }

  final List<String> _imports;
  @override
  List<String> get imports {
    if (_imports is EqualUnmodifiableListView) return _imports;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imports);
  }

  @override
  String toString() {
    return 'FileViewModel(name: $name, entities: $entities, imports: $imports)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FileViewModel &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._entities, _entities) &&
            const DeepCollectionEquality().equals(other._imports, _imports));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      const DeepCollectionEquality().hash(_entities),
      const DeepCollectionEquality().hash(_imports));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FileViewModelCopyWith<_$_FileViewModel> get copyWith =>
      __$$_FileViewModelCopyWithImpl<_$_FileViewModel>(this, _$identity);
}

abstract class _FileViewModel extends FileViewModel {
  const factory _FileViewModel(
      {required final String name,
      required final List<EntityViewModel> entities,
      required final List<String> imports}) = _$_FileViewModel;
  const _FileViewModel._() : super._();

  @override
  String get name;
  @override
  List<EntityViewModel> get entities;
  @override
  List<String> get imports;
  @override
  @JsonKey(ignore: true)
  _$$_FileViewModelCopyWith<_$_FileViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ParameterViewModel {
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ParameterViewModelCopyWith<ParameterViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParameterViewModelCopyWith<$Res> {
  factory $ParameterViewModelCopyWith(
          ParameterViewModel value, $Res Function(ParameterViewModel) then) =
      _$ParameterViewModelCopyWithImpl<$Res, ParameterViewModel>;
  @useResult
  $Res call({String name, String type});
}

/// @nodoc
class _$ParameterViewModelCopyWithImpl<$Res, $Val extends ParameterViewModel>
    implements $ParameterViewModelCopyWith<$Res> {
  _$ParameterViewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ParameterViewModelCopyWith<$Res>
    implements $ParameterViewModelCopyWith<$Res> {
  factory _$$_ParameterViewModelCopyWith(_$_ParameterViewModel value,
          $Res Function(_$_ParameterViewModel) then) =
      __$$_ParameterViewModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String type});
}

/// @nodoc
class __$$_ParameterViewModelCopyWithImpl<$Res>
    extends _$ParameterViewModelCopyWithImpl<$Res, _$_ParameterViewModel>
    implements _$$_ParameterViewModelCopyWith<$Res> {
  __$$_ParameterViewModelCopyWithImpl(
      _$_ParameterViewModel _value, $Res Function(_$_ParameterViewModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
  }) {
    return _then(_$_ParameterViewModel(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ParameterViewModel extends _ParameterViewModel {
  const _$_ParameterViewModel({required this.name, required this.type})
      : super._();

  @override
  final String name;
  @override
  final String type;

  @override
  String toString() {
    return 'ParameterViewModel(name: $name, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ParameterViewModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ParameterViewModelCopyWith<_$_ParameterViewModel> get copyWith =>
      __$$_ParameterViewModelCopyWithImpl<_$_ParameterViewModel>(
          this, _$identity);
}

abstract class _ParameterViewModel extends ParameterViewModel {
  const factory _ParameterViewModel(
      {required final String name,
      required final String type}) = _$_ParameterViewModel;
  const _ParameterViewModel._() : super._();

  @override
  String get name;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$_ParameterViewModelCopyWith<_$_ParameterViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ClassViewModel {
  String get name => throw _privateConstructorUsedError;
  List<ClassPropertyViewModel> get properties =>
      throw _privateConstructorUsedError;
  List<ClassConstructorViewModel> get constructors =>
      throw _privateConstructorUsedError;
  List<ClassMethodViewModel> get methods => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ClassViewModelCopyWith<ClassViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassViewModelCopyWith<$Res> {
  factory $ClassViewModelCopyWith(
          ClassViewModel value, $Res Function(ClassViewModel) then) =
      _$ClassViewModelCopyWithImpl<$Res, ClassViewModel>;
  @useResult
  $Res call(
      {String name,
      List<ClassPropertyViewModel> properties,
      List<ClassConstructorViewModel> constructors,
      List<ClassMethodViewModel> methods});
}

/// @nodoc
class _$ClassViewModelCopyWithImpl<$Res, $Val extends ClassViewModel>
    implements $ClassViewModelCopyWith<$Res> {
  _$ClassViewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? properties = null,
    Object? constructors = null,
    Object? methods = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      properties: null == properties
          ? _value.properties
          : properties // ignore: cast_nullable_to_non_nullable
              as List<ClassPropertyViewModel>,
      constructors: null == constructors
          ? _value.constructors
          : constructors // ignore: cast_nullable_to_non_nullable
              as List<ClassConstructorViewModel>,
      methods: null == methods
          ? _value.methods
          : methods // ignore: cast_nullable_to_non_nullable
              as List<ClassMethodViewModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ClassViewModelCopyWith<$Res>
    implements $ClassViewModelCopyWith<$Res> {
  factory _$$_ClassViewModelCopyWith(
          _$_ClassViewModel value, $Res Function(_$_ClassViewModel) then) =
      __$$_ClassViewModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      List<ClassPropertyViewModel> properties,
      List<ClassConstructorViewModel> constructors,
      List<ClassMethodViewModel> methods});
}

/// @nodoc
class __$$_ClassViewModelCopyWithImpl<$Res>
    extends _$ClassViewModelCopyWithImpl<$Res, _$_ClassViewModel>
    implements _$$_ClassViewModelCopyWith<$Res> {
  __$$_ClassViewModelCopyWithImpl(
      _$_ClassViewModel _value, $Res Function(_$_ClassViewModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? properties = null,
    Object? constructors = null,
    Object? methods = null,
  }) {
    return _then(_$_ClassViewModel(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      properties: null == properties
          ? _value._properties
          : properties // ignore: cast_nullable_to_non_nullable
              as List<ClassPropertyViewModel>,
      constructors: null == constructors
          ? _value._constructors
          : constructors // ignore: cast_nullable_to_non_nullable
              as List<ClassConstructorViewModel>,
      methods: null == methods
          ? _value._methods
          : methods // ignore: cast_nullable_to_non_nullable
              as List<ClassMethodViewModel>,
    ));
  }
}

/// @nodoc

class _$_ClassViewModel extends _ClassViewModel {
  const _$_ClassViewModel(
      {required this.name,
      required final List<ClassPropertyViewModel> properties,
      required final List<ClassConstructorViewModel> constructors,
      required final List<ClassMethodViewModel> methods})
      : _properties = properties,
        _constructors = constructors,
        _methods = methods,
        super._();

  @override
  final String name;
  final List<ClassPropertyViewModel> _properties;
  @override
  List<ClassPropertyViewModel> get properties {
    if (_properties is EqualUnmodifiableListView) return _properties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_properties);
  }

  final List<ClassConstructorViewModel> _constructors;
  @override
  List<ClassConstructorViewModel> get constructors {
    if (_constructors is EqualUnmodifiableListView) return _constructors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_constructors);
  }

  final List<ClassMethodViewModel> _methods;
  @override
  List<ClassMethodViewModel> get methods {
    if (_methods is EqualUnmodifiableListView) return _methods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_methods);
  }

  @override
  String toString() {
    return 'ClassViewModel(name: $name, properties: $properties, constructors: $constructors, methods: $methods)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ClassViewModel &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._properties, _properties) &&
            const DeepCollectionEquality()
                .equals(other._constructors, _constructors) &&
            const DeepCollectionEquality().equals(other._methods, _methods));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      const DeepCollectionEquality().hash(_properties),
      const DeepCollectionEquality().hash(_constructors),
      const DeepCollectionEquality().hash(_methods));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ClassViewModelCopyWith<_$_ClassViewModel> get copyWith =>
      __$$_ClassViewModelCopyWithImpl<_$_ClassViewModel>(this, _$identity);
}

abstract class _ClassViewModel extends ClassViewModel {
  const factory _ClassViewModel(
      {required final String name,
      required final List<ClassPropertyViewModel> properties,
      required final List<ClassConstructorViewModel> constructors,
      required final List<ClassMethodViewModel> methods}) = _$_ClassViewModel;
  const _ClassViewModel._() : super._();

  @override
  String get name;
  @override
  List<ClassPropertyViewModel> get properties;
  @override
  List<ClassConstructorViewModel> get constructors;
  @override
  List<ClassMethodViewModel> get methods;
  @override
  @JsonKey(ignore: true)
  _$$_ClassViewModelCopyWith<_$_ClassViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ClassPropertyViewModel {
  String get name => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ClassPropertyViewModelCopyWith<ClassPropertyViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassPropertyViewModelCopyWith<$Res> {
  factory $ClassPropertyViewModelCopyWith(ClassPropertyViewModel value,
          $Res Function(ClassPropertyViewModel) then) =
      _$ClassPropertyViewModelCopyWithImpl<$Res, ClassPropertyViewModel>;
  @useResult
  $Res call({String name, String type});
}

/// @nodoc
class _$ClassPropertyViewModelCopyWithImpl<$Res,
        $Val extends ClassPropertyViewModel>
    implements $ClassPropertyViewModelCopyWith<$Res> {
  _$ClassPropertyViewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ClassPropertyViewModelCopyWith<$Res>
    implements $ClassPropertyViewModelCopyWith<$Res> {
  factory _$$_ClassPropertyViewModelCopyWith(_$_ClassPropertyViewModel value,
          $Res Function(_$_ClassPropertyViewModel) then) =
      __$$_ClassPropertyViewModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String type});
}

/// @nodoc
class __$$_ClassPropertyViewModelCopyWithImpl<$Res>
    extends _$ClassPropertyViewModelCopyWithImpl<$Res,
        _$_ClassPropertyViewModel>
    implements _$$_ClassPropertyViewModelCopyWith<$Res> {
  __$$_ClassPropertyViewModelCopyWithImpl(_$_ClassPropertyViewModel _value,
      $Res Function(_$_ClassPropertyViewModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? type = null,
  }) {
    return _then(_$_ClassPropertyViewModel(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_ClassPropertyViewModel extends _ClassPropertyViewModel {
  const _$_ClassPropertyViewModel({required this.name, required this.type})
      : super._();

  @override
  final String name;
  @override
  final String type;

  @override
  String toString() {
    return 'ClassPropertyViewModel(name: $name, type: $type)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ClassPropertyViewModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ClassPropertyViewModelCopyWith<_$_ClassPropertyViewModel> get copyWith =>
      __$$_ClassPropertyViewModelCopyWithImpl<_$_ClassPropertyViewModel>(
          this, _$identity);
}

abstract class _ClassPropertyViewModel extends ClassPropertyViewModel {
  const factory _ClassPropertyViewModel(
      {required final String name,
      required final String type}) = _$_ClassPropertyViewModel;
  const _ClassPropertyViewModel._() : super._();

  @override
  String get name;
  @override
  String get type;
  @override
  @JsonKey(ignore: true)
  _$$_ClassPropertyViewModelCopyWith<_$_ClassPropertyViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ClassConstructorViewModel {
  String get name => throw _privateConstructorUsedError;
  List<ParameterViewModel> get parameters => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ClassConstructorViewModelCopyWith<ClassConstructorViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassConstructorViewModelCopyWith<$Res> {
  factory $ClassConstructorViewModelCopyWith(ClassConstructorViewModel value,
          $Res Function(ClassConstructorViewModel) then) =
      _$ClassConstructorViewModelCopyWithImpl<$Res, ClassConstructorViewModel>;
  @useResult
  $Res call({String name, List<ParameterViewModel> parameters});
}

/// @nodoc
class _$ClassConstructorViewModelCopyWithImpl<$Res,
        $Val extends ClassConstructorViewModel>
    implements $ClassConstructorViewModelCopyWith<$Res> {
  _$ClassConstructorViewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? parameters = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      parameters: null == parameters
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as List<ParameterViewModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ClassConstructorViewModelCopyWith<$Res>
    implements $ClassConstructorViewModelCopyWith<$Res> {
  factory _$$_ClassConstructorViewModelCopyWith(
          _$_ClassConstructorViewModel value,
          $Res Function(_$_ClassConstructorViewModel) then) =
      __$$_ClassConstructorViewModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, List<ParameterViewModel> parameters});
}

/// @nodoc
class __$$_ClassConstructorViewModelCopyWithImpl<$Res>
    extends _$ClassConstructorViewModelCopyWithImpl<$Res,
        _$_ClassConstructorViewModel>
    implements _$$_ClassConstructorViewModelCopyWith<$Res> {
  __$$_ClassConstructorViewModelCopyWithImpl(
      _$_ClassConstructorViewModel _value,
      $Res Function(_$_ClassConstructorViewModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? parameters = null,
  }) {
    return _then(_$_ClassConstructorViewModel(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      parameters: null == parameters
          ? _value._parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as List<ParameterViewModel>,
    ));
  }
}

/// @nodoc

class _$_ClassConstructorViewModel extends _ClassConstructorViewModel {
  const _$_ClassConstructorViewModel(
      {required this.name, required final List<ParameterViewModel> parameters})
      : _parameters = parameters,
        super._();

  @override
  final String name;
  final List<ParameterViewModel> _parameters;
  @override
  List<ParameterViewModel> get parameters {
    if (_parameters is EqualUnmodifiableListView) return _parameters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_parameters);
  }

  @override
  String toString() {
    return 'ClassConstructorViewModel(name: $name, parameters: $parameters)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ClassConstructorViewModel &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality()
                .equals(other._parameters, _parameters));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, name, const DeepCollectionEquality().hash(_parameters));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ClassConstructorViewModelCopyWith<_$_ClassConstructorViewModel>
      get copyWith => __$$_ClassConstructorViewModelCopyWithImpl<
          _$_ClassConstructorViewModel>(this, _$identity);
}

abstract class _ClassConstructorViewModel extends ClassConstructorViewModel {
  const factory _ClassConstructorViewModel(
          {required final String name,
          required final List<ParameterViewModel> parameters}) =
      _$_ClassConstructorViewModel;
  const _ClassConstructorViewModel._() : super._();

  @override
  String get name;
  @override
  List<ParameterViewModel> get parameters;
  @override
  @JsonKey(ignore: true)
  _$$_ClassConstructorViewModelCopyWith<_$_ClassConstructorViewModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ClassMethodViewModel {
  String get name => throw _privateConstructorUsedError;
  String get returnType => throw _privateConstructorUsedError;
  List<ParameterViewModel> get parameters => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ClassMethodViewModelCopyWith<ClassMethodViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClassMethodViewModelCopyWith<$Res> {
  factory $ClassMethodViewModelCopyWith(ClassMethodViewModel value,
          $Res Function(ClassMethodViewModel) then) =
      _$ClassMethodViewModelCopyWithImpl<$Res, ClassMethodViewModel>;
  @useResult
  $Res call(
      {String name, String returnType, List<ParameterViewModel> parameters});
}

/// @nodoc
class _$ClassMethodViewModelCopyWithImpl<$Res,
        $Val extends ClassMethodViewModel>
    implements $ClassMethodViewModelCopyWith<$Res> {
  _$ClassMethodViewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? returnType = null,
    Object? parameters = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      returnType: null == returnType
          ? _value.returnType
          : returnType // ignore: cast_nullable_to_non_nullable
              as String,
      parameters: null == parameters
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as List<ParameterViewModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ClassMethodViewModelCopyWith<$Res>
    implements $ClassMethodViewModelCopyWith<$Res> {
  factory _$$_ClassMethodViewModelCopyWith(_$_ClassMethodViewModel value,
          $Res Function(_$_ClassMethodViewModel) then) =
      __$$_ClassMethodViewModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name, String returnType, List<ParameterViewModel> parameters});
}

/// @nodoc
class __$$_ClassMethodViewModelCopyWithImpl<$Res>
    extends _$ClassMethodViewModelCopyWithImpl<$Res, _$_ClassMethodViewModel>
    implements _$$_ClassMethodViewModelCopyWith<$Res> {
  __$$_ClassMethodViewModelCopyWithImpl(_$_ClassMethodViewModel _value,
      $Res Function(_$_ClassMethodViewModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? returnType = null,
    Object? parameters = null,
  }) {
    return _then(_$_ClassMethodViewModel(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      returnType: null == returnType
          ? _value.returnType
          : returnType // ignore: cast_nullable_to_non_nullable
              as String,
      parameters: null == parameters
          ? _value._parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as List<ParameterViewModel>,
    ));
  }
}

/// @nodoc

class _$_ClassMethodViewModel extends _ClassMethodViewModel {
  const _$_ClassMethodViewModel(
      {required this.name,
      required this.returnType,
      required final List<ParameterViewModel> parameters})
      : _parameters = parameters,
        super._();

  @override
  final String name;
  @override
  final String returnType;
  final List<ParameterViewModel> _parameters;
  @override
  List<ParameterViewModel> get parameters {
    if (_parameters is EqualUnmodifiableListView) return _parameters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_parameters);
  }

  @override
  String toString() {
    return 'ClassMethodViewModel(name: $name, returnType: $returnType, parameters: $parameters)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ClassMethodViewModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.returnType, returnType) ||
                other.returnType == returnType) &&
            const DeepCollectionEquality()
                .equals(other._parameters, _parameters));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, returnType,
      const DeepCollectionEquality().hash(_parameters));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ClassMethodViewModelCopyWith<_$_ClassMethodViewModel> get copyWith =>
      __$$_ClassMethodViewModelCopyWithImpl<_$_ClassMethodViewModel>(
          this, _$identity);
}

abstract class _ClassMethodViewModel extends ClassMethodViewModel {
  const factory _ClassMethodViewModel(
          {required final String name,
          required final String returnType,
          required final List<ParameterViewModel> parameters}) =
      _$_ClassMethodViewModel;
  const _ClassMethodViewModel._() : super._();

  @override
  String get name;
  @override
  String get returnType;
  @override
  List<ParameterViewModel> get parameters;
  @override
  @JsonKey(ignore: true)
  _$$_ClassMethodViewModelCopyWith<_$_ClassMethodViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$EnumViewModel {
  String get name => throw _privateConstructorUsedError;
  List<String> get values => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $EnumViewModelCopyWith<EnumViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EnumViewModelCopyWith<$Res> {
  factory $EnumViewModelCopyWith(
          EnumViewModel value, $Res Function(EnumViewModel) then) =
      _$EnumViewModelCopyWithImpl<$Res, EnumViewModel>;
  @useResult
  $Res call({String name, List<String> values});
}

/// @nodoc
class _$EnumViewModelCopyWithImpl<$Res, $Val extends EnumViewModel>
    implements $EnumViewModelCopyWith<$Res> {
  _$EnumViewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? values = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      values: null == values
          ? _value.values
          : values // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_EnumViewModelCopyWith<$Res>
    implements $EnumViewModelCopyWith<$Res> {
  factory _$$_EnumViewModelCopyWith(
          _$_EnumViewModel value, $Res Function(_$_EnumViewModel) then) =
      __$$_EnumViewModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, List<String> values});
}

/// @nodoc
class __$$_EnumViewModelCopyWithImpl<$Res>
    extends _$EnumViewModelCopyWithImpl<$Res, _$_EnumViewModel>
    implements _$$_EnumViewModelCopyWith<$Res> {
  __$$_EnumViewModelCopyWithImpl(
      _$_EnumViewModel _value, $Res Function(_$_EnumViewModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? values = null,
  }) {
    return _then(_$_EnumViewModel(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      values: null == values
          ? _value._values
          : values // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$_EnumViewModel extends _EnumViewModel {
  const _$_EnumViewModel(
      {required this.name, required final List<String> values})
      : _values = values,
        super._();

  @override
  final String name;
  final List<String> _values;
  @override
  List<String> get values {
    if (_values is EqualUnmodifiableListView) return _values;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_values);
  }

  @override
  String toString() {
    return 'EnumViewModel(name: $name, values: $values)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EnumViewModel &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._values, _values));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, name, const DeepCollectionEquality().hash(_values));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EnumViewModelCopyWith<_$_EnumViewModel> get copyWith =>
      __$$_EnumViewModelCopyWithImpl<_$_EnumViewModel>(this, _$identity);
}

abstract class _EnumViewModel extends EnumViewModel {
  const factory _EnumViewModel(
      {required final String name,
      required final List<String> values}) = _$_EnumViewModel;
  const _EnumViewModel._() : super._();

  @override
  String get name;
  @override
  List<String> get values;
  @override
  @JsonKey(ignore: true)
  _$$_EnumViewModelCopyWith<_$_EnumViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$FunctionViewModel {
  String get name => throw _privateConstructorUsedError;
  String get returnType => throw _privateConstructorUsedError;
  List<ParameterViewModel> get parameters => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FunctionViewModelCopyWith<FunctionViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FunctionViewModelCopyWith<$Res> {
  factory $FunctionViewModelCopyWith(
          FunctionViewModel value, $Res Function(FunctionViewModel) then) =
      _$FunctionViewModelCopyWithImpl<$Res, FunctionViewModel>;
  @useResult
  $Res call(
      {String name, String returnType, List<ParameterViewModel> parameters});
}

/// @nodoc
class _$FunctionViewModelCopyWithImpl<$Res, $Val extends FunctionViewModel>
    implements $FunctionViewModelCopyWith<$Res> {
  _$FunctionViewModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? returnType = null,
    Object? parameters = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      returnType: null == returnType
          ? _value.returnType
          : returnType // ignore: cast_nullable_to_non_nullable
              as String,
      parameters: null == parameters
          ? _value.parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as List<ParameterViewModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FunctionViewModelCopyWith<$Res>
    implements $FunctionViewModelCopyWith<$Res> {
  factory _$$_FunctionViewModelCopyWith(_$_FunctionViewModel value,
          $Res Function(_$_FunctionViewModel) then) =
      __$$_FunctionViewModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name, String returnType, List<ParameterViewModel> parameters});
}

/// @nodoc
class __$$_FunctionViewModelCopyWithImpl<$Res>
    extends _$FunctionViewModelCopyWithImpl<$Res, _$_FunctionViewModel>
    implements _$$_FunctionViewModelCopyWith<$Res> {
  __$$_FunctionViewModelCopyWithImpl(
      _$_FunctionViewModel _value, $Res Function(_$_FunctionViewModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? returnType = null,
    Object? parameters = null,
  }) {
    return _then(_$_FunctionViewModel(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      returnType: null == returnType
          ? _value.returnType
          : returnType // ignore: cast_nullable_to_non_nullable
              as String,
      parameters: null == parameters
          ? _value._parameters
          : parameters // ignore: cast_nullable_to_non_nullable
              as List<ParameterViewModel>,
    ));
  }
}

/// @nodoc

class _$_FunctionViewModel extends _FunctionViewModel {
  const _$_FunctionViewModel(
      {required this.name,
      required this.returnType,
      required final List<ParameterViewModel> parameters})
      : _parameters = parameters,
        super._();

  @override
  final String name;
  @override
  final String returnType;
  final List<ParameterViewModel> _parameters;
  @override
  List<ParameterViewModel> get parameters {
    if (_parameters is EqualUnmodifiableListView) return _parameters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_parameters);
  }

  @override
  String toString() {
    return 'FunctionViewModel(name: $name, returnType: $returnType, parameters: $parameters)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FunctionViewModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.returnType, returnType) ||
                other.returnType == returnType) &&
            const DeepCollectionEquality()
                .equals(other._parameters, _parameters));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, returnType,
      const DeepCollectionEquality().hash(_parameters));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FunctionViewModelCopyWith<_$_FunctionViewModel> get copyWith =>
      __$$_FunctionViewModelCopyWithImpl<_$_FunctionViewModel>(
          this, _$identity);
}

abstract class _FunctionViewModel extends FunctionViewModel {
  const factory _FunctionViewModel(
          {required final String name,
          required final String returnType,
          required final List<ParameterViewModel> parameters}) =
      _$_FunctionViewModel;
  const _FunctionViewModel._() : super._();

  @override
  String get name;
  @override
  String get returnType;
  @override
  List<ParameterViewModel> get parameters;
  @override
  @JsonKey(ignore: true)
  _$$_FunctionViewModelCopyWith<_$_FunctionViewModel> get copyWith =>
      throw _privateConstructorUsedError;
}
