import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'project-analysis-bloc.freezed.dart';

@freezed
class ProjectAnalysisBlocState with _$ProjectAnalysisBlocState {
  const ProjectAnalysisBlocState._();

  const factory ProjectAnalysisBlocState({
    required String? projectPath,
  }) = _ProjectAnalysisBlocState;
}

class ProjectAnalysisBloc extends Cubit<ProjectAnalysisBlocState> {
  ProjectAnalysisBloc()
      : super(
          const ProjectAnalysisBlocState(
            projectPath: null,
          ),
        );

  Future<void> setProjectPath(String? projectPath) async {
    emit(
      state.copyWith(projectPath: projectPath),
    );
  }
}
