import 'package:dart_lens/about/view.dart';
import 'package:dart_lens/app/defines.dart';
import 'package:dart_lens/feedback.dart';
import 'package:dart_lens/preferences/view.dart';
import 'package:dart_lens/routing/functions.dart';
import 'package:dart_lens/widgets/dialog.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';

@immutable
class AppBottomViewModel extends Equatable {
  const AppBottomViewModel();

  @override
  List<Object?> get props => [];
}

class AppBottomViewBloc extends Cubit<AppBottomViewModel> {
  factory AppBottomViewBloc.fromContext(BuildContext context) {
    return AppBottomViewBloc();
  }

  AppBottomViewBloc()
      : super(
          const AppBottomViewModel(),
        );

  void openPreferencesDialog(BuildContext context) {
    openDialog(
      context,
      createAlertDialog(
        title: 'Preferences',
        content: const PreferencesViewBuilder(),
        onClose: () {
          closeCurrentRoute(context);
        },
      ),
    );
  }

  void openAboutDialog(BuildContext context) {
    openDialog(
      context,
      createAlertDialog(
        title: 'About',
        content: const AboutViewBuilder(),
        onClose: () {
          closeCurrentRoute(context);
        },
      ),
    );
  }
}

class AppBottomViewBuilder extends StatelessWidget {
  const AppBottomViewBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBottomViewBloc>(
      create: AppBottomViewBloc.fromContext,
      child: BlocBuilder<AppBottomViewBloc, AppBottomViewModel>(
        builder: (context, viewModel) {
          return AppBottomView(
            bloc: context.read<AppBottomViewBloc>(),
          );
        },
      ),
    );
  }
}

class AppBottomView extends StatelessWidget {
  final AppBottomViewBloc bloc;

  const AppBottomView({
    super.key,
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            TextButton.icon(
              onPressed: sendFeedback,
              icon: const Icon(LucideIcons.mail),
              label: const Text('Send feedback'),
            ),
            Tooltip(
              message: 'Preferences',
              child: IconButton(
                onPressed: () {
                  bloc.openPreferencesDialog(context);
                },
                icon: const Icon(LucideIcons.settings),
              ),
            ),
            Tooltip(
              message: 'About $appName',
              child: IconButton(
                onPressed: () {
                  bloc.openAboutDialog(context);
                },
                icon: const Icon(LucideIcons.info),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
