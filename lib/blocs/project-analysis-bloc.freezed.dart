// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'project-analysis-bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ProjectAnalysisBlocState {
  String? get projectPath => throw _privateConstructorUsedError;
  List<Package>? get packages => throw _privateConstructorUsedError;
  List<ResolvedUnitResult>? get resolvedUnitResults =>
      throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get loadingError => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ProjectAnalysisBlocStateCopyWith<ProjectAnalysisBlocState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProjectAnalysisBlocStateCopyWith<$Res> {
  factory $ProjectAnalysisBlocStateCopyWith(ProjectAnalysisBlocState value,
          $Res Function(ProjectAnalysisBlocState) then) =
      _$ProjectAnalysisBlocStateCopyWithImpl<$Res, ProjectAnalysisBlocState>;
  @useResult
  $Res call(
      {String? projectPath,
      List<Package>? packages,
      List<ResolvedUnitResult>? resolvedUnitResults,
      bool isLoading,
      String? loadingError});
}

/// @nodoc
class _$ProjectAnalysisBlocStateCopyWithImpl<$Res,
        $Val extends ProjectAnalysisBlocState>
    implements $ProjectAnalysisBlocStateCopyWith<$Res> {
  _$ProjectAnalysisBlocStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectPath = freezed,
    Object? packages = freezed,
    Object? resolvedUnitResults = freezed,
    Object? isLoading = null,
    Object? loadingError = freezed,
  }) {
    return _then(_value.copyWith(
      projectPath: freezed == projectPath
          ? _value.projectPath
          : projectPath // ignore: cast_nullable_to_non_nullable
              as String?,
      packages: freezed == packages
          ? _value.packages
          : packages // ignore: cast_nullable_to_non_nullable
              as List<Package>?,
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
abstract class _$$_ProjectAnalysisBlocStateCopyWith<$Res>
    implements $ProjectAnalysisBlocStateCopyWith<$Res> {
  factory _$$_ProjectAnalysisBlocStateCopyWith(
          _$_ProjectAnalysisBlocState value,
          $Res Function(_$_ProjectAnalysisBlocState) then) =
      __$$_ProjectAnalysisBlocStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? projectPath,
      List<Package>? packages,
      List<ResolvedUnitResult>? resolvedUnitResults,
      bool isLoading,
      String? loadingError});
}

/// @nodoc
class __$$_ProjectAnalysisBlocStateCopyWithImpl<$Res>
    extends _$ProjectAnalysisBlocStateCopyWithImpl<$Res,
        _$_ProjectAnalysisBlocState>
    implements _$$_ProjectAnalysisBlocStateCopyWith<$Res> {
  __$$_ProjectAnalysisBlocStateCopyWithImpl(_$_ProjectAnalysisBlocState _value,
      $Res Function(_$_ProjectAnalysisBlocState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? projectPath = freezed,
    Object? packages = freezed,
    Object? resolvedUnitResults = freezed,
    Object? isLoading = null,
    Object? loadingError = freezed,
  }) {
    return _then(_$_ProjectAnalysisBlocState(
      projectPath: freezed == projectPath
          ? _value.projectPath
          : projectPath // ignore: cast_nullable_to_non_nullable
              as String?,
      packages: freezed == packages
          ? _value._packages
          : packages // ignore: cast_nullable_to_non_nullable
              as List<Package>?,
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

class _$_ProjectAnalysisBlocState extends _ProjectAnalysisBlocState
    with DiagnosticableTreeMixin {
  const _$_ProjectAnalysisBlocState(
      {required this.projectPath,
      required final List<Package>? packages,
      required final List<ResolvedUnitResult>? resolvedUnitResults,
      required this.isLoading,
      required this.loadingError})
      : _packages = packages,
        _resolvedUnitResults = resolvedUnitResults,
        super._();

  @override
  final String? projectPath;
  final List<Package>? _packages;
  @override
  List<Package>? get packages {
    final value = _packages;
    if (value == null) return null;
    if (_packages is EqualUnmodifiableListView) return _packages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

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
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProjectAnalysisBlocState(projectPath: $projectPath, packages: $packages, resolvedUnitResults: $resolvedUnitResults, isLoading: $isLoading, loadingError: $loadingError)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProjectAnalysisBlocState'))
      ..add(DiagnosticsProperty('projectPath', projectPath))
      ..add(DiagnosticsProperty('packages', packages))
      ..add(DiagnosticsProperty('resolvedUnitResults', resolvedUnitResults))
      ..add(DiagnosticsProperty('isLoading', isLoading))
      ..add(DiagnosticsProperty('loadingError', loadingError));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProjectAnalysisBlocState &&
            (identical(other.projectPath, projectPath) ||
                other.projectPath == projectPath) &&
            const DeepCollectionEquality().equals(other._packages, _packages) &&
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
      const DeepCollectionEquality().hash(_packages),
      const DeepCollectionEquality().hash(_resolvedUnitResults),
      isLoading,
      loadingError);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProjectAnalysisBlocStateCopyWith<_$_ProjectAnalysisBlocState>
      get copyWith => __$$_ProjectAnalysisBlocStateCopyWithImpl<
          _$_ProjectAnalysisBlocState>(this, _$identity);
}

abstract class _ProjectAnalysisBlocState extends ProjectAnalysisBlocState {
  const factory _ProjectAnalysisBlocState(
      {required final String? projectPath,
      required final List<Package>? packages,
      required final List<ResolvedUnitResult>? resolvedUnitResults,
      required final bool isLoading,
      required final String? loadingError}) = _$_ProjectAnalysisBlocState;
  const _ProjectAnalysisBlocState._() : super._();

  @override
  String? get projectPath;
  @override
  List<Package>? get packages;
  @override
  List<ResolvedUnitResult>? get resolvedUnitResults;
  @override
  bool get isLoading;
  @override
  String? get loadingError;
  @override
  @JsonKey(ignore: true)
  _$$_ProjectAnalysisBlocStateCopyWith<_$_ProjectAnalysisBlocState>
      get copyWith => throw _privateConstructorUsedError;
}
