import 'package:dart_lens/conductors/local-storage-conductor.dart';
import 'package:dart_lens/conductors/routing-conductor.dart';
import 'package:dart_lens/functions/fs.dart';
import 'package:dart_lens/views/preferences-view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _defaultThemeMode = ThemeMode.light;

class PreferencesConductor extends ChangeNotifier with StoredConductorMixin {
  factory PreferencesConductor.fromContext(BuildContext context) {
    return PreferencesConductor(
      context.read<RoutingConductor>(),
      context.read<LocalStorageConductor>(),
    );
  }

  PreferencesConductor(
    this._routingConductor,
    this._localStorageConductor,
  ) {
    _init();
  }

  Future<void> _init() async {
    await init();
    // the first time the app is opened,
    // show the preferences dialog if the flutter binary path is empty,
    // so the user can set it
    if (flutterBinaryPath.isEmpty) {
      _routingConductor.showDialog(
        (context) => PreferencesView.create(
          context,
          onClose: _routingConductor.closeCurrentRoute,
        ),
      );
    }
  }

  final RoutingConductor _routingConductor;
  final LocalStorageConductor _localStorageConductor;

  @override
  StorageConductor get storageConductor => _localStorageConductor;

  var _themeMode = _defaultThemeMode;

  final _flutterBinaryPathController = TextEditingController();

  ThemeMode get themeMode => _themeMode;

  TextEditingController get flutterBinaryPathController =>
      _flutterBinaryPathController;

  String get flutterBinaryPath => _flutterBinaryPathController.text;

  @override
  void dispose() {
    _flutterBinaryPathController.dispose();
    super.dispose();
  }

  void setThemeMode(ThemeMode themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }

  void setFlutterBinaryPath(String value) {
    _flutterBinaryPathController.value = TextEditingValue(
      text: value,
      selection: _flutterBinaryPathController.selection,
    );
    notifyListeners();
  }

  Future<void> pickFlutterBinaryPath() async {
    final flutterBinaryFile = await pickExistingFile();
    if (flutterBinaryFile == null) return;
    final path = flutterBinaryFile.path;
    if (path == null) return;
    setFlutterBinaryPath(path);
  }

  @override
  String get storeName => 'preferences';

  static const _themeModeKey = 'themeMode';
  static const _flutterBinaryKey = 'flutterBinaryPath';

  @override
  Map<String, dynamic> toMap() {
    return {
      _themeModeKey: _themeMode.index,
      _flutterBinaryKey: _flutterBinaryPathController.text,
    };
  }

  @override
  void fromMap(Map<String, dynamic> map) {
    final themeModeIndex =
        map[_themeModeKey] as int? ?? _defaultThemeMode.index;
    _themeMode = ThemeMode.values[themeModeIndex];
    _flutterBinaryPathController.text = map[_flutterBinaryKey] as String? ?? '';
  }
}
