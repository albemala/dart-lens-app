import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';

Future<void> copyToClipboard(BuildContext context, String text) async {
  if (text.isEmpty) return;
  await FlutterClipboard.copy(text);
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Copied to clipboard 👍'),
      behavior: SnackBarBehavior.floating,
      width: 240,
      duration: Duration(seconds: 3),
    ),
  );
}
