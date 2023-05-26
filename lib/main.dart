import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:secure_note/module.dart';
import 'package:secure_note/theme.dart';

void main() {
  return runApp(ModularApp(module: AppModule(), child: const AppWidget()));
}

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Secure Note',
      theme: ThemeData(
        fontFamily: "exo2",
        primarySwatch: AppTheme.blackColor,
        brightness: Brightness.dark,
      ),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
