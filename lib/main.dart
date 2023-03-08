import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dart_lens/blocs/preferences-bloc.dart';
import 'package:dart_lens/blocs/project-structure-bloc.dart';
import 'package:dart_lens/views/app-view.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => PreferencesBloc()),
        BlocProvider(create: (_) => ProjectStructureBloc()),
      ],
      child: const AppView(),
    ),
  );
}
