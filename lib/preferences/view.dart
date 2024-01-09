import 'package:dart_lens/commands.dart';
import 'package:dart_lens/preferences/bloc.dart';
import 'package:dart_lens/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PreferencesViewBuilder extends StatelessWidget {
  const PreferencesViewBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PreferencesBloc, PreferencesState>(
      builder: (context, state) {
        return PreferencesView(
          bloc: context.read<PreferencesBloc>(),
          viewModel: state,
        );
      },
    );
  }
}

class PreferencesView extends StatelessWidget {
  static AlertDialog create(
    BuildContext context, {
    required void Function() onClose,
  }) {
    return createAlertDialog(
      title: 'Preferences',
      content: const PreferencesViewBuilder(),
      onClose: onClose,
    );
  }

  final PreferencesBloc bloc;
  final PreferencesState viewModel;

  const PreferencesView({
    super.key,
    required this.bloc,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 480,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shell commands',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: TextEditingController(
              text: shell,
            ),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(12),
              labelText: 'Shell',
            ),
            readOnly: true,
            enabled: false,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 360,
                  ),
                  child: TextField(
                    controller: bloc.flutterBinaryPathController,
                    onChanged: bloc.setFlutterBinaryPath,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      labelText: 'Flutter binary path',
                      hintText: '/path/to/flutter/bin',
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              OutlinedButton(
                onPressed: bloc.pickFlutterBinaryPath,
                child: const Text('Choose...'),
              ),
            ],
          ),
          if (viewModel.flutterBinaryPath.isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: ColoredBox(
                color: Theme.of(context).colorScheme.errorContainer,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.alertTriangle,
                        color: Theme.of(context).colorScheme.onErrorContainer,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '''
Please enter the path to the Flutter binary on your machine. This is required for the app to function properly.''',
                          style: TextStyle(
                            color:
                                Theme.of(context).colorScheme.onErrorContainer,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          const SizedBox(height: 24),
          Text(
            'App theme',
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Radio(
                value: ThemeMode.light,
                groupValue: viewModel.themeMode,
                onChanged: (value) {
                  if (value == null) return;
                  bloc.setThemeMode(value);
                },
              ),
              const Text('Light'),
              const SizedBox(width: 16),
              Radio(
                value: ThemeMode.dark,
                groupValue: viewModel.themeMode,
                onChanged: (value) {
                  if (value == null) return;
                  bloc.setThemeMode(value);
                },
              ),
              const Text('Dark'),
            ],
          ),
        ],
      ),
    );
  }
}
