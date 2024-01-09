import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

@immutable
class LocalStoreState extends Equatable {
  const LocalStoreState();

  @override
  List<Object?> get props => [];
}

class LocalStoreBloc extends Cubit<LocalStoreState> {
  bool _isInitialized = false;

  factory LocalStoreBloc.fromContext(BuildContext context) {
    return LocalStoreBloc();
  }

  LocalStoreBloc()
      : super(
          const LocalStoreState(),
        ) {
    _init();
  }

  Future<void> _init() async {
    if (!kIsWeb) {
      final appSupportDirectory = await getApplicationSupportDirectory();
      if (kDebugMode) print(appSupportDirectory.path);
      Hive.init(appSupportDirectory.path);
    }
    _isInitialized = true;
  }

  @override
  Future<void> close() async {
    await Hive.close();
    return super.close();
  }

  Future<void> save(String storeName, Map<String, dynamic> map) async {
    await _waitForInitialization();
    final box = await _getBox(storeName);
    await box.put(storeName, map);
  }

  Future<Map<String, dynamic>> load(String storeName) async {
    await _waitForInitialization();
    final box = await _getBox(storeName);
    final map = box.get(storeName) ?? {};
    return Map<String, dynamic>.from(map);
  }

  Future<Box<Map<dynamic, dynamic>>> _getBox(String boxName) {
    return Hive.openBox<Map<dynamic, dynamic>>(boxName);
  }

  Future<void> _waitForInitialization() async {
    while (!_isInitialized) {
      await Future<void>.delayed(const Duration(milliseconds: 300));
    }
  }
}
