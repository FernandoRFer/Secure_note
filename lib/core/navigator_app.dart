import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:secure_note/core/navigator_observer.dart';

abstract class INavigatorApp {
  Future<T?> pushReplacementNamed<T extends Object, TO extends Object>(
      String routeName,
      {TO? result,
      Object? arguments});

  Future<T?> pushNamed<T extends Object>(String routeName, {Object? arguments});

  Future<T?> popAndPushNamed<T extends Object>(String routeName,
      {Object? arguments});

  void popUntil(String routeName);
  void pop<T extends Object>([T? result]);

  String? currentRoute();

  BuildContext? get currentContext;
}

class NavigatorApp implements INavigatorApp {
  final GlobalKey<NavigatorState> navigatorKey;

  NavigatorApp(
    this.navigatorKey,
  );

  @override
  Future<T?> pushReplacementNamed<T extends Object, TO extends Object>(
      String routeName,
      {TO? result,
      Object? arguments}) async {
    return await navigatorKey.currentState!
        .pushReplacementNamed(routeName, result: result, arguments: arguments);
  }

  @override
  Future<T?> pushNamed<T extends Object>(String routeName,
      {Object? arguments}) async {
    try {
      return await navigatorKey.currentState!
          .pushNamed(routeName, arguments: arguments);
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  @override
  void pop<T extends Object>([T? result]) {
    navigatorKey.currentState?.pop(result);
  }

  @override
  void popUntil(String routeName) {
    navigatorKey.currentState?.popUntil(ModalRoute.withName(routeName));
  }

  @override
  Future<T?> popAndPushNamed<T extends Object>(String routeName,
      {Object? arguments}) async {
    return navigatorKey.currentState
        ?.popAndPushNamed(routeName, arguments: arguments);
  }

  @override
  BuildContext? get currentContext => navigatorKey.currentContext;

  @override
  String? currentRoute() {
    return GlobalRouteObserver.routeStack.last;
  }
}
