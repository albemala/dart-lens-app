import 'package:dart_lens/blocs/preferences-bloc.dart';
import 'package:dart_lens/functions/theme.dart';
import 'package:dart_lens/views/main-view.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppView extends StatelessWidget {
  const AppView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final preferencesBloc = context.watch<PreferencesBloc>();

    const flexScheme = FlexScheme.materialHc;
    final lightTheme = generateLightThemeData(flexScheme);
    final darkTheme = generateDarkThemeData(flexScheme);

    return MaterialApp(
      title: 'Flutter Code Explorer',
      themeMode: preferencesBloc.state.themeMode,
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      home: const MainView(),
    );
  }
}
