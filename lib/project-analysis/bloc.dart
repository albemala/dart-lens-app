import 'package:dart_lens/fs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class ProjectAnalysisState extends Equatable {
  final String projectPath;

  const ProjectAnalysisState({
    required this.projectPath,
  });

  @override
  List<Object?> get props => [
        projectPath,
      ];
}

class ProjectAnalysisBloc extends Cubit<ProjectAnalysisState> {
  factory ProjectAnalysisBloc.fromContext(BuildContext context) {
    return ProjectAnalysisBloc();
  }

  ProjectAnalysisBloc()
      : super(
          const ProjectAnalysisState(
            projectPath: '',
          ),
        );

  Future<void> pickDirectory() async {
    final directory = await pickExistingDirectory();
    if (directory == null) return;

    setProjectPath(directory);
  }

  void setProjectPath(String projectPath) {
    _updateState(
      projectPath: projectPath,
    );
  }

  void _updateState({
    String? projectPath,
  }) {
    emit(
      ProjectAnalysisState(
        projectPath: projectPath ?? state.projectPath,
      ),
    );
  }
}
