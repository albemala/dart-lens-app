// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project-structure-bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ProjectStructureBlocState {
  String? get projectPath => throw _privateConstructorUsedError;
  List<ResolvedUnitResult>? get resolvedUnitResults =>
      throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get loadingError => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProjectStructureBlocStateCopyWith<ProjectStructureBlocState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectStructureBlocStateCopyWith<$Res> {
  factory $ProjectStructureBlocStateCopyWith(ProjectStructureBlocState value,
          $Res Function(ProjectStructureBlocState) then) =
      _$ProjectStructureBlocStateCopyWithImpl<$Res, ProjectStructureBlocState>;
  @useResult
  $Res call(
      {String? projectPath,
      List<ResolvedUnitResult>? resolvedUnitResults,
      bool isLoading,
      String? loadingError});
}

/// @nodoc
class _$ProjectStructureBlocStateCopyWithImpl<$Res,
        $Val extends ProjectStructureBlocState>
    implements $ProjectStructureBlocStateCopyWith<$Res> {
  _$ProjectStructureBlocStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectPath = freezed,
    Object? resolvedUnitResults = freezed,
    Object? isLoading = null,
    Object? loadingError = freezed,
  }) {
    return _then(_value.copyWith(
      projectPath: freezed == projectPath
          ? _value.projectPath
          : projectPath // ignore: cast_nullable_to_non_nullable
              as String?,
      resolvedUnitResults: freezed == resolvedUnitResults
          ? _value.resolvedUnitResults
          : resolvedUnitResults // ignore: cast_nullable_to_non_nullable
              as List<ResolvedUnitResult>?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      loadingError: freezed == loadingError
          ? _value.loadingError
          : loadingError // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProjectStructureBlocStateCopyWith<$Res>
    implements $ProjectStructureBlocStateCopyWith<$Res> {
  factory _$$_ProjectStructureBlocStateCopyWith(
          _$_ProjectStructureBlocState value,
          $Res Function(_$_ProjectStructureBlocState) then) =
      __$$_ProjectStructureBlocStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? projectPath,
      List<ResolvedUnitResult>? resolvedUnitResults,
      bool isLoading,
      String? loadingError});
}

/// @nodoc
class __$$_ProjectStructureBlocStateCopyWithImpl<$Res>
    extends _$ProjectStructureBlocStateCopyWithImpl<$Res,
        _$_ProjectStructureBlocState>
    implements _$$_ProjectStructureBlocStateCopyWith<$Res> {
  __$$_ProjectStructureBlocStateCopyWithImpl(
      _$_ProjectStructureBlocState _value,
      $Res Function(_$_ProjectStructureBlocState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectPath = freezed,
    Object? resolvedUnitResults = freezed,
    Object? isLoading = null,
    Object? loadingError = freezed,
  }) {
    return _then(_$_ProjectStructureBlocState(
      projectPath: freezed == projectPath
          ? _value.projectPath
          : projectPath // ignore: cast_nullable_to_non_nullable
              as String?,
      resolvedUnitResults: freezed == resolvedUnitResults
          ? _value._resolvedUnitResults
          : resolvedUnitResults // ignore: cast_nullable_to_non_nullable
              as List<ResolvedUnitResult>?,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      loadingError: freezed == loadingError
          ? _value.loadingError
          : loadingError // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_ProjectStructureBlocState extends _ProjectStructureBlocState {
  const _$_ProjectStructureBlocState(
      {required this.projectPath,
      required final List<ResolvedUnitResult>? resolvedUnitResults,
      required this.isLoading,
      required this.loadingError})
      : _resolvedUnitResults = resolvedUnitResults,
        super._();

  @override
  final String? projectPath;
  final List<ResolvedUnitResult>? _resolvedUnitResults;
  @override
  List<ResolvedUnitResult>? get resolvedUnitResults {
    final value = _resolvedUnitResults;
    if (value == null) return null;
    if (_resolvedUnitResults is EqualUnmodifiableListView)
      return _resolvedUnitResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool isLoading;
  @override
  final String? loadingError;

  @override
  String toString() {
    return 'ProjectStructureBlocState(projectPath: $projectPath, resolvedUnitResults: $resolvedUnitResults, isLoading: $isLoading, loadingError: $loadingError)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProjectStructureBlocState &&
            (identical(other.projectPath, projectPath) ||
                other.projectPath == projectPath) &&
            const DeepCollectionEquality()
                .equals(other._resolvedUnitResults, _resolvedUnitResults) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.loadingError, loadingError) ||
                other.loadingError == loadingError));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      projectPath,
      const DeepCollectionEquality().hash(_resolvedUnitResults),
      isLoading,
      loadingError);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProjectStructureBlocStateCopyWith<_$_ProjectStructureBlocState>
      get copyWith => __$$_ProjectStructureBlocStateCopyWithImpl<
          _$_ProjectStructureBlocState>(this, _$identity);
}

abstract class _ProjectStructureBlocState extends ProjectStructureBlocState {
  const factory _ProjectStructureBlocState(
      {required final String? projectPath,
      required final List<ResolvedUnitResult>? resolvedUnitResults,
      required final bool isLoading,
      required final String? loadingError}) = _$_ProjectStructureBlocState;
  const _ProjectStructureBlocState._() : super._();

  @override
  String? get projectPath;
  @override
  List<ResolvedUnitResult>? get resolvedUnitResults;
  @override
  bool get isLoading;
  @override
  String? get loadingError;
  @override
  @JsonKey(ignore: true)
  _$$_ProjectStructureBlocStateCopyWith<_$_ProjectStructureBlocState>
      get copyWith => throw _privateConstructorUsedError;
}
