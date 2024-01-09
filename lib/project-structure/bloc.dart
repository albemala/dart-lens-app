import 'dart:async';
import 'dart:isolate';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:collection/collection.dart';
import 'package:dart_lens/preferences/bloc.dart';
import 'package:dart_lens/project-analysis/bloc.dart';
import 'package:dart_lens/project-structure-analysis.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

@immutable
class ProjectDirectory extends Equatable {
  final String path;
  final List<ProjectFile> files;

  const ProjectDirectory({
    required this.path,
    required this.files,
  });

  @override
  List<Object?> get props => [
        path,
        files,
      ];
}

@immutable
class ProjectFile extends Equatable {
  final String name;
  final List<EntityDefinition> entities;
  final List<String> imports;

  const ProjectFile({
    required this.name,
    required this.entities,
    required this.imports,
  });

  @override
  List<Object?> get props => [
        name,
        entities,
        imports,
      ];
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
class ParameterDefinition extends Equatable {
  final String name;
  final String type;

  const ParameterDefinition({
    required this.name,
    required this.type,
  });

  @override
  List<Object?> get props => [
        name,
        type,
      ];
}

@immutable
class ClassDefinition extends Equatable implements EntityDefinition {
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

  @override
  List<Object?> get props => [
        name,
        properties,
        constructors,
        methods,
      ];
}

@immutable
class ClassPropertyDefinition extends Equatable {
  final String name;
  final String type;

  const ClassPropertyDefinition({
    required this.name,
    required this.type,
  });

  @override
  List<Object?> get props => [
        name,
        type,
      ];
}

@immutable
class ClassConstructorDefinition extends Equatable {
  final String name;
  final List<ParameterDefinition> parameters;

  const ClassConstructorDefinition({
    required this.name,
    required this.parameters,
  });

  @override
  List<Object?> get props => [
        name,
        parameters,
      ];
}

@immutable
class ClassMethodDefinition extends Equatable {
  final String name;
  final String returnType;
  final List<ParameterDefinition> parameters;

  const ClassMethodDefinition({
    required this.name,
    required this.returnType,
    required this.parameters,
  });

  @override
  List<Object?> get props => [
        name,
        returnType,
        parameters,
      ];
}

@immutable
class EnumDefinition extends Equatable implements EntityDefinition {
  final String name;
  final List<String> values;

  const EnumDefinition({
    required this.name,
    required this.values,
  });

  @override
  EntityDefinitionType get type => EntityDefinitionType.enum_;

  @override
  List<Object?> get props => [
        name,
        values,
      ];
}

@immutable
class FunctionDefinition extends Equatable implements EntityDefinition {
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

  @override
  List<Object?> get props => [
        name,
        returnType,
        parameters,
      ];
}

@immutable
class ProjectStructureViewModel extends Equatable {
  final bool isLoading;
  final String projectPath;
  final List<ProjectDirectory> directories;

  const ProjectStructureViewModel({
    required this.isLoading,
    required this.projectPath,
    required this.directories,
  });

  @override
  List<Object?> get props => [
        isLoading,
        projectPath,
        directories,
      ];
}

class ProjectStructureViewBloc extends Cubit<ProjectStructureViewModel> {
  final PreferencesBloc _preferencesBloc;
  final ProjectAnalysisBloc _projectAnalysisBloc;
  StreamSubscription<ProjectAnalysisState>? _projectAnalysisBlocSubscription;

  bool _isLoading = false;
  List<ProjectDirectory> _directories = [];

  String get _projectPath => _projectAnalysisBloc.state.projectPath;

  factory ProjectStructureViewBloc.fromContext(BuildContext context) {
    return ProjectStructureViewBloc(
      context.read<PreferencesBloc>(),
      context.read<ProjectAnalysisBloc>(),
    );
  }

  ProjectStructureViewBloc(
    this._preferencesBloc,
    this._projectAnalysisBloc,
  ) : super(
          const ProjectStructureViewModel(
            isLoading: false,
            projectPath: '',
            directories: [],
          ),
        ) {
    _projectAnalysisBlocSubscription = _projectAnalysisBloc.stream.listen((_) {
      reload();
    });
    reload();
  }

  @override
  Future<void> close() async {
    await _projectAnalysisBlocSubscription?.cancel();
    await super.close();
  }

  Future<void> reload() async {
    _isLoading = true;
    _directories = const [];
    _updateViewModel();

    _directories = await _getDirectories();
    _isLoading = false;
    _updateViewModel();
  }

  void _updateViewModel() {
    emit(
      ProjectStructureViewModel(
        isLoading: _isLoading,
        projectPath: _projectPath,
        directories: _directories,
      ),
    );
  }

  Future<List<ProjectDirectory>> _getDirectories() async {
    if (_projectPath.isEmpty) return [];
    try {
      final flutterBinaryPath = _preferencesBloc.state.flutterBinaryPath;
      // ignore: no_leading_underscores_for_local_identifiers
      final projectPath = _projectPath;
      return await Isolate.run(() {
        return _createDirectories(
          flutterBinaryPath: flutterBinaryPath,
          projectPath: projectPath,
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
