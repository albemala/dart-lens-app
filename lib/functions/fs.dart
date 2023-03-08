import 'package:file_picker/file_picker.dart';

Future<String?> pickExistingDirectory() async {
  return FilePicker.platform.getDirectoryPath();
}

Future<PlatformFile?> pickExistingFile({
  List<String>? extensions,
}) async {
  final result = await FilePicker.platform.pickFiles(
    type: _fileType(extensions),
    allowedExtensions: extensions,
  );
  return result?.files.first;
}

Future<String?> pickNewFile({
  required String fileName,
  List<String>? extensions,
}) async {
  return FilePicker.platform.saveFile(
    fileName: fileName,
    type: _fileType(extensions),
    allowedExtensions: extensions,
  );
}

FileType _fileType(List<String>? extensions) {
  return extensions == null //
      ? FileType.any
      : FileType.custom;
}
