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
  $Res call({String? projectPath});
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
  }) {
    return _then(_value.copyWith(
      projectPath: freezed == projectPath
          ? _value.projectPath
          : projectPath // ignore: cast_nullable_to_non_nullable
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
  $Res call({String? projectPath});
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
  }) {
    return _then(_$_ProjectAnalysisBlocState(
      projectPath: freezed == projectPath
          ? _value.projectPath
          : projectPath // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_ProjectAnalysisBlocState extends _ProjectAnalysisBlocState
    with DiagnosticableTreeMixin {
  const _$_ProjectAnalysisBlocState({required this.projectPath}) : super._();

  @override
  final String? projectPath;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProjectAnalysisBlocState(projectPath: $projectPath)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProjectAnalysisBlocState'))
      ..add(DiagnosticsProperty('projectPath', projectPath));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProjectAnalysisBlocState &&
            (identical(other.projectPath, projectPath) ||
                other.projectPath == projectPath));
  }

  @override
  int get hashCode => Object.hash(runtimeType, projectPath);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProjectAnalysisBlocStateCopyWith<_$_ProjectAnalysisBlocState>
      get copyWith => __$$_ProjectAnalysisBlocStateCopyWithImpl<
          _$_ProjectAnalysisBlocState>(this, _$identity);
}

abstract class _ProjectAnalysisBlocState extends ProjectAnalysisBlocState {
  const factory _ProjectAnalysisBlocState(
      {required final String? projectPath}) = _$_ProjectAnalysisBlocState;
  const _ProjectAnalysisBlocState._() : super._();

  @override
  String? get projectPath;
  @override
  @JsonKey(ignore: true)
  _$$_ProjectAnalysisBlocStateCopyWith<_$_ProjectAnalysisBlocState>
      get copyWith => throw _privateConstructorUsedError;
}
