/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsGoogleFontsGen {
  const $AssetsGoogleFontsGen();

  /// File path: assets/google-fonts/FiraSans-Black.ttf
  String get firaSansBlack => 'assets/google-fonts/FiraSans-Black.ttf';

  /// File path: assets/google-fonts/FiraSans-BlackItalic.ttf
  String get firaSansBlackItalic =>
      'assets/google-fonts/FiraSans-BlackItalic.ttf';

  /// File path: assets/google-fonts/FiraSans-Bold.ttf
  String get firaSansBold => 'assets/google-fonts/FiraSans-Bold.ttf';

  /// File path: assets/google-fonts/FiraSans-BoldItalic.ttf
  String get firaSansBoldItalic =>
      'assets/google-fonts/FiraSans-BoldItalic.ttf';

  /// File path: assets/google-fonts/FiraSans-ExtraBold.ttf
  String get firaSansExtraBold => 'assets/google-fonts/FiraSans-ExtraBold.ttf';

  /// File path: assets/google-fonts/FiraSans-ExtraBoldItalic.ttf
  String get firaSansExtraBoldItalic =>
      'assets/google-fonts/FiraSans-ExtraBoldItalic.ttf';

  /// File path: assets/google-fonts/FiraSans-ExtraLight.ttf
  String get firaSansExtraLight =>
      'assets/google-fonts/FiraSans-ExtraLight.ttf';

  /// File path: assets/google-fonts/FiraSans-ExtraLightItalic.ttf
  String get firaSansExtraLightItalic =>
      'assets/google-fonts/FiraSans-ExtraLightItalic.ttf';

  /// File path: assets/google-fonts/FiraSans-Italic.ttf
  String get firaSansItalic => 'assets/google-fonts/FiraSans-Italic.ttf';

  /// File path: assets/google-fonts/FiraSans-Light.ttf
  String get firaSansLight => 'assets/google-fonts/FiraSans-Light.ttf';

  /// File path: assets/google-fonts/FiraSans-LightItalic.ttf
  String get firaSansLightItalic =>
      'assets/google-fonts/FiraSans-LightItalic.ttf';

  /// File path: assets/google-fonts/FiraSans-Medium.ttf
  String get firaSansMedium => 'assets/google-fonts/FiraSans-Medium.ttf';

  /// File path: assets/google-fonts/FiraSans-MediumItalic.ttf
  String get firaSansMediumItalic =>
      'assets/google-fonts/FiraSans-MediumItalic.ttf';

  /// File path: assets/google-fonts/FiraSans-Regular.ttf
  String get firaSansRegular => 'assets/google-fonts/FiraSans-Regular.ttf';

  /// File path: assets/google-fonts/FiraSans-SemiBold.ttf
  String get firaSansSemiBold => 'assets/google-fonts/FiraSans-SemiBold.ttf';

  /// File path: assets/google-fonts/FiraSans-SemiBoldItalic.ttf
  String get firaSansSemiBoldItalic =>
      'assets/google-fonts/FiraSans-SemiBoldItalic.ttf';

  /// File path: assets/google-fonts/FiraSans-Thin.ttf
  String get firaSansThin => 'assets/google-fonts/FiraSans-Thin.ttf';

  /// File path: assets/google-fonts/FiraSans-ThinItalic.ttf
  String get firaSansThinItalic =>
      'assets/google-fonts/FiraSans-ThinItalic.ttf';

  /// File path: assets/google-fonts/OFL.txt
  String get ofl => 'assets/google-fonts/OFL.txt';

  /// List of all assets
  List<String> get values => [
        firaSansBlack,
        firaSansBlackItalic,
        firaSansBold,
        firaSansBoldItalic,
        firaSansExtraBold,
        firaSansExtraBoldItalic,
        firaSansExtraLight,
        firaSansExtraLightItalic,
        firaSansItalic,
        firaSansLight,
        firaSansLightItalic,
        firaSansMedium,
        firaSansMediumItalic,
        firaSansRegular,
        firaSansSemiBold,
        firaSansSemiBoldItalic,
        firaSansThin,
        firaSansThinItalic,
        ofl
      ];
}

class Assets {
  Assets._();

  static const AssetGenImage appIcon = AssetGenImage('assets/app-icon.png');
  static const $AssetsGoogleFontsGen googleFonts = $AssetsGoogleFontsGen();

  /// List of all assets
  List<AssetGenImage> get values => [appIcon];
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
