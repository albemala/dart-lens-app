import 'dart:async';
import 'dart:isolate';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:collection/collection.dart';
import 'package:dart_lens/blocs/bloc-value.dart';
import 'package:dart_lens/blocs/project-analysis-bloc.dart';
import 'package:dart_lens/functions/project-structure-analysis.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

@immutable
class ProjectStructureViewModel extends Equatable {
  final bool isLoading;
  final String projectPath;
  final List<DirectoryViewModel> directories;

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

@immutable
class DirectoryViewModel extends Equatable {
  final String path;
  final List<FileViewModel> files;

  const DirectoryViewModel({
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
class FileViewModel extends Equatable {
  final String name;
  final List<EntityViewModel> entities;
  final List<String> imports;

  const FileViewModel({
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

enum EntityViewModelType {
  class_,
  enum_,
  extension_,
  mixin_,
  typedef_,
  function_,
}

abstract class EntityViewModel {
  EntityViewModelType get type;
}

@immutable
class ParameterViewModel extends Equatable {
  final String name;
  final String type;

  const ParameterViewModel({
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
class ClassViewModel extends Equatable implements EntityViewModel {
  final String name;
  final List<ClassPropertyViewModel> properties;
  final List<ClassConstructorViewModel> constructors;
  final List<ClassMethodViewModel> methods;

  const ClassViewModel({
    required this.name,
    required this.properties,
    required this.constructors,
    required this.methods,
  });

  @override
  List<Object?> get props => [
        name,
        properties,
        constructors,
        methods,
      ];

  @override
  EntityViewModelType get type => EntityViewModelType.class_;
}

@immutable
class ClassPropertyViewModel extends Equatable {
  final String name;
  final String type;

  const ClassPropertyViewModel({
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
class ClassConstructorViewModel extends Equatable {
  final String name;
  final List<ParameterViewModel> parameters;

  const ClassConstructorViewModel({
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
class ClassMethodViewModel extends Equatable {
  final String name;
  final String returnType;
  final List<ParameterViewModel> parameters;

  const ClassMethodViewModel({
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
class EnumViewModel extends Equatable implements EntityViewModel {
  final String name;
  final List<String> values;

  const EnumViewModel({
    required this.name,
    required this.values,
  });

  @override
  List<Object?> get props => [
        name,
        values,
      ];

  @override
  EntityViewModelType get type => EntityViewModelType.enum_;
}

@immutable
class FunctionViewModel extends Equatable implements EntityViewModel {
  final String name;
  final String returnType;
  final List<ParameterViewModel> parameters;

  const FunctionViewModel({
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

  @override
  EntityViewModelType get type => EntityViewModelType.function_;
}

class ProjectStructureViewBloc extends Cubit<ProjectStructureViewModel> {
  factory ProjectStructureViewBloc.fromContext(BuildContext context) {
    return ProjectStructureViewBloc._(
      context.read<ProjectAnalysisBloc>(),
    );
  }

  final ProjectAnalysisBloc _projectAnalysisBloc;

  late final StreamSubscription<ProjectAnalysisBlocState>
      _projectAnalysisBlocListener;

  late final BlocValue<bool> _isLoading;
  late final BlocValue<List<DirectoryViewModel>> _directoryViewModels;

  String get _projectPath {
    return _projectAnalysisBloc.state.projectPath ?? '';
  }

  ProjectStructureViewBloc._(
    this._projectAnalysisBloc,
  ) : super(
          const ProjectStructureViewModel(
            isLoading: false,
            projectPath: '',
            directories: [],
          ),
        ) {
    _isLoading = BlocValue<bool>(
      initialValue: false,
      onChange: _updateState,
    );
    _directoryViewModels = BlocValue<List<DirectoryViewModel>>(
      initialValue: const [],
      onChange: _updateState,
    );
    _projectAnalysisBlocListener =
        _projectAnalysisBloc.stream.listen((projectAnalysisBlocState) {
      reload();
    });
    reload();
  }

  @override
  Future<void> close() {
    _isLoading.dispose();
    _directoryViewModels.dispose();
    _projectAnalysisBlocListener.cancel();
    return super.close();
  }

  Future<void> reload() async {
    _isLoading.value = true;
    _directoryViewModels
      ..value = const []
      ..value = await _getDirectoryViewModels();
    _isLoading.value = false;
  }

  Future<void> _updateState() async {
    emit(
      ProjectStructureViewModel(
        isLoading: _isLoading.value,
        projectPath: _projectPath,
        directories: _directoryViewModels.value,
      ),
    );
  }

  Future<List<DirectoryViewModel>> _getDirectoryViewModels() async {
    if (_projectPath.isEmpty) return [];
    try {
      final projectPath = _projectPath;
      return await Isolate.run(() {
        return _createDirectoryViewModels(projectPath);
      });
    } catch (exception) {
      print(exception);
      return [];
    }
  }
}

Future<List<DirectoryViewModel>> _createDirectoryViewModels(
  String projectPath,
) async {
  final directories = <String, List<FileViewModel>>{};

  final resolvedUnitResults = await getProjectStructure(projectPath);
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
        .map<EntityViewModel?>((declaration) {
          if (declaration is ClassDeclaration) {
            return _createClassViewModel(declaration);
          } else if (declaration is FunctionDeclaration) {
            return _createFunctionViewModel(declaration);
          } else if (declaration is EnumDeclaration) {
            return _createEnumViewModel(declaration);
          } else {
            return null;
          }
        })
        .whereNotNull()
        .toList();

    final fileViewModel = FileViewModel(
      name: fileName,
      entities: entities,
      imports: imports,
    );

    directories.update(
      directoryPath,
      (directoryViewModel) => [
        ...directoryViewModel,
        fileViewModel,
      ],
      ifAbsent: () => [fileViewModel],
    );
  }

  final directoryViewModels = directories.entries
      .map(
        (directory) => DirectoryViewModel(
          path: directory.key,
          files: directory.value,
        ),
      )
      .toList();

  return directoryViewModels;
}

ClassViewModel _createClassViewModel(ClassDeclaration declaration) {
  final properties = declaration.members //
      .whereType<FieldDeclaration>()
      .map((fieldDeclaration) {
    return ClassPropertyViewModel(
      name: fieldDeclaration.fields.variables.first.name.toString(),
      type: fieldDeclaration.fields.type.toString(),
    );
  }).toList();
  final constructors = declaration.members //
      .whereType<ConstructorDeclaration>()
      .map((constructorDeclaration) {
    return ClassConstructorViewModel(
      name: constructorDeclaration.name != null
          ? '${constructorDeclaration.name}()'
          : '${declaration.name}()',
      parameters:
          constructorDeclaration.parameters.parameterElements.map((parameter) {
        return ParameterViewModel(
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
      return ClassMethodViewModel(
        name: '${methodDeclaration.name}()',
        returnType: methodDeclaration.returnType.toString(),
        parameters:
            methodDeclaration.parameters?.parameterElements.map((parameter) {
                  return ParameterViewModel(
                    name: parameter?.name ?? '',
                    type: parameter?.type.toString() ?? '',
                  );
                }).toList() ??
                [],
      );
    },
  ).toList();
  return ClassViewModel(
    name: declaration.declaredElement?.displayName ?? '',
    properties: properties,
    constructors: constructors,
    methods: methods,
  );
}

FunctionViewModel _createFunctionViewModel(FunctionDeclaration declaration) {
  final parameters = declaration
          .functionExpression.parameters?.parameterElements
          .map((parameter) {
        return ParameterViewModel(
          name: parameter?.name ?? '',
          type: parameter?.type.toString() ?? '',
        );
      }).toList() ??
      [];
  return FunctionViewModel(
    name: '${declaration.declaredElement?.displayName}()',
    returnType: declaration.returnType.toString(),
    parameters: parameters,
  );
}

EnumViewModel _createEnumViewModel(EnumDeclaration declaration) {
  final values = declaration.constants
      .map(
        (enumConstantDeclaration) => enumConstantDeclaration.name.toString(),
      )
      .toList();
  return EnumViewModel(
    name: declaration.declaredElement?.displayName ?? '',
    values: values,
  );
}
