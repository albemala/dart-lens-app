import 'package:flutter/material.dart';

SnackBar createCopiedToClipboardSnackBar() {
  return const SnackBar(
    content: Text('Copied to clipboard 👍'),
    behavior: SnackBarBehavior.floating,
    width: 240,
    duration: Duration(seconds: 3),
  );
}
