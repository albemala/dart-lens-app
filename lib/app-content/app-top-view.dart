import 'package:dart_lens/project-analysis/bloc.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppTopViewBuilder extends StatelessWidget {
  const AppTopViewBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectAnalysisBloc, ProjectAnalysisState>(
      builder: (context, state) {
        return AppTopView(
          bloc: context.read<ProjectAnalysisBloc>(),
          viewModel: state,
        );
      },
    );
  }
}

class AppTopView extends StatelessWidget {
  final ProjectAnalysisBloc bloc;
  final ProjectAnalysisState viewModel;

  const AppTopView({
    super.key,
    required this.bloc,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SeparatedRow(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          separatorBuilder: () => const SizedBox(width: 8),
          children: [
            const Text(
              'Project directory:',
            ),
            Expanded(
              child: viewModel.projectPath.isEmpty
                  ? const Opacity(
                      opacity: 0.7,
                      child: Text(
                        'No project selected',
                      ),
                    )
                  : Text(
                      viewModel.projectPath,
                      overflow: TextOverflow.ellipsis,
                    ),
            ),
            if (viewModel.projectPath.isEmpty)
              FilledButton(
                onPressed: bloc.pickDirectory,
                child: const Text('Select'),
              )
            else
              OutlinedButton(
                onPressed: bloc.pickDirectory,
                child: const Text('Select'),
              ),
          ],
        ),
      ),
    );
  }
}
