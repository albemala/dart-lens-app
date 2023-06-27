import 'dart:io';

final flutterCmd = Platform.isWindows ? 'flutter.bat' : 'flutter';

Future<void> runFlutterPubGet(
  String directoryPath,
) async {
  final flutterPubGetProcess = await Process.run(
    flutterCmd,
    ['pub', 'get'],
    workingDirectory: directoryPath,
  );
  print('flutter pub get output: ${flutterPubGetProcess.stdout}');
  print('flutter pub get error: ${flutterPubGetProcess.stderr}');
}

Future<ProcessResult> runFlutterPubOutdated(
  String projectDirectoryPath,
) async {
  return Process.run(
    flutterCmd,
    ['pub', 'outdated', '--json'],
    workingDirectory: projectDirectoryPath,
  );
}

Future<ProcessResult> runFlutterDoctor() async {
  return Process.run(
    flutterCmd,
    ['doctor', '-v'],
  );
}
