import 'package:flutter/material.dart';
import 'package:secure_note/core/module.dart';
import 'package:secure_note/core/navigator_observer.dart';
import 'package:secure_note/core/router/routes.dart';

void main() {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  final globalRouteObserver = GlobalRouteObserver();
  GlobalRouteObserver();

  WidgetsFlutterBinding.ensureInitialized();

  AppModule(navigatorKey).configure();

  return runApp(AppWidget(navigatorKey, globalRouteObserver));
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
  static _AppWidgetState? of(BuildContext context) =>
      context.findAncestorStateOfType<_AppWidgetState>();
}

class _AppWidgetState extends State<AppWidget> {
  Brightness _brightness = Brightness.light;

  void changeTheme(Brightness brightness) {
    setState(() {
      _brightness = brightness;
    });
  }

  @override
  Widget build(BuildContext context) {
    var colorScheme = ColorScheme.fromSeed(
      brightness: _brightness,
      //secondary: const Color(0xff263238),
      //primary: const Color(0xff263238),
      seedColor: const Color.fromARGB(255, 1, 21, 30),
      // background: const Color.fromARGB(255, 207, 207, 207),
      // surface: const Color.fromARGB(255, 207, 207, 207),

      //onPrimary: Colors.white,
      //brightness: Brightness.dark,
    );
    return MaterialApp(
      navigatorObservers: [widget._globalRouteObserver],
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      navigatorKey: widget._navigatorKey,
      title: 'Secure Note',
      theme: ThemeData(
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
        colorScheme: colorScheme,
      ),
      initialRoute: AppRoutes.initial,
      routes: AppRoutes.routes,
    );
  }
}
