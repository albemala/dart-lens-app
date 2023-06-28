import 'package:dart_lens/functions/clipboard.dart';
import 'package:dart_lens/views/string-literals/string-literals-view-bloc.dart';
import 'package:dart_lens/widgets/button.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class StringLiteralsView extends StatelessWidget {
  const StringLiteralsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: StringLiteralsViewBloc.new,
      child: BlocBuilder<StringLiteralsViewBloc, StringLiteralsViewModel>(
        builder: _buildView,
      ),
    );
  }

  Widget _buildView(BuildContext context, StringLiteralsViewModel viewModel) {
    return Column(
      children: [
        const Divider(),
        Material(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: SeparatedRow(
              children: [
                const Spacer(),
                if (viewModel.isLoading) //
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
                    onPressed: () {
                      context //
                          .read<StringLiteralsViewBloc>()
                          .reload();
                    },
                    icon: const Icon(CupertinoIcons.arrow_clockwise),
                  ),
                ),
              ],
              separatorBuilder: () => const SizedBox(width: 8),
            ),
          ),
        ),
        const Divider(),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: viewModel.stringLiterals.length,
            itemBuilder: (context, index) {
              final dependency = viewModel.stringLiterals[index];
              return Builder(
                builder: (context) {
                  return SeparatedRow(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    children: [
                      SmallButtonWidget(
                        onPressed: () {
                          copyToClipboard(context, dependency.path);
                        },
                        backgroundColor:
                            Theme.of(context).colorScheme.surfaceVariant,
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
                    separatorBuilder: () => const SizedBox(width: 8),
                  );
                },
              );
            },
            separatorBuilder: (context, index) => const Divider(),
          ),
        ),
      ],
    );
  }
}
