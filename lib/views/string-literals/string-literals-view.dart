import 'package:dart_lens/functions/clipboard.dart';
import 'package:dart_lens/views/string-literals/string-literals-view-bloc.dart';
import 'package:dart_lens/widgets/button.dart';
import 'package:flextras/flextras.dart';
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
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: viewModel.stringLiterals.length,
      itemBuilder: (context, index) {
        final dependency = viewModel.stringLiterals[index];
        return SeparatedRow(
          padding: const EdgeInsets.symmetric(vertical: 4),
          children: [
            SmallButtonWidget(
              onPressed: () {
                copyToClipboard(context, dependency.string);
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
          separatorBuilder: () => const SizedBox(width: 8),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
