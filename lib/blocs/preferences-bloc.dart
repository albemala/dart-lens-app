import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'preferences-bloc.freezed.dart';

@freezed
class PreferencesState with _$PreferencesState {
  const PreferencesState._();

  const factory PreferencesState({
    required ThemeMode themeMode,
    // required FlexScheme flexScheme,
  }) = _PreferencesState;
}

class PreferencesBloc extends Cubit<PreferencesState> {
  PreferencesBloc()
      : super(
          const PreferencesState(
            themeMode: ThemeMode.light,
            // flexScheme: FlexScheme.materialBaseline,
          ),
        );

  void toggleThemeMode() {
    setThemeMode(
      state.themeMode == ThemeMode.light //
          ? ThemeMode.dark
          : ThemeMode.light,
    );
  }

  void setThemeMode(ThemeMode themeMode) {
    emit(
      state.copyWith(
        themeMode: themeMode,
      ),
    );
  }

  // void setFlexScheme(FlexScheme flexScheme) {
  //   emit(
  //     state.copyWith(
  //       flexScheme: flexScheme,
  //     ),
  //   );
  // }
}
