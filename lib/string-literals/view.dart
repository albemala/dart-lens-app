import 'package:dart_lens/string-literals/bloc.dart';
import 'package:dart_lens/widgets/button.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class StringLiteralsViewBuilder extends StatelessWidget {
  const StringLiteralsViewBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StringLiteralsViewBloc>(
      create: StringLiteralsViewBloc.fromContext,
      child: BlocBuilder<StringLiteralsViewBloc, StringLiteralsViewModel>(
        builder: (context, viewModel) {
          return StringLiteralsView(
            bloc: context.read<StringLiteralsViewBloc>(),
            viewModel: viewModel,
          );
        },
      ),
    );
  }
}

class StringLiteralsView extends StatelessWidget {
  final StringLiteralsViewBloc bloc;
  final StringLiteralsViewModel viewModel;

  const StringLiteralsView({
    super.key,
    required this.bloc,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        _ActionBarView(
          isLoading: viewModel.isLoading,
          onReload: bloc.reload,
        ),
        const Divider(),
        Expanded(
          child: _StringLiteralsListView(
            stringLiterals: viewModel.stringLiterals,
            onCopy: (string) {
              bloc.copyStringToClipboard(context, string);
            },
          ),
        ),
      ],
    );
  }
}

class _ActionBarView extends StatelessWidget {
  final bool isLoading;
  final void Function() onReload;

  const _ActionBarView({
    required this.isLoading,
    required this.onReload,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: SeparatedRow(
          separatorBuilder: () => const SizedBox(width: 8),
          children: [
            const Spacer(),
            if (isLoading) //
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            Tooltip(
              message: 'Reload project',
              child: IconButton(
                onPressed: onReload,
                icon: const Icon(LucideIcons.rotateCw),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StringLiteralsListView extends StatelessWidget {
  final List<StringLiteral> stringLiterals;
  final void Function(String) onCopy;

  const _StringLiteralsListView({
    required this.stringLiterals,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      separatorBuilder: (context, index) => const Divider(),
      itemCount: stringLiterals.length,
      itemBuilder: (context, index) {
        final dependency = stringLiterals[index];
        return Builder(
          builder: (context) {
            return SeparatedRow(
              padding: const EdgeInsets.symmetric(vertical: 4),
              separatorBuilder: () => const SizedBox(width: 8),
              children: [
                SmallButtonWidget(
                  onPressed: () {
                    onCopy(dependency.string);
                  },
                  backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                  tooltip: 'Click to copy',
                  child: Text(
                    dependency.path,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                Flexible(
                  child: Text(
                    dependency.string,
                    style: GoogleFonts.firaCode(
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
