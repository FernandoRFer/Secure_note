// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:secure_note/module.dart';

void main() {
  return runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

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
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
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
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
