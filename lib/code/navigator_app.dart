import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';

abstract class INavigator {
  void navigate<T extends Object>(
    String routeName,
  );
  Future<T?> pushReplacementNamed<T extends Object>(
    String routeName, {
    Object? arguments,
  });
  Future<T?> pushNamed<T extends Object>(String routeName, {Object? arguments});

  Future<T?> popAndPushNamed<T extends Object>(String routeName,
      {Object? arguments});

  void popUntil(String routeName);
  void pop<T extends Object>([T? result]);
  Future<T?> pushNamedAndRemoveUntil<T extends Object>(
    String routeName,
    bool Function(Route p1) predicate, {
    Object? arguments,
  });
  String? currentRoute();

  // BuildContext? get currentContext;
}

class Navigator extends ChangeNotifier implements INavigator {
  // final GlobalKey<NavigatorState> navigatorKey;
  // final IAppLog _appLog;
  // final GlobalRouteObserver _globalRouteObserver;

  @override
  Future<T?> pushReplacementNamed<T extends Object>(String routeName,
      {Object? arguments}) async {
    try {
      return await Modular.to
          .pushReplacementNamed(routeName, arguments: arguments);
    } catch (e) {
      // _appLog.severe(
      //     "pushReplacementNamed $routeName fatal error... Reiniciando app");
    }
    return null;
  }

  @override
  Future<T?> pushNamed<T extends Object>(String routeName,
      {Object? arguments}) async {
    try {
      return await Modular.to.pushNamed(routeName, arguments: arguments);
    } catch (e) {
      // _appLog.severe("pushNamed $routeName fatal error... Reiniciando app");
    }
    return null;
  }

  @override
  void pop<T extends Object>([T? result]) {
    try {
      Modular.to.pop(result);
    } catch (e) {
      // _appLog.severe("pop fatal error... Reiniciando app");
    }
  }

  @override
  void popUntil(String routeName) {
    try {
      Modular.to.popUntil(ModalRoute.withName(routeName));
    } catch (e) {
      // _appLog.severe("popUntil $routeName fatal error... Reiniciando app");
    }
  }

  @override
  Future<T?> popAndPushNamed<T extends Object>(String routeName,
      {Object? arguments}) async {
    try {
      return Modular.to.popAndPushNamed(routeName, arguments: arguments);
    } catch (e) {
      // _appLog.severe("popUntil $routeName fatal error... Reiniciando app");
    }
    return null;
  }

  // @override
  // BuildContext? get currentContext => navigatorKey.currentContext;

  @override
  Future<T?> pushNamedAndRemoveUntil<T extends Object>(
    String routeName,
    bool Function(Route p1) predicate, {
    Object? arguments,
  }) async {
    try {
      return await Modular.to.pushNamedAndRemoveUntil(
        routeName,
        (route) => false,
        arguments: arguments,
      );
    } catch (e) {
      // _appLog.severe("popUntil $routeName fatal error... Reiniciando app");
    }
    return null;
  }

  @override
  void navigate<T extends Object>(
    String routeName,
  ) async {
    try {
      return Modular.to.navigate(
        routeName,
      );
    } catch (e) {
      // _appLog.severe("popUntil $routeName fatal error... Reiniciando app");
    }
    return null;
  }

  @override
  String? currentRoute() {
    return Modular.to.path;
  }
}
