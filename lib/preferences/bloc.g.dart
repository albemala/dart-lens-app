// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bloc.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreferencesState _$PreferencesStateFromJson(Map json) => PreferencesState(
      themeMode: $enumDecode(_$ThemeModeEnumMap, json['themeMode']),
      flutterBinaryPath: json['flutterBinaryPath'] as String,
    );

Map<String, dynamic> _$PreferencesStateToJson(PreferencesState instance) =>
    <String, dynamic>{
      'themeMode': _$ThemeModeEnumMap[instance.themeMode]!,
      'flutterBinaryPath': instance.flutterBinaryPath,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
