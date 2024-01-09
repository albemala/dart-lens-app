import 'package:dart_lens/fs.dart';
import 'package:dart_lens/local-store/bloc.dart';
import 'package:dart_lens/preferences/view.dart';
import 'package:dart_lens/routing/functions.dart';
import 'package:dart_lens/widgets/dialog.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bloc.g.dart';

const defaultThemeMode = ThemeMode.light;

@JsonSerializable()
@immutable
class PreferencesState extends Equatable {
  final ThemeMode themeMode;
  final String flutterBinaryPath;

  const PreferencesState({
    required this.themeMode,
    required this.flutterBinaryPath,
  });

  @override
  List<Object?> get props => [
        themeMode,
        flutterBinaryPath,
      ];

  factory PreferencesState.fromJson(Map<String, dynamic> json) {
    return _$PreferencesStateFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PreferencesStateToJson(this);
  }
}

class PreferencesBloc extends Cubit<PreferencesState> {
  final LocalStoreBloc _localStoreBloc;

  final flutterBinaryPathController = TextEditingController();

  factory PreferencesBloc.fromContext(BuildContext context) {
    return PreferencesBloc(
      context,
      context.read<LocalStoreBloc>(),
    );
  }

  PreferencesBloc(
    BuildContext context,
    this._localStoreBloc,
  ) : super(
          const PreferencesState(
            themeMode: defaultThemeMode,
            flutterBinaryPath: '',
          ),
        ) {
    _init(context);
  }

  Future<void> _init(
    BuildContext context,
  ) async {
    await _load();
    flutterBinaryPathController.value = TextEditingValue(
      text: state.flutterBinaryPath,
    );
    // the first time the app is opened,
    // show the preferences dialog if the flutter binary path is empty,
    // so the user can set it
    if (state.flutterBinaryPath.isEmpty) {
      openDialog(
        context,
        createAlertDialog(
          title: 'Preferences',
          content: const PreferencesViewBuilder(),
          onClose: () {
            closeCurrentRoute(context);
          },
        ),
      );
    }
  }

  @override
  Future<void> close() async {
    flutterBinaryPathController.dispose();
    await super.close();
  }

  void setThemeMode(ThemeMode themeMode) {
    _updateStateAndSave(
      themeMode: themeMode,
    );
  }

  Future<void> pickFlutterBinaryPath() async {
    final flutterBinaryFile = await pickExistingFile();
    if (flutterBinaryFile == null) return;
    final path = flutterBinaryFile.path;
    if (path == null) return;
    setFlutterBinaryPath(path);
  }

  void setFlutterBinaryPath(String value) {
    flutterBinaryPathController.value = TextEditingValue(
      text: value,
      selection: flutterBinaryPathController.selection,
    );
    _updateStateAndSave(
      flutterBinaryPath: value,
    );
  }

  void _updateStateAndSave({
    ThemeMode? themeMode,
    String? flutterBinaryPath,
  }) {
    emit(
      PreferencesState(
        themeMode: themeMode ?? state.themeMode,
        flutterBinaryPath: flutterBinaryPath ?? state.flutterBinaryPath,
      ),
    );
    _save();
  }

  static const storeName = 'preferences';

  Future<void> _load() async {
    final map = await _localStoreBloc.load(storeName);
    emit(
      PreferencesState.fromJson(map),
    );
  }

  Future<void> _save() async {
    await _localStoreBloc.save(
      storeName,
      state.toJson(),
    );
  }
}
