import 'package:flutter/widgets.dart';

class ProjectAnalysisConductor extends ChangeNotifier {
  factory ProjectAnalysisConductor.fromContext(BuildContext context) {
    return ProjectAnalysisConductor();
  }

  ProjectAnalysisConductor();

  var _projectPath = '';

  String get projectPath => _projectPath;

  void setProjectPath(String projectPath) {
    _projectPath = projectPath;
    notifyListeners();
  }
}
