import 'dart:async';
import 'dart:isolate';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:dart_lens/preferences/bloc.dart';
import 'package:dart_lens/project-analysis/bloc.dart';
import 'package:dart_lens/project-structure-analysis.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

/*
enum StringLiteralContext {
  import,
  widget,
  other,
}
*/

@immutable
class StringLiteral {
  final String string;
  final String path;
  // final int lineNumber;
  // final StringLiteralContext context;

  const StringLiteral({
    required this.string,
    required this.path,
    // required this.lineNumber,
    // required this.context,
  });
}

class StringLiteralVisitor extends RecursiveAstVisitor<void> {
  final List<StringLiteral> strings = [];
  final String filePath;

  StringLiteralVisitor({
    required this.filePath,
  });

  @override
  void visitSimpleStringLiteral(SimpleStringLiteral node) {
    super.visitSimpleStringLiteral(node);

    // exclude import statements
    if (node.parent is ImportDirective) {
      return;
    }
    // exclude empty strings
    final stringValue = node.value;
    if (stringValue.isEmpty) {
      return;
    }

    // final context = _getStringLiteralContext(node);

    final viewModel = StringLiteral(
      string: stringValue,
      path: filePath,
      // lineNumber: 0, // TODO
      // context: context,
    );
    strings.add(viewModel);
  }

/*
  StringLiteralContext _getStringLiteralContext(SimpleStringLiteral node) {
    if (node.parent is ImportDirective) {
      return StringLiteralContext.import;
    }
    // TODO
    // return StringLiteralContext.widget;
    return StringLiteralContext.other;
  }
*/
}

class StringLiteralsViewConductor extends ChangeNotifier {
  factory StringLiteralsViewConductor.fromContext(BuildContext context) {
    return StringLiteralsViewConductor(
      context.read<PreferencesConductor>(),
      context.read<ProjectAnalysisConductor>(),
    );
  }

  final PreferencesConductor _preferencesConductor;
  final ProjectAnalysisConductor _projectAnalysisConductor;

  bool _isLoading = false;
  List<StringLiteral> _stringLiterals = [];

  bool get isLoading => _isLoading;
  List<StringLiteral> get stringLiterals => _stringLiterals;
  String get _projectPath => _projectAnalysisConductor.projectPath;

  StringLiteralsViewConductor(
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
    _stringLiterals = [];
    notifyListeners();

    _stringLiterals = await _getStringLiterals();
    _isLoading = false;
    notifyListeners();
  }

  Future<List<StringLiteral>> _getStringLiterals() async {
    if (_projectPath.isEmpty) return [];
    try {
      final flutterBinaryPath = _preferencesConductor.flutterBinaryPath;
      final projectPath = _projectPath;
      return await Isolate.run(() {
        return _createStringLiterals(
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

Future<List<StringLiteral>> _createStringLiterals({
  required String flutterBinaryPath,
  required String projectPath,
}) async {
  final stringLiterals = <StringLiteral>[];

  final resolvedUnitResults = await getProjectStructure(
    flutterBinaryPath: flutterBinaryPath,
    projectDirectoryPath: projectPath,
  );
  for (final resolvedUnitResult in resolvedUnitResults) {
    final filePath = relative(
      resolvedUnitResult.path,
      from: projectPath,
    );
    // iterate over all declarations in this unit and find all string literals
    final visitor = StringLiteralVisitor(
      filePath: filePath,
    );
    resolvedUnitResult.unit.visitChildren(visitor);
    for (final string in visitor.strings) {
      stringLiterals.add(string);
    }
  }

  return stringLiterals;
}
