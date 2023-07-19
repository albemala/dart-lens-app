import 'package:flutter/foundation.dart';

class BlocValue<T> {
  late final ValueNotifier<T> _valueNotifier;
  final void Function() _onChange;

  BlocValue({
    required T initialValue,
    required void Function() onChange,
  }) : _onChange = onChange {
    _valueNotifier = ValueNotifier<T>(initialValue);
    _valueNotifier.addListener(_onChange);
  }

  T get value => _valueNotifier.value;

  set value(T newValue) => _valueNotifier.value = newValue;

  void dispose() {
    _valueNotifier
      ..removeListener(_onChange)
      ..dispose();
  }
}
