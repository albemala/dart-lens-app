import 'dart:async';

import 'package:flutter/material.dart';

sealed class RoutingAction {}

class ShowSnackBar implements RoutingAction {
  final SnackBar Function(BuildContext context) builder;
  ShowSnackBar(this.builder);
}

class ShowDialog implements RoutingAction {
  final AlertDialog Function(BuildContext context) builder;
  ShowDialog(this.builder);
}

class ShowBottomSheet implements RoutingAction {
  final Widget Function(BuildContext context) builder;
  ShowBottomSheet(this.builder);
}

class OpenRoute implements RoutingAction {
  final Widget Function(BuildContext context) builder;
  OpenRoute(this.builder);
}

class CloseCurrentRoute implements RoutingAction {}

class RoutingConductor extends ChangeNotifier {
  factory RoutingConductor.fromContext(BuildContext context) {
    return RoutingConductor();
  }

  RoutingConductor();

  final _routingStreamController = StreamController<RoutingAction>();

  Stream<RoutingAction> get routingStream => _routingStreamController.stream;

  @override
  void dispose() {
    _routingStreamController.close();
    super.dispose();
  }

  void showSnackBar(SnackBar Function(BuildContext context) builder) {
    _routingStreamController.add(ShowSnackBar(builder));
  }

  void showDialog(AlertDialog Function(BuildContext context) builder) {
    _routingStreamController.add(ShowDialog(builder));
  }

  void showBottomSheet(Widget Function(BuildContext context) builder) {
    _routingStreamController.add(ShowBottomSheet(builder));
  }

  void openRoute(Widget Function(BuildContext context) builder) {
    _routingStreamController.add(OpenRoute(builder));
  }

  void closeCurrentRoute() {
    _routingStreamController.add(CloseCurrentRoute());
  }
}

class RoutingView extends StatefulWidget {
  final Stream<RoutingAction> routingStream;
  final Widget child;

  const RoutingView({
    super.key,
    required this.routingStream,
    required this.child,
  });

  @override
  State<RoutingView> createState() => _RoutingViewState();
}

class _RoutingViewState extends State<RoutingView> {
  late StreamSubscription<RoutingAction> _routingSubscription;

  @override
  void initState() {
    super.initState();

    _routingSubscription = widget.routingStream.listen((action) {
      _handleRouting(context, action);
    });
  }

  @override
  void dispose() {
    _routingSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

void _handleRouting(BuildContext context, RoutingAction action) {
  switch (action) {
    case ShowSnackBar(builder: final builder):
      _showSnackBar(context, builder);
    case ShowDialog(builder: final builder):
      _showDialog(context, builder);
    case ShowBottomSheet(builder: final builder):
      _showBottomSheet(context, builder);
    case OpenRoute(builder: final builder):
      _openRoute(context, builder);
    case CloseCurrentRoute():
      _closeCurrentRoute(context);
  }
}

void _showSnackBar(
  BuildContext context,
  SnackBar Function(BuildContext context) builder,
) {
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(builder(context));
}

void _showDialog(
  BuildContext context,
  AlertDialog Function(BuildContext context) builder,
) {
  showDialog<void>(
    context: context,
    builder: (_) => builder(context),
  );
}

void _showBottomSheet(
  BuildContext context,
  Widget Function(BuildContext context) builder,
) {
  showModalBottomSheet<void>(
    context: context,
    builder: (_) => builder(context),
  );
}

void _openRoute(
  BuildContext context,
  Widget Function(BuildContext context) builder,
) {
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) => builder(context),
    ),
  );
}

void _closeCurrentRoute(BuildContext context) {
  Navigator.of(context).pop();
}
