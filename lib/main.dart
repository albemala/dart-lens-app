import 'package:dart_lens/blocs/preferences-bloc.dart';
import 'package:dart_lens/blocs/project-analysis-bloc.dart';
import 'package:dart_lens/views/app-view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PreferencesBloc()),
        BlocProvider(create: (_) => ProjectAnalysisBloc()),
      ],
      child: const AppView(),
    ),
  );
}
