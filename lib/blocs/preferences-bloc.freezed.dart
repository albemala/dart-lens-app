// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'preferences-bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$PreferencesState {
  ThemeMode get themeMode => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PreferencesStateCopyWith<PreferencesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PreferencesStateCopyWith<$Res> {
  factory $PreferencesStateCopyWith(
          PreferencesState value, $Res Function(PreferencesState) then) =
      _$PreferencesStateCopyWithImpl<$Res, PreferencesState>;
  @useResult
  $Res call({ThemeMode themeMode});
}

/// @nodoc
class _$PreferencesStateCopyWithImpl<$Res, $Val extends PreferencesState>
    implements $PreferencesStateCopyWith<$Res> {
  _$PreferencesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
  }) {
    return _then(_value.copyWith(
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PreferencesStateCopyWith<$Res>
    implements $PreferencesStateCopyWith<$Res> {
  factory _$$_PreferencesStateCopyWith(
          _$_PreferencesState value, $Res Function(_$_PreferencesState) then) =
      __$$_PreferencesStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ThemeMode themeMode});
}

/// @nodoc
class __$$_PreferencesStateCopyWithImpl<$Res>
    extends _$PreferencesStateCopyWithImpl<$Res, _$_PreferencesState>
    implements _$$_PreferencesStateCopyWith<$Res> {
  __$$_PreferencesStateCopyWithImpl(
      _$_PreferencesState _value, $Res Function(_$_PreferencesState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
  }) {
    return _then(_$_PreferencesState(
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
    ));
  }
}

/// @nodoc

class _$_PreferencesState extends _PreferencesState {
  const _$_PreferencesState({required this.themeMode}) : super._();

  @override
  final ThemeMode themeMode;

  @override
  String toString() {
    return 'PreferencesState(themeMode: $themeMode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PreferencesState &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, themeMode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PreferencesStateCopyWith<_$_PreferencesState> get copyWith =>
      __$$_PreferencesStateCopyWithImpl<_$_PreferencesState>(this, _$identity);
}

abstract class _PreferencesState extends PreferencesState {
  const factory _PreferencesState({required final ThemeMode themeMode}) =
      _$_PreferencesState;
  const _PreferencesState._() : super._();

  @override
  ThemeMode get themeMode;
  @override
  @JsonKey(ignore: true)
  _$$_PreferencesStateCopyWith<_$_PreferencesState> get copyWith =>
      throw _privateConstructorUsedError;
}
