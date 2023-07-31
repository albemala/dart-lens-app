import 'package:flutter/material.dart';

class PreferencesConductor extends ChangeNotifier {
  factory PreferencesConductor.fromContext(BuildContext context) {
    return PreferencesConductor();
  }

  PreferencesConductor();

  var _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleThemeMode() {
    _themeMode = _themeMode == ThemeMode.light //
        ? ThemeMode.dark
        : ThemeMode.light;
    notifyListeners();
  }
}
