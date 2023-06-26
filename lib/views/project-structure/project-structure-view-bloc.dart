import 'dart:async';
import 'dart:isolate';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:collection/collection.dart';
import 'package:dart_lens/blocs/project-analysis-bloc.dart';
import 'package:dart_lens/functions/project-structure-analysis.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart';

part 'project-structure-view-bloc.freezed.dart';

@freezed
class ProjectStructureViewModel with _$ProjectStructureViewModel {
  const ProjectStructureViewModel._();

  const factory ProjectStructureViewModel({
    required bool isLoading,
    required String projectPath,
    required List<DirectoryViewModel> directories,
  }) = _ProjectStructureViewModel;
}

@freezed
class DirectoryViewModel with _$DirectoryViewModel {
  const DirectoryViewModel._();

  const factory DirectoryViewModel({
    required String path,
    required List<FileViewModel> files,
  }) = _DirectoryViewModel;
}

@freezed
class FileViewModel with _$FileViewModel {
  const FileViewModel._();

  const factory FileViewModel({
    required String name,
    required List<EntityViewModel> entities,
    required List<String> imports,
  }) = _FileViewModel;
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

@freezed
class ParameterViewModel with _$ParameterViewModel {
  const ParameterViewModel._();

  const factory ParameterViewModel({
    required String name,
    required String type,
  }) = _ParameterViewModel;
}

@freezed
class ClassViewModel with _$ClassViewModel implements EntityViewModel {
  const ClassViewModel._();

  const factory ClassViewModel({
    required String name,
    required List<ClassPropertyViewModel> properties,
    required List<ClassConstructorViewModel> constructors,
    required List<ClassMethodViewModel> methods,
  }) = _ClassViewModel;

  @override
  EntityViewModelType get type => EntityViewModelType.class_;
}

@freezed
class ClassPropertyViewModel with _$ClassPropertyViewModel {
  const ClassPropertyViewModel._();

  const factory ClassPropertyViewModel({
    required String name,
    required String type,
  }) = _ClassPropertyViewModel;
}

@freezed
class ClassConstructorViewModel with _$ClassConstructorViewModel {
  const ClassConstructorViewModel._();

  const factory ClassConstructorViewModel({
    required String name,
    required List<ParameterViewModel> parameters,
  }) = _ClassConstructorViewModel;
}

@freezed
class ClassMethodViewModel with _$ClassMethodViewModel {
  const ClassMethodViewModel._();

  const factory ClassMethodViewModel({
    required String name,
    required String returnType,
    required List<ParameterViewModel> parameters,
  }) = _ClassMethodViewModel;
}

@freezed
class EnumViewModel with _$EnumViewModel implements EntityViewModel {
  const EnumViewModel._();

  const factory EnumViewModel({
    required String name,
    required List<String> values,
  }) = _EnumViewModel;

  @override
  EntityViewModelType get type => EntityViewModelType.enum_;
}

@freezed
class FunctionViewModel with _$FunctionViewModel implements EntityViewModel {
  const FunctionViewModel._();

  const factory FunctionViewModel({
    required String name,
    required String returnType,
    required List<ParameterViewModel> parameters,
  }) = _FunctionViewModel;

  @override
  EntityViewModelType get type => EntityViewModelType.function_;
}

class ProjectStructureViewBloc extends Cubit<ProjectStructureViewModel> {
  final BuildContext context;
  late StreamSubscription<ProjectAnalysisBlocState> projectAnalysisBlocListener;

  String? get _projectPath {
    final projectAnalysisBlocState = context.read<ProjectAnalysisBloc>().state;
    return projectAnalysisBlocState.projectPath;
  }

  ProjectStructureViewBloc(this.context)
      : super(
          const ProjectStructureViewModel(
            isLoading: false,
            projectPath: '',
            directories: [],
          ),
        ) {
    projectAnalysisBlocListener = context //
        .read<ProjectAnalysisBloc>()
        .stream
        .listen((projectAnalysisBlocState) {
      emit(
        state.copyWith(
          projectPath: '',
          directories: [],
        ),
      );
      _updateState();
    });
    _updateState();
  }

  @override
  Future<void> close() {
    projectAnalysisBlocListener.cancel();
    return super.close();
  }

  void reload() {
    _updateState();
  }

  Future<void> _updateState() async {
    final projectPath = _projectPath ?? '';

    emit(
      state.copyWith(isLoading: true),
    );
    final directoryViewModels = await _updateDirectoryViewModels();
    emit(
      state.copyWith(isLoading: false),
    );

    emit(
      state.copyWith(
        projectPath: projectPath,
        directories: directoryViewModels,
      ),
    );
  }

  Future<List<DirectoryViewModel>> _updateDirectoryViewModels() async {
    final projectPath = _projectPath;
    if (projectPath == null || projectPath.isEmpty) return [];

    try {
      return await Isolate.run(
        () => _createDirectoryViewModels(projectPath),
      );
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
        .map((declaration) {
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
