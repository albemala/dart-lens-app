import 'dart:async';
import 'dart:isolate';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:collection/collection.dart';
import 'package:dart_lens/preferences/bloc.dart';
import 'package:dart_lens/project-analysis/bloc.dart';
import 'package:dart_lens/project-structure-analysis.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

@immutable
class ProjectDirectory {
  final String path;
  final List<ProjectFile> files;

  const ProjectDirectory({
    required this.path,
    required this.files,
  });
}

@immutable
class ProjectFile {
  final String name;
  final List<EntityDefinition> entities;
  final List<String> imports;

  const ProjectFile({
    required this.name,
    required this.entities,
    required this.imports,
  });
}

enum EntityDefinitionType {
  class_,
  enum_,
  extension_,
  mixin_,
  typedef_,
  function_,
}

abstract class EntityDefinition {
  EntityDefinitionType get type;
}

@immutable
class ParameterDefinition {
  final String name;
  final String type;

  const ParameterDefinition({
    required this.name,
    required this.type,
  });
}

@immutable
class ClassDefinition implements EntityDefinition {
  final String name;
  final List<ClassPropertyDefinition> properties;
  final List<ClassConstructorDefinition> constructors;
  final List<ClassMethodDefinition> methods;

  const ClassDefinition({
    required this.name,
    required this.properties,
    required this.constructors,
    required this.methods,
  });

  @override
  EntityDefinitionType get type => EntityDefinitionType.class_;
}

@immutable
class ClassPropertyDefinition {
  final String name;
  final String type;

  const ClassPropertyDefinition({
    required this.name,
    required this.type,
  });
}

@immutable
class ClassConstructorDefinition {
  final String name;
  final List<ParameterDefinition> parameters;

  const ClassConstructorDefinition({
    required this.name,
    required this.parameters,
  });
}

@immutable
class ClassMethodDefinition {
  final String name;
  final String returnType;
  final List<ParameterDefinition> parameters;

  const ClassMethodDefinition({
    required this.name,
    required this.returnType,
    required this.parameters,
  });
}

@immutable
class EnumDefinition implements EntityDefinition {
  final String name;
  final List<String> values;

  const EnumDefinition({
    required this.name,
    required this.values,
  });

  @override
  EntityDefinitionType get type => EntityDefinitionType.enum_;
}

@immutable
class FunctionDefinition implements EntityDefinition {
  final String name;
  final String returnType;
  final List<ParameterDefinition> parameters;

  const FunctionDefinition({
    required this.name,
    required this.returnType,
    required this.parameters,
  });

  @override
  EntityDefinitionType get type => EntityDefinitionType.function_;
}

class ProjectStructureViewConductor extends ChangeNotifier {
  factory ProjectStructureViewConductor.fromContext(BuildContext context) {
    return ProjectStructureViewConductor(
      context.read<PreferencesConductor>(),
      context.read<ProjectAnalysisConductor>(),
    );
  }

  final PreferencesConductor _preferencesConductor;
  final ProjectAnalysisConductor _projectAnalysisConductor;

  bool _isLoading = false;
  List<ProjectDirectory> _directories = [];

  bool get isLoading => _isLoading;
  List<ProjectDirectory> get directories => _directories;
  String get projectPath => _projectAnalysisConductor.projectPath;

  ProjectStructureViewConductor(
    this._preferencesConductor,
    this._projectAnalysisConductor,
  ) {
    _projectAnalysisConductor.addListener(reload);
    reload();
  }

  @override
  void dispose() {
    _projectAnalysisConductor.removeListener(reload);
    super.dispose();
  }

  Future<void> reload() async {
    _isLoading = true;
    _directories = const [];
    notifyListeners();

    _directories = await _getDirectories();
    _isLoading = false;
    notifyListeners();
  }

  Future<List<ProjectDirectory>> _getDirectories() async {
    if (projectPath.isEmpty) return [];
    try {
      final flutterBinaryPath = _preferencesConductor.flutterBinaryPath;
      // ignore: no_leading_underscores_for_local_identifiers
      final _projectPath = projectPath;
      return await Isolate.run(() {
        return _createDirectories(
          flutterBinaryPath: flutterBinaryPath,
          projectPath: _projectPath,
        );
      });
    } catch (exception) {
      if (kDebugMode) print(exception);
      return [];
    }
  }
}

Future<List<ProjectDirectory>> _createDirectories({
  required String flutterBinaryPath,
  required String projectPath,
}) async {
  final directories = <String, List<ProjectFile>>{};

  final resolvedUnitResults = await getProjectStructure(
    flutterBinaryPath: flutterBinaryPath,
    projectDirectoryPath: projectPath,
  );
  for (final resolvedUnitResult in resolvedUnitResults) {
    final filePath = relative(
      resolvedUnitResult.path,
      from: projectPath,
    );
    final directoryPath = dirname(filePath);
    final fileName = basename(filePath);

    final imports = resolvedUnitResult.libraryElement.importedLibraries
        .map((importElement) => importElement.identifier)
        .toList();

    final entities = resolvedUnitResult //
        .unit
        .declarations
        .map<EntityDefinition?>((declaration) {
          if (declaration is ClassDeclaration) {
            return _createClass(declaration);
          } else if (declaration is FunctionDeclaration) {
            return _createFunction(declaration);
          } else if (declaration is EnumDeclaration) {
            return _createEnum(declaration);
          } else {
            return null;
          }
        })
        .whereNotNull()
        .toList();

    final file = ProjectFile(
      name: fileName,
      entities: entities,
      imports: imports,
    );

    directories.update(
      directoryPath,
      (directory) => [
        ...directory,
        file,
      ],
      ifAbsent: () => [file],
    );
  }

  return directories.entries
      .map(
        (directory) => ProjectDirectory(
          path: directory.key,
          files: directory.value,
        ),
      )
      .toList();
}

ClassDefinition _createClass(ClassDeclaration declaration) {
  final properties = declaration.members //
      .whereType<FieldDeclaration>()
      .map((fieldDeclaration) {
    return ClassPropertyDefinition(
      name: fieldDeclaration.fields.variables.first.name.toString(),
      type: fieldDeclaration.fields.type.toString(),
    );
  }).toList();
  final constructors = declaration.members //
      .whereType<ConstructorDeclaration>()
      .map((constructorDeclaration) {
    return ClassConstructorDefinition(
      name: constructorDeclaration.name != null
          ? '${constructorDeclaration.name}()'
          : '${declaration.name}()',
      parameters:
          constructorDeclaration.parameters.parameterElements.map((parameter) {
        return ParameterDefinition(
          name: parameter?.name ?? '',
          type: parameter?.type.toString() ?? '',
        );
      }).toList(),
    );
  }).toList();
  final methods = declaration.members //
      .whereType<MethodDeclaration>()
      .map(
    (methodDeclaration) {
      return ClassMethodDefinition(
        name: '${methodDeclaration.name}()',
        returnType: methodDeclaration.returnType.toString(),
        parameters:
            methodDeclaration.parameters?.parameterElements.map((parameter) {
                  return ParameterDefinition(
                    name: parameter?.name ?? '',
                    type: parameter?.type.toString() ?? '',
                  );
                }).toList() ??
                [],
      );
    },
  ).toList();
  return ClassDefinition(
    name: declaration.declaredElement?.displayName ?? '',
    properties: properties,
    constructors: constructors,
    methods: methods,
  );
}

FunctionDefinition _createFunction(FunctionDeclaration declaration) {
  final parameters = declaration
          .functionExpression.parameters?.parameterElements
          .map((parameter) {
        return ParameterDefinition(
          name: parameter?.name ?? '',
          type: parameter?.type.toString() ?? '',
        );
      }).toList() ??
      [];
  return FunctionDefinition(
    name: '${declaration.declaredElement?.displayName}()',
    returnType: declaration.returnType.toString(),
    parameters: parameters,
  );
}

EnumDefinition _createEnum(EnumDeclaration declaration) {
  final values = declaration.constants
      .map(
        (enumConstantDeclaration) => enumConstantDeclaration.name.toString(),
      )
      .toList();
  return EnumDefinition(
    name: declaration.declaredElement?.displayName ?? '',
    values: values,
  );
}
