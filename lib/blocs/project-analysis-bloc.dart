import 'package:analyzer/dart/analysis/results.dart';
import 'package:dart_lens/functions/project-packages-analysis.dart';
import 'package:dart_lens/models/package/package.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'project-analysis-bloc.freezed.dart';

@freezed
class ProjectAnalysisBlocState with _$ProjectAnalysisBlocState {
  const ProjectAnalysisBlocState._();

  const factory ProjectAnalysisBlocState({
    required String? projectPath,
    required List<Package>? packages,
    required List<ResolvedUnitResult>? resolvedUnitResults,
    required bool isLoading,
    required String? loadingError,
  }) = _ProjectAnalysisBlocState;
}

class ProjectAnalysisBloc extends Cubit<ProjectAnalysisBlocState> {
  ProjectAnalysisBloc()
      : super(
          const ProjectAnalysisBlocState(
            projectPath: null,
            packages: null,
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
      final packages = await compute(
        getPackages,
        state.projectPath ?? '',
      );
      emit(
        state.copyWith(
          packages: packages,
        ),
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