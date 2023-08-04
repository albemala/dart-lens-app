import 'dart:io';

final flutterCmd = Platform.isWindows ? 'flutter.bat' : 'flutter';

Future<ProcessResult> runFlutterPubGet(
  String directoryPath,
) async {
  final processResult = await Process.run(
    flutterCmd,
    ['pub', 'get'],
    workingDirectory: directoryPath,
  );
  return processResult;
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
