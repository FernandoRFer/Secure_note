// import 'package:bloc_pattern/bloc_pattern.dart';
// import 'package:flutter/widgets.dart';
// import 'package:pos/app_log.dart';
// import 'package:pos/navigator_observer.dart';

// abstract class INavigatorBloc {
//   Future<T?> pushReplacementNamed<T extends Object, TO extends Object>(
//       String routeName,
//       {TO? result,
//       Object? arguments});

//   Future<T?> pushNamed<T extends Object>(String routeName, {Object? arguments});
//   Future<T?> pushNamedAndRemoveUntil<T extends Object>(
//     String routeName,
//     bool Function(Route<dynamic>) predicate, {
//     Object? arguments,
//   });

//   Future<T?> popAndPushNamed<T extends Object>(String routeName,
//       {Object? arguments});

//   void popUntil(String routeName);
//   void pop<T extends Object>([T? result]);

//   String? currentRoute();

//   BuildContext? get currentContext;
// }

// class NavigatorBloc extends ChangeNotifier implements INavigatorBloc {
//   final GlobalKey<NavigatorState> navigatorKey;
//   final IAppLog _appLog;
//   final GlobalRouteObserver _globalRouteObserver;
//   NavigatorBloc(this._appLog, this._globalRouteObserver,
//       {required this.navigatorKey});

//   @override
//   Future<T?> pushReplacementNamed<T extends Object, TO extends Object>(
//       String routeName,
//       {TO? result,
//       Object? arguments}) async {
//     try {
//       return await navigatorKey.currentState!.pushReplacementNamed(routeName,
//           result: result, arguments: arguments);
//     } catch (e) {
//       _appLog.severe(
//           "pushReplacementNamed $routeName fatal error... Reiniciando app");
//     }
//     return null;
//   }

//   @override
//   Future<T?> pushNamed<T extends Object>(String routeName,
//       {Object? arguments}) async {
//     try {
//       return await navigatorKey.currentState!
//           .pushNamed(routeName, arguments: arguments);
//     } catch (e) {
//       _appLog.severe("pushNamed $routeName fatal error... Reiniciando app");
//     }
//     return null;
//   }

//   @override
//   void pop<T extends Object>([T? result]) {
//     try {
//       navigatorKey.currentState?.pop(result);
//     } catch (e) {
//       _appLog.severe("pop fatal error... Reiniciando app");
//     }
//   }

//   @override
//   void popUntil(String routeName) {
//     try {
//       // log(_globalRouteObserver.currentRoute.toString());
//       // // Se já estiver na rota que deve voltar, não faz nada
//       // if (navigatorKey.currentContext != null) {
//       //   final route = ModalRoute.of(navigatorKey.currentContext!);

//       //   if (route != null) {
//       //     if (route.settings.name == routeName) {
//       //       return;
//       //     }
//       //   }
//       // }

//       navigatorKey.currentState?.popUntil(ModalRoute.withName(routeName));
//     } catch (e) {
//       _appLog.severe("popUntil $routeName fatal error... Reiniciando app");
//     }
//   }

//   @override
//   Future<T?> popAndPushNamed<T extends Object>(String routeName,
//       {Object? arguments}) async {
//     try {
//       return navigatorKey.currentState
//           ?.popAndPushNamed(routeName, arguments: arguments);
//     } catch (e) {
//       _appLog.severe("popUntil $routeName fatal error... Reiniciando app");
//     }
//     return null;
//   }

//   @override
//   BuildContext? get currentContext => navigatorKey.currentContext;

//   @override
//   Future<T?> pushNamedAndRemoveUntil<T extends Object>(
//     String routeName,
//     bool Function(Route p1) predicate, {
//     Object? arguments,
//   }) async {
//     try {
//       return await navigatorKey.currentState!.pushNamedAndRemoveUntil(
//         routeName,
//         (route) => false,
//         arguments: arguments,
//       );
//     } catch (e) {
//       _appLog.severe("popUntil $routeName fatal error... Reiniciando app");
//     }
//     return null;
//   }

//   @override
//   String? currentRoute() {
//     return _globalRouteObserver.currentRoute;
//   }
// }
