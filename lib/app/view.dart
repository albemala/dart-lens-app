import 'package:dart_lens/app-content/view.dart';
import 'package:dart_lens/app/theme.dart';
import 'package:dart_lens/local-store/bloc.dart';
import 'package:dart_lens/preferences/bloc.dart';
import 'package:dart_lens/project-analysis/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppView extends StatelessWidget {
  const AppView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: const [
        BlocProvider(create: LocalStoreBloc.fromContext),
        BlocProvider(create: PreferencesBloc.fromContext),
        BlocProvider(create: ProjectAnalysisBloc.fromContext),
      ],
      child: BlocBuilder<PreferencesBloc, PreferencesState>(
        builder: (context, preferences) {
          return MaterialApp(
            title: 'Flutter Code Explorer',
            themeMode: preferences.themeMode,
            theme: generateLightThemeData(),
            darkTheme: generateDarkThemeData(),
            debugShowCheckedModeBanner: false,
            home: const AppContentView(),
          );
        },
      ),
    );
  }
}
