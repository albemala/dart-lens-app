import 'package:flutter/material.dart';

AlertDialog createAlertDialog({
  required String title,
  required Widget content,
  required void Function() onClose,
}) {
  return AlertDialog(
    title: Builder(
      builder: (context) {
        return Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        );
      },
    ),
    content: content,
    actions: [
      TextButton(
        onPressed: onClose,
        child: const Text('Close'),
      ),
    ],
  );
}
