import 'package:dart_lens/about/functions.dart';
import 'package:dart_lens/app/defines.dart';
import 'package:dart_lens/assets.gen.dart';
import 'package:dart_lens/feedback.dart';
import 'package:dart_lens/urls/defines.dart';
import 'package:dart_lens/urls/functions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class AboutViewModel extends Equatable {
  final String appVersion;

  const AboutViewModel({
    required this.appVersion,
  });

  @override
  List<Object> get props => [
        appVersion,
      ];
}

class AboutViewBloc extends Cubit<AboutViewModel> {
  factory AboutViewBloc.fromContext(BuildContext context) {
    return AboutViewBloc();
  }

  AboutViewBloc()
      : super(
          const AboutViewModel(appVersion: '...'),
        ) {
    _init();
  }

  Future<void> _init() async {
    await _updateViewModel();
  }

  Future<void> _updateViewModel() async {
    emit(
      AboutViewModel(
        appVersion: await getAppVersion(),
      ),
    );
  }

  Future<void> openReleaseNotes() async {
    await openUrl(releaseNotesUrl);
  }

  Future<void> openOtherApps() async {
    await openUrl(otherProjectsUrl);
  }

  Future<void> openEmail() async {
    await sendFeedback();
  }

/*
  Future<void> openWebsite() async {
    await openUrl(repositoryUrl);
  }
*/

  Future<void> openIssues() async {
    await openUrl(issuesUrl);
  }

  Future<void> openTwitter() async {
    await openUrl(twitterUrl);
  }
}

class AboutViewBuilder extends StatelessWidget {
  const AboutViewBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AboutViewBloc>(
      create: AboutViewBloc.fromContext,
      child: BlocBuilder<AboutViewBloc, AboutViewModel>(
        builder: (context, viewModel) {
          return AboutView(
            bloc: context.read<AboutViewBloc>(),
            viewModel: viewModel,
          );
        },
      ),
    );
  }
}

class AboutView extends StatelessWidget {
  final AboutViewBloc bloc;
  final AboutViewModel viewModel;

  const AboutView({
    super.key,
    required this.bloc,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Assets.appIcon.image(
              width: 64,
              height: 64,
              filterQuality: FilterQuality.medium,
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appName,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Row(
                  children: [
                    Text(
                      viewModel.appVersion,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        OutlinedButton(
          onPressed: bloc.openReleaseNotes,
          child: const Text("What's new?"),
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: bloc.openOtherApps,
          child: const Text('Other useful apps'),
        ),
        const SizedBox(height: 32),
        Text(
          'Help & Support',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 16),
        OutlinedButton(
          onPressed: bloc.openEmail,
          child: const Text('Send feedback'),
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: bloc.openIssues,
          child: const Text('Report an issue'),
        ),
/*
      const SizedBox(height: 8),
      OutlinedButton(
        onPressed: ()  {
          bloc.openWebsite();
        },
        child: const Text('Visit website'),
      ),
*/
        const SizedBox(height: 32),
        Text(
          'News, Tips & Tricks',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 16),
        OutlinedButton(
          onPressed: bloc.openTwitter,
          child: const Text('Twitter'),
        ),
      ],
    );
  }
}
