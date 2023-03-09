import 'package:analyzer/dart/analysis/results.dart';
import 'package:dart_lens/functions/project-packages-analysis.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'project-structure-bloc.freezed.dart';

@freezed
class ProjectStructureBlocState with _$ProjectStructureBlocState {
  const ProjectStructureBlocState._();

  const factory ProjectStructureBlocState({
    required String? projectPath,
    required List<ResolvedUnitResult>? resolvedUnitResults,
    required bool isLoading,
    required String? loadingError,
  }) = _ProjectStructureBlocState;
}

class ProjectStructureBloc extends Cubit<ProjectStructureBlocState> {
  ProjectStructureBloc()
      : super(
          const ProjectStructureBlocState(
            projectPath: null,
            resolvedUnitResults: null,
            isLoading: false,
            loadingError: null,
          ),
        );

  Future<void> setProjectPath(String? projectPath) async {
    emit(
      state.copyWith(projectPath: projectPath),
    );
    if (state.projectPath == null) return;

    emit(
      state.copyWith(
        isLoading: true,
        loadingError: null,
      ),
    );
    try {
      await compute(
        getPackages,
        state.projectPath ?? '',
      );
/*
      final resolvedUnitResults = await compute(
        getProjectStructure,
        state.projectPath ?? '',
      );
      emit(
        state.copyWith(
          resolvedUnitResults: resolvedUnitResults,
        ),
      );
*/
    } catch (exception) {
      emit(
        state.copyWith(
          loadingError: exception.toString(),
        ),
      );
    }
    emit(
      state.copyWith(
        isLoading: false,
      ),
    );
  }
}
