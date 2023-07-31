import 'package:dart_lens/assets/assets.gen.dart';
import 'package:dart_lens/defines/app.dart';
import 'package:dart_lens/defines/urls.dart';
import 'package:dart_lens/functions/app.dart';
import 'package:dart_lens/functions/feedback.dart';
import 'package:dart_lens/functions/url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AboutView extends HookWidget {
  static Future<void> show(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'About',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          content: const AboutView(),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  const AboutView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appVersion = useFuture(getAppVersion());

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
                      appVersion.data ?? '',
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
          onPressed: () async {
            await openUrl(releaseNotesUrl);
          },
          child: const Text("What's new?"),
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: () async {
            await openUrl(otherProjectsUrl);
          },
          child: const Text('Other useful apps'),
        ),
        const SizedBox(height: 32),
        Text(
          'Help & Support',
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(height: 16),
        OutlinedButton(
          onPressed: () async {
            await sendFeedback();
          },
          child: const Text('Send feedback'),
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: () async {
            await openUrl(issuesUrl);
          },
          child: const Text('Report an issue'),
        ),
/*
        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: () async {
            await openUrl(websiteUrl);
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
          onPressed: () async {
            await openUrl(twitterUrl);
          },
          child: const Text('Twitter'),
        ),
      ],
    );
  }
}
