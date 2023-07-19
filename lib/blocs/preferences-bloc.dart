import 'package:dart_lens/blocs/bloc-value.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class PreferencesState extends Equatable {
  final ThemeMode themeMode;

  const PreferencesState({
    required this.themeMode,
  });

  @override
  List<Object?> get props => [
        themeMode,
      ];
}

const _defaultThemeMode = ThemeMode.light;

class PreferencesBloc extends Cubit<PreferencesState> {
  late final BlocValue<ThemeMode> _themeMode;

  PreferencesBloc()
      : super(
          const PreferencesState(
            themeMode: _defaultThemeMode,
          ),
        ) {
    _themeMode = BlocValue<ThemeMode>(
      initialValue: _defaultThemeMode,
      onChange: _updateState,
    );
  }

  @override
  Future<void> close() {
    _themeMode.dispose();
    return super.close();
  }

  void _updateState() {
    emit(
      PreferencesState(
        themeMode: _themeMode.value,
      ),
    );
  }

  void toggleThemeMode() {
    _themeMode.value = _themeMode.value == ThemeMode.light //
        ? ThemeMode.dark
        : ThemeMode.light;
  }
}
