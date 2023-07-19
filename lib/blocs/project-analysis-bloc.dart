import 'package:dart_lens/blocs/bloc-value.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class ProjectAnalysisBlocState extends Equatable {
  final String? projectPath;

  const ProjectAnalysisBlocState({
    required this.projectPath,
  });

  @override
  List<Object?> get props => [
        projectPath,
      ];
}

const String? _defaultProjectPath = null;

class ProjectAnalysisBloc extends Cubit<ProjectAnalysisBlocState> {
  late final BlocValue<String?> _projectPath;

  ProjectAnalysisBloc()
      : super(
          const ProjectAnalysisBlocState(
            projectPath: _defaultProjectPath,
          ),
        ) {
    _projectPath = BlocValue<String?>(
      initialValue: _defaultProjectPath,
      onChange: _updateState,
    );
  }

  @override
  Future<void> close() {
    _projectPath.dispose();
    return super.close();
  }

  void _updateState() {
    emit(
      ProjectAnalysisBlocState(
        projectPath: _projectPath.value,
      ),
    );
  }

  void setProjectPath(String? projectPath) {
    _projectPath.value = projectPath;
  }
}
