import 'package:dart_lens/conductors/local-storage-conductor.dart';
import 'package:dart_lens/conductors/preferences-conductor.dart';
import 'package:dart_lens/conductors/project-analysis-conductor.dart';
import 'package:dart_lens/conductors/routing-conductor.dart';
import 'package:dart_lens/functions/theme.dart';
import 'package:dart_lens/views/app-content-view.dart';
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
        ChangeNotifierProvider(create: RoutingConductor.fromContext),
        ChangeNotifierProvider(create: LocalStorageConductor.fromContext),
        ChangeNotifierProvider(create: PreferencesConductor.fromContext),
        ChangeNotifierProvider(create: ProjectAnalysisConductor.fromContext),
      ],
      child: Consumer<PreferencesConductor>(
        builder: (context, preferencesConductor, child) {
          return MaterialApp(
            title: 'Flutter Code Explorer',
            themeMode: preferencesConductor.themeMode,
            theme: generateLightThemeData(),
            darkTheme: generateDarkThemeData(),
            debugShowCheckedModeBanner: false,
            home: Consumer<RoutingConductor>(
              builder: (context, routingConductor, child) {
                return RoutingView(
                  routingStream: routingConductor.routingStream,
                  child: const AppContentView(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
