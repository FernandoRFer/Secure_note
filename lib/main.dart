import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:secure_note/core/module.dart';
import 'package:secure_note/core/navigator_observer.dart';
import 'package:secure_note/core/router/routes.dart';
import 'package:secure_note/core/theme/preferencies_user.dart';

void main() async {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  final globalRouteObserver = GlobalRouteObserver();

  WidgetsFlutterBinding.ensureInitialized();
  AppModule(navigatorKey).configure();
  final userTheme = GetIt.I.get<IUserTheme>();
  await userTheme.setColor();

  return runApp(ThemeWidget(
      notifier: userTheme,
      child: AppWidget(navigatorKey, globalRouteObserver)));
}

class AppWidget extends StatefulWidget {
  final GlobalKey<NavigatorState> _navigatorKey;
  final GlobalRouteObserver _globalRouteObserver;
  const AppWidget(
    this._navigatorKey,
    this._globalRouteObserver, {
    super.key,
  });

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    final userTheme = ThemeWidget.of(context);
    final userThmeModel = userTheme.value;
    return MaterialApp(
      navigatorObservers: [widget._globalRouteObserver],
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      navigatorKey: widget._navigatorKey,
      title: 'Secure Note',
      //Passar tema para pasta Thema
      theme: ThemeData(
        //  brightness: userThmeModel.brightness,
        colorScheme: userThmeModel.colorScheme,
        fontFamily: "exo2",
        // primarySwatch: const Color(0xff263238),
        useMaterial3: true,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 24,
          ),
          bodyMedium: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20,
          ),
        ),
      ),
      initialRoute: AppRoutes.initial,
      routes: AppRoutes.routes,
    );
  }
}

class ThemeWidget extends InheritedNotifier<IUserTheme> {
  const ThemeWidget(
      {Key? key, required IUserTheme notifier, required Widget child})
      : super(key: key, child: child, notifier: notifier);

  static IUserTheme of(BuildContext context) {
    final inherited = context.dependOnInheritedWidgetOfExactType<ThemeWidget>();
    return inherited!.notifier!;
  }
}
