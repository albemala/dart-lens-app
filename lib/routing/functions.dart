import 'package:flutter/material.dart';

void showSnackBar(
  BuildContext context,
  SnackBar snackBar,
) {
  if (!context.mounted) return;
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(snackBar);
}

void openDialog(
  BuildContext context,
  AlertDialog dialog,
) {
  if (!context.mounted) return;
  showDialog<void>(
    context: context,
    builder: (_) => dialog,
  );
}

void openBottomSheet(
  BuildContext context,
  Widget bottomSheet,
) {
  if (!context.mounted) return;
  showModalBottomSheet<void>(
    context: context,
    builder: (_) => bottomSheet,
  );
}

void openRoute(
  BuildContext context,
  Widget route,
) {
  if (!context.mounted) return;
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) => route,
    ),
  );
}

void closeCurrentRoute(BuildContext context) {
  Navigator.of(context).pop();
}
