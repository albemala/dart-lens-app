import 'dart:async';
import 'dart:isolate';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:dart_lens/clipboard.dart';
import 'package:dart_lens/preferences/bloc.dart';
import 'package:dart_lens/project-analysis/bloc.dart';
import 'package:dart_lens/project-structure-analysis.dart';
import 'package:dart_lens/routing/functions.dart';
import 'package:dart_lens/widgets/snack-bar.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

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

@immutable
class StringLiteralsViewModel extends Equatable {
  final bool isLoading;
  final List<StringLiteral> stringLiterals;

  const StringLiteralsViewModel({
    required this.isLoading,
    required this.stringLiterals,
  });

  @override
  List<Object?> get props => [
        isLoading,
        stringLiterals,
      ];
}

class StringLiteralsViewBloc extends Cubit<StringLiteralsViewModel> {
  final PreferencesBloc _preferencesBloc;
  final ProjectAnalysisBloc _projectAnalysisBloc;
  StreamSubscription<ProjectAnalysisState>? _projectAnalysisBlocSubscription;

  bool _isLoading = false;
  List<StringLiteral> _stringLiterals = [];

  String get _projectPath => _projectAnalysisBloc.state.projectPath;

  factory StringLiteralsViewBloc.fromContext(BuildContext context) {
    return StringLiteralsViewBloc(
      context.read<PreferencesBloc>(),
      context.read<ProjectAnalysisBloc>(),
    );
  }

  StringLiteralsViewBloc(
    this._preferencesBloc,
    this._projectAnalysisBloc,
  ) : super(
          const StringLiteralsViewModel(
            isLoading: false,
            stringLiterals: [],
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
    _stringLiterals = [];
    _updateViewModel();

    _stringLiterals = await _getStringLiterals();
    _isLoading = false;
    _updateViewModel();
  }

  Future<List<StringLiteral>> _getStringLiterals() async {
    if (_projectPath.isEmpty) return [];
    try {
      final flutterBinaryPath = _preferencesBloc.state.flutterBinaryPath;
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

  void _updateViewModel() {
    emit(
      StringLiteralsViewModel(
        isLoading: _isLoading,
        stringLiterals: _stringLiterals,
      ),
    );
  }

  Future<void> copyStringToClipboard(
    BuildContext context,
    String string,
  ) async {
    await copyToClipboard(string);
    showSnackBar(
      context,
      createCopiedToClipboardSnackBar(),
    );
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
