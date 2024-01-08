import 'dart:io';

final shell = Platform.environment['SHELL'] ?? '';

Future<ProcessResult> runFlutterPubGet({
  required String flutterBinaryPath,
  required String workingDirectory,
}) async {
  final processResult = await Process.run(
    shell,
    ['-c', '$flutterBinaryPath pub get'],
    workingDirectory: workingDirectory,
  );
  return processResult;
}

Future<ProcessResult> runFlutterPubOutdated({
  required String flutterBinaryPath,
  required String workingDirectory,
}) async {
  return Process.run(
    shell,
    ['-c', '$flutterBinaryPath pub outdated --json'],
    workingDirectory: workingDirectory,
  );
}

Future<ProcessResult> runFlutterDoctor({
  required String flutterBinaryPath,
}) async {
  return Process.run(
    shell,
    ['-c', '$flutterBinaryPath doctor -v'],
  );
}
