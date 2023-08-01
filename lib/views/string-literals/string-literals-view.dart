import 'package:dart_lens/functions/clipboard.dart';
import 'package:dart_lens/views/string-literals/string-literals-view-conductor.dart';
import 'package:dart_lens/widgets/button.dart';
import 'package:flextras/flextras.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StringLiteralsView extends StatelessWidget {
  const StringLiteralsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StringLiteralsViewConductor>(
      create: StringLiteralsViewConductor.fromContext,
      child: const Column(
        children: [
          Divider(),
          _ActionBarView(),
          Divider(),
          Expanded(
            child: _StringLiteralsListView(),
          ),
        ],
      ),
    );
  }
}

class _ActionBarView extends StatelessWidget {
  const _ActionBarView();

  @override
  Widget build(BuildContext context) {
    return Consumer<StringLiteralsViewConductor>(
      builder: (context, conductor, child) {
        return Material(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: SeparatedRow(
              separatorBuilder: () => const SizedBox(width: 8),
              children: [
                const Spacer(),
                if (conductor.isLoading) //
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
                      conductor.reload();
                    },
                    icon: const Icon(CupertinoIcons.arrow_clockwise),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _StringLiteralsListView extends StatelessWidget {
  const _StringLiteralsListView();

  @override
  Widget build(BuildContext context) {
    return Consumer<StringLiteralsViewConductor>(
      builder: (context, conductor, child) {
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: conductor.stringLiterals.length,
          itemBuilder: (context, index) {
            final dependency = conductor.stringLiterals[index];
            return Builder(
              builder: (context) {
                return SeparatedRow(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  separatorBuilder: () => const SizedBox(width: 8),
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
                );
              },
            );
          },
        );
      },
    );
  }
}
