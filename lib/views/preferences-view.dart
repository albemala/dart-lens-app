import 'package:dart_lens/conductors/preferences-conductor.dart';
import 'package:dart_lens/functions/commands.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

class PreferencesView extends StatelessWidget {
  static AlertDialog create(
    BuildContext context, {
    required void Function() onClose,
  }) {
    return AlertDialog(
      title: Text(
        'Preferences',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      content: const PreferencesView(),
      actions: [
        TextButton(
          onPressed: onClose,
          child: const Text('Close'),
        ),
      ],
    );
  }

  const PreferencesView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesConductor>(
      builder: (context, conductor, child) {
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
                        controller: conductor.flutterBinaryPathController,
                        onChanged: (value) {
                          conductor.setFlutterBinaryPath(value);
                        },
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
                    onPressed: () {
                      conductor.pickFlutterBinaryPath();
                    },
                    child: const Text('Choose...'),
                  ),
                ],
              ),
              if (conductor.flutterBinaryPath.isEmpty)
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
                            color:
                                Theme.of(context).colorScheme.onErrorContainer,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              '''
Please enter the path to the Flutter binary on your machine. This is required for the app to function properly.''',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onErrorContainer,
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
                    groupValue: conductor.themeMode,
                    onChanged: (value) {
                      if (value == null) return;
                      conductor.setThemeMode(value);
                    },
                  ),
                  const Text('Light'),
                  const SizedBox(width: 16),
                  Radio(
                    value: ThemeMode.dark,
                    groupValue: conductor.themeMode,
                    onChanged: (value) {
                      if (value == null) return;
                      conductor.setThemeMode(value);
                    },
                  ),
                  const Text('Dark'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
