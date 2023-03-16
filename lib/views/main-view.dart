import 'package:dart_lens/blocs/preferences-bloc.dart';
import 'package:dart_lens/blocs/project-analysis-bloc.dart';
import 'package:dart_lens/functions/fs.dart';
import 'package:dart_lens/views/project-packages/project-packages-view.dart';
import 'package:dart_lens/views/project-structure/project-structure-view.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainView extends StatelessWidget {
  const MainView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final projectAnalysisBloc = context.watch<ProjectAnalysisBloc>();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _TopView(),
            const Divider(),
            const TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: 'Packages'),
                Tab(text: 'Project structure'),
              ],
            ),
            Expanded(
              child: Stack(
                children: [
                  const TabBarView(
                    children: [
                      ProjectPackagesView(),
                      ProjectStructureView(),
                    ],
                  ),
                  if (projectAnalysisBloc.state.isLoading)
                    ColoredBox(
                      color: Theme.of(context)
                          .colorScheme
                          .inverseSurface
                          .withOpacity(0.3),
                      child: const Center(
                        child: SizedBox(
                          width: 32,
                          height: 32,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const Divider(),
            const _BottomView(),
          ],
        ),
      ),
    );
  }
}

class _TopView extends StatelessWidget {
  const _TopView();

  @override
  Widget build(BuildContext context) {
    final projectAnalysisBloc = context.watch<ProjectAnalysisBloc>();

    Future<void> onPickDirectory() async {
      final directory = await pickExistingDirectory();
      if (directory == null) return;
      await projectAnalysisBloc.setProjectPath(directory);
    }

    return Material(
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SeparatedRow(
          children: [
            const Text(
              'Project directory:',
            ),
            ElevatedButton(
              onPressed: onPickDirectory,
              child: const Text('Select'),
            ),
            Expanded(
              child: Text(
                projectAnalysisBloc.state.projectPath ?? '',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (projectAnalysisBloc.state.isLoading)
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(),
              ),
            if (projectAnalysisBloc.state.projectPath != null &&
                projectAnalysisBloc.state.projectPath!.isNotEmpty)
              // button to reload the project
              IconButton(
                onPressed: projectAnalysisBloc.reloadProject,
                icon: const Icon(CupertinoIcons.arrow_clockwise),
              ),
          ],
          separatorBuilder: () => const SizedBox(width: 8),
        ),
      ),
    );
  }
}

class _BottomView extends StatelessWidget {
  const _BottomView();

  @override
  Widget build(BuildContext context) {
    final preferencesBloc = context.watch<PreferencesBloc>();

    return Material(
      color: Theme.of(context).colorScheme.surfaceVariant,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                context.read<PreferencesBloc>().toggleThemeMode();
              },
              icon: preferencesBloc.state.themeMode == ThemeMode.light
                  ? const Icon(CupertinoIcons.brightness)
                  : const Icon(CupertinoIcons.moon),
            ),
          ],
        ),
      ),
    );
  }
}
