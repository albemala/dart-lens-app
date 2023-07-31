import 'package:dart_lens/conductors/preferences-conductor.dart';
import 'package:dart_lens/conductors/project-analysis-conductor.dart';
import 'package:dart_lens/functions/theme.dart';
import 'package:dart_lens/views/main-view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppView extends StatelessWidget {
  const AppView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: PreferencesConductor.fromContext),
        ChangeNotifierProvider(create: ProjectAnalysisConductor.fromContext),
      ],
      child: Consumer<PreferencesConductor>(
        builder: (context, conductor, child) {
          return MaterialApp(
            title: 'Flutter Code Explorer',
            themeMode: conductor.themeMode,
            theme: generateLightThemeData(),
            darkTheme: generateDarkThemeData(),
            debugShowCheckedModeBanner: false,
            home: const MainView(),
          );
        },
      ),
    );
  }
}
