import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const _surfaceMode = FlexSurfaceMode.level;
const _blendLevel = 4;
const _subThemesData = FlexSubThemesData(
  blendOnLevel: 4,
  // defaultRadius: 0,
);
const _visualDensity = VisualDensity.compact;
final _fontFamily = GoogleFonts.firaSans().fontFamily;
// const _fontFamily = 'WorkSans';

ThemeData generateLightThemeData(
  FlexScheme flexScheme,
) {
  return _setupThemeData(
    FlexThemeData.light(
      scheme: flexScheme,
      surfaceMode: _surfaceMode,
      blendLevel: _blendLevel,
      subThemesData: _subThemesData,
      visualDensity: _visualDensity,
      fontFamily: _fontFamily,
      // useMaterial3: true,
    ),
  );
}

ThemeData generateDarkThemeData(
  FlexScheme flexScheme,
) {
  return _setupThemeData(
    FlexThemeData.dark(
      scheme: flexScheme,
      surfaceMode: _surfaceMode,
      blendLevel: _blendLevel,
      subThemesData: _subThemesData,
      visualDensity: _visualDensity,
      fontFamily: _fontFamily,
      // useMaterial3: true,
    ),
  );
}

ThemeData _setupThemeData(ThemeData themeData) {
  return themeData.copyWith(
      // iconTheme: const IconThemeData(size: 21),
      );
}
