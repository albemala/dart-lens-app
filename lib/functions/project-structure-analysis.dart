import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:dart_lens/functions/commands.dart';
import 'package:path/path.dart' as path;

Future<List<ResolvedUnitResult>> getProjectStructure({
  required String flutterBinaryPath,
  required String projectDirectoryPath,
}) async {
  print('Exploring project at $projectDirectoryPath');

  final projectDirectory = Directory(projectDirectoryPath);
  if (!projectDirectory.existsSync()) {
    throw Exception('Project directory does not exist');
  }

  final excludedPaths = <String>[];
  for (final entity in projectDirectory.listSync(recursive: true)) {
    if (entity is Directory) {
      // exclude generated subdirectories
      if (entity.path.contains('generated')) excludedPaths.add(entity.path);
    }
  }

  // detect dart sdk installation path
  // NOTE: on macOS, App Sandbox must be disabled for this to work

  // run `flutter doctor -v`
  final flutterDoctorResult = await runFlutterDoctor(
    flutterBinaryPath: flutterBinaryPath,
  );
  // extract flutter sdk path from flutter doctor output
  // example to look for: Flutter version <version> on channel <channel> at <path>
  final flutterSdkPathRegex =
      RegExp(r'\s+Flutter version [\d.]+ on channel \w+ at (.*)');
  final flutterSdkPathMatch = flutterSdkPathRegex.firstMatch(
    flutterDoctorResult.stdout.toString(),
  );

  final flutterSdkPath = flutterSdkPathMatch?.group(1);
  print('flutterSdkPath: $flutterSdkPath');
  if (flutterSdkPath == null) {
    throw Exception('Could not detect flutter sdk path');
  }

  final dartSdkPath =
      path.normalize(path.join(flutterSdkPath, 'bin/cache/dart-sdk'));
  print('dartSdkPath: $dartSdkPath');

  final collection = AnalysisContextCollection(
    includedPaths: [projectDirectory.path],
    excludedPaths: excludedPaths,
    resourceProvider: PhysicalResourceProvider.INSTANCE,
    sdkPath: dartSdkPath,
  );

  final resolvedUnitResults = <ResolvedUnitResult>[];
  print('Found ${collection.contexts.length} contexts');
  for (final context in collection.contexts) {
    print('Context: ${context.contextRoot.root.path}');
    for (final filePath in context.contextRoot.analyzedFiles()) {
      // skip files that are not dart files
      if (!filePath.endsWith('.dart')) continue;
      // skip part files
      if (filePath.endsWith('.g.dart')) continue;
      if (filePath.endsWith('.freezed.dart')) continue;

      print('File: $filePath');

      final session = context.currentSession;
      final resolvedUnit = await session.getResolvedUnit(filePath);

      if (resolvedUnit is ResolvedUnitResult) {
        resolvedUnitResults.add(resolvedUnit);

/*
        final libraryElement = resolvedUnit.libraryElement;
        print('''
resolvedUnit: 
  isLibrary: ${resolvedUnit.isLibrary} 
  isAugmentation: ${resolvedUnit.isAugmentation} 
  isPart: ${resolvedUnit.isPart}
  isSynthetic: ${libraryElement.isSynthetic}
  identifier: ${libraryElement.identifier}''');
        for (final element in libraryElement.importedLibraries) {
          print('importedLibrary: ${element.identifier}'); // package:<...>
        }
        // libraryElement.topLevelElements.forEach((element) {
        //   print(
        //       'topLevelElement: ${element.runtimeType} -- ${element.declaration} -- <${element.kind}>'); // top level declarations
        // });
        final compilationUnit = resolvedUnit.unit;
        // alternative to libraryElement.topLevelElements
        for (final element in compilationUnit.declarations) {
          print('declaration:');
          // print('declaration: ${element.runtimeType} -- ${element.declaredElement}'); // classes, functions...
          if (element is ClassDeclaration) {
            // classes
            print('  class: ${element.name}');
            for (final classMember in element.members) {
              if (classMember is MethodDeclaration) {
                // methods
                print('  method: ${classMember.name}');
              } else if (classMember is FieldDeclaration) {
                // fields
                for (final field in classMember.fields.variables) {
                  print('  field: ${field.name}');
                }
              } else if (classMember is ConstructorDeclaration) {
                // constructors
                if (classMember.name == null) {
                  print('  constructor: ${element.name}');
                } else {
                  print('  constructor: ${element.name}.${classMember.name!}');
                }
              }
            }
          } else if (element is FunctionDeclaration) {
            // functions
            print('  function: ${element.declaredElement}');
          }
        }
        // compilationUnit.directives.forEach((element) {
        //   print('directive: ${element}'); // import, same as importedLibraries
        // });
*/
      }
    }
  }
  return resolvedUnitResults;
}
