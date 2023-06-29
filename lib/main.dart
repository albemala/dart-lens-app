import 'package:dart_lens/blocs/preferences-bloc.dart';
import 'package:dart_lens/blocs/project-analysis-bloc.dart';
import 'package:dart_lens/views/app-view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  GoogleFonts.config.allowRuntimeFetching = false;

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
