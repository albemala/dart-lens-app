import 'package:dart_lens/blocs/preferences-bloc.dart';
import 'package:dart_lens/functions/theme.dart';
import 'package:dart_lens/views/main-view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppView extends StatelessWidget {
  const AppView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final preferencesBloc = context.watch<PreferencesBloc>();

    return MaterialApp(
      title: 'Flutter Code Explorer',
      themeMode: preferencesBloc.state.themeMode,
      theme: generateLightThemeData(),
      darkTheme: generateDarkThemeData(),
      debugShowCheckedModeBanner: false,
      home: const MainView(),
    );
  }
}
