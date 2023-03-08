import 'package:dart_lens/blocs/preferences-bloc.dart';
import 'package:dart_lens/blocs/project-structure-bloc.dart';
import 'package:dart_lens/functions/fs.dart';
import 'package:dart_lens/views/project-structure/project-structure-view.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MainView extends HookWidget {
  const MainView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _TopView(),
          Expanded(
            child: ProjectStructureView(),
          ),
          _BottomView(),
        ],
      ),
    );
  }
}

class _TopView extends StatelessWidget {
  const _TopView();

  @override
  Widget build(BuildContext context) {
    final projectStructureBloc = context.watch<ProjectStructureBloc>();

    Future<void> onPickDirectory() async {
      final directory = await pickExistingDirectory();
      if (directory == null) return;
      await projectStructureBloc.setProjectPath(directory);
    }

    return Material(
      child: Padding(
        padding: const EdgeInsets.all(16),
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
                projectStructureBloc.state.projectPath ?? '',
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (projectStructureBloc.state.isLoading)
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(),
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
