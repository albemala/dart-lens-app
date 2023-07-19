import 'dart:async';
import 'dart:isolate';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:dart_lens/blocs/bloc-value.dart';
import 'package:dart_lens/blocs/project-analysis-bloc.dart';
import 'package:dart_lens/functions/project-structure-analysis.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

enum StringLiteralContext {
  import,
  widget,
  other,
}

@immutable
class StringLiteralsViewModel extends Equatable {
  final bool isLoading;
  final List<StringLiteralViewModel> stringLiterals;

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

@immutable
class StringLiteralViewModel extends Equatable {
  final String string;
  final String path;
  // final int lineNumber;
  // final StringLiteralContext context;

  const StringLiteralViewModel({
    required this.string,
    required this.path,
    // required this.lineNumber,
    // required this.context,
  });

  @override
  List<Object?> get props => [
        string,
        path,
        // lineNumber,
        // context,
      ];
}

class StringLiteralVisitor extends RecursiveAstVisitor<void> {
  final List<StringLiteralViewModel> strings = [];
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

    final viewModel = StringLiteralViewModel(
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

class StringLiteralsViewBloc extends Cubit<StringLiteralsViewModel> {
  factory StringLiteralsViewBloc.fromContext(BuildContext context) {
    return StringLiteralsViewBloc._(
      context.read<ProjectAnalysisBloc>(),
    );
  }

  final ProjectAnalysisBloc _projectAnalysisBloc;

  late final StreamSubscription<ProjectAnalysisBlocState>
      _projectAnalysisBlocListener;

  late final BlocValue<bool> _isLoading;
  late final BlocValue<List<StringLiteralViewModel>> _stringLiteralViewModels;

  String get _projectPath {
    return _projectAnalysisBloc.state.projectPath ?? '';
  }

  StringLiteralsViewBloc._(
    this._projectAnalysisBloc,
  ) : super(
          const StringLiteralsViewModel(
            isLoading: false,
            stringLiterals: [],
          ),
        ) {
    _isLoading = BlocValue<bool>(
      initialValue: false,
      onChange: _updateState,
    );
    _stringLiteralViewModels = BlocValue<List<StringLiteralViewModel>>(
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
    _stringLiteralViewModels.dispose();
    _projectAnalysisBlocListener.cancel();
    return super.close();
  }

  Future<void> reload() async {
    _isLoading.value = true;
    _stringLiteralViewModels
      ..value = []
      ..value = await _getStringLiteralViewModels();
    _isLoading.value = false;
  }

  Future<void> _updateState() async {
    emit(
      StringLiteralsViewModel(
        isLoading: _isLoading.value,
        stringLiterals: _stringLiteralViewModels.value,
      ),
    );
  }

  Future<List<StringLiteralViewModel>> _getStringLiteralViewModels() async {
    if (_projectPath.isEmpty) return [];
    try {
      final projectPath = _projectPath;
      return await Isolate.run(() {
        return _createStringLiteralViewModels(projectPath);
      });
    } catch (exception) {
      print(exception);
      return [];
    }
  }
}

Future<List<StringLiteralViewModel>> _createStringLiteralViewModels(
  String projectPath,
) async {
  final stringLiterals = <StringLiteralViewModel>[];

  final resolvedUnitResults = await getProjectStructure(projectPath);
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
