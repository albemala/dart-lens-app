import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class LocalStorageConductor extends ChangeNotifier implements StorageConductor {
  factory LocalStorageConductor.fromContext(BuildContext context) {
    return LocalStorageConductor();
  }

  LocalStorageConductor() {
    _init();
  }

  bool _isInitialized = false;

  @override
  bool get isInitialized => _isInitialized;

  Future<void> _init() async {
    if (!kIsWeb) {
      final appSupportDirectory = await getApplicationSupportDirectory();
      if (kDebugMode) print(appSupportDirectory.path);
      Hive.init(appSupportDirectory.path);
    }
    _isInitialized = true;
    notifyListeners();
  }

  @override
  Future<void> dispose() async {
    await Hive.close();
    super.dispose();
  }

  @override
  void register<T extends StoredConductorMixin>(T conductor) {
    conductor.addListener(() => _save(conductor));
  }

  @override
  void unregister<T extends StoredConductorMixin>(T conductor) {
    conductor.removeListener(() => _save(conductor));
  }

  Future<void> _save<T extends StoredConductorMixin>(T conductor) async {
    final box = await _getBox(conductor.storeName);
    final map = conductor.toMap();
    await box.put(conductor.storeName, map);
  }

  @override
  Future<void> load<T extends StoredConductorMixin>(T conductor) async {
    final box = await _getBox(conductor.storeName);
    final map = box.get(conductor.storeName) ?? {};
    conductor.fromMap(Map<String, dynamic>.from(map));
  }

  Future<Box<Map<dynamic, dynamic>>> _getBox(String boxName) {
    return Hive.openBox<Map<dynamic, dynamic>>(boxName);
  }
}

abstract class StorageConductor extends ChangeNotifier {
  bool get isInitialized;
  void register<T extends StoredConductorMixin>(T conductor);
  void unregister<T extends StoredConductorMixin>(T conductor);
  Future<void> load<T extends StoredConductorMixin>(T conductor);
}

mixin StoredConductorMixin on ChangeNotifier {
  StorageConductor get storageConductor;

  Future<void> init() async {
    await _waitForInitialization();
    await storageConductor.load(this);
    notifyListeners();
    storageConductor.register(this);
  }

  Future<void> _waitForInitialization() async {
    while (!storageConductor.isInitialized) {
      await Future<void>.delayed(const Duration(milliseconds: 300));
    }
  }

  @override
  void dispose() {
    storageConductor.unregister(this);
    super.dispose();
  }

  String get storeName;
  Map<String, dynamic> toMap();
  void fromMap(Map<String, dynamic> map);
}
