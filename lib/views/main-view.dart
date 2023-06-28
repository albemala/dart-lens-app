import 'package:dart_lens/blocs/preferences-bloc.dart';
import 'package:dart_lens/blocs/project-analysis-bloc.dart';
import 'package:dart_lens/defines/app.dart';
import 'package:dart_lens/functions/feedback.dart';
import 'package:dart_lens/functions/fs.dart';
import 'package:dart_lens/views/about-view.dart';
import 'package:dart_lens/views/project-packages/project-packages-view.dart';
import 'package:dart_lens/views/project-structure/project-structure-view.dart';
import 'package:dart_lens/views/string-literals/string-literals-view.dart';
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
    return const DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TopView(),
            Divider(),
            TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: 'Packages'),
                Tab(text: 'Project structure'),
                Tab(text: 'String literals'),
              ],
            ),
            Expanded(
              child: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ProjectPackagesView(),
                  ProjectStructureView(),
                  StringLiteralsView(),
                ],
              ),
            ),
            Divider(),
            _BottomView(),
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
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SeparatedRow(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: [
            const Text(
              'Project directory:',
            ),
            Expanded(
              child: projectAnalysisBloc.state.projectPath == null ||
                      projectAnalysisBloc.state.projectPath!.isEmpty
                  ? const Opacity(
                      opacity: 0.7,
                      child: Text(
                        'No project selected',
                      ),
                    )
                  : Text(
                      projectAnalysisBloc.state.projectPath ?? '',
                      overflow: TextOverflow.ellipsis,
                    ),
            ),
            if (projectAnalysisBloc.state.projectPath == null ||
                projectAnalysisBloc.state.projectPath!.isEmpty)
              FilledButton(
                onPressed: onPickDirectory,
                child: const Text('Select'),
              )
            else
              OutlinedButton(
                onPressed: onPickDirectory,
                child: const Text('Select'),
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
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            TextButton.icon(
              onPressed: sendFeedback,
              icon: const Icon(CupertinoIcons.mail),
              label: const Text('Send feedback'),
            ),
            IconButton(
              onPressed: () {
                context.read<PreferencesBloc>().toggleThemeMode();
              },
              icon: preferencesBloc.state.themeMode == ThemeMode.light
                  ? const Icon(CupertinoIcons.brightness)
                  : const Icon(CupertinoIcons.moon),
            ),
            Tooltip(
              message: 'About $appName',
              child: IconButton(
                onPressed: () {
                  AboutView.show(context);
                },
                icon: const Icon(CupertinoIcons.info),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
