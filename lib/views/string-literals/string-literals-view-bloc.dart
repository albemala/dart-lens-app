import 'dart:async';

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:dart_lens/blocs/project-analysis-bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:path/path.dart';

part 'string-literals-view-bloc.freezed.dart';

enum StringLiteralContext {
  import,
  widget,
  other,
}

@freezed
class StringLiteralsViewModel with _$StringLiteralsViewModel {
  const StringLiteralsViewModel._();

  const factory StringLiteralsViewModel({
    required List<StringLiteralViewModel> stringLiterals,
  }) = _StringLiteralsViewModel;
}

@freezed
class StringLiteralViewModel with _$StringLiteralViewModel {
  const StringLiteralViewModel._();

  const factory StringLiteralViewModel({
    required String string,
    required String path,
    required int lineNumber,
    required StringLiteralContext context,
  }) = _StringLiteralViewModel;
}

class StringLiteralVisitor extends RecursiveAstVisitor<void> {
  final List<StringLiteralViewModel> strings = [];

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

    final context = _getStringLiteralContext(node);

    final viewModel = StringLiteralViewModel(
      string: stringValue,
      path: '',
      lineNumber: 0, // TODO
      context: context,
    );
    strings.add(viewModel);
  }

  StringLiteralContext _getStringLiteralContext(SimpleStringLiteral node) {
    if (node.parent is ImportDirective) {
      return StringLiteralContext.import;
    }
    // TODO
    // return StringLiteralContext.widget;
    return StringLiteralContext.other;
  }
}

class StringLiteralsViewBloc extends Cubit<StringLiteralsViewModel> {
  final BuildContext context;
  late StreamSubscription<ProjectAnalysisBlocState> projectAnalysisBlocListener;

  StringLiteralsViewBloc(this.context)
      : super(
          const StringLiteralsViewModel(
            stringLiterals: [],
          ),
        ) {
    projectAnalysisBlocListener = context //
        .read<ProjectAnalysisBloc>()
        .stream
        .listen((projectAnalysisBlocState) {
      _updateState();
    });
    _updateState();
  }

  void _updateState() {
    final projectAnalysisBlocState = context.read<ProjectAnalysisBloc>().state;

    final projectPath = projectAnalysisBlocState.projectPath ?? '';

    final stringLiterals = <StringLiteralViewModel>[];
    projectAnalysisBlocState.resolvedUnitResults?.forEach((resolvedUnitResult) {
      final filePath = relative(
        resolvedUnitResult.path,
        from: projectPath,
      );

      // iterate over all declarations in this unit and find all string literals
      final visitor = StringLiteralVisitor();
      resolvedUnitResult.unit.visitChildren(visitor);
      for (final string in visitor.strings) {
        stringLiterals.add(
          string.copyWith(
            path: filePath,
          ),
        );
      }
    });

    emit(
      state.copyWith(
        stringLiterals: stringLiterals,
      ),
    );
  }

  @override
  Future<void> close() {
    projectAnalysisBlocListener.cancel();
    return super.close();
  }
}
