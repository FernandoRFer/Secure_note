import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:secure_note/view/auth/auth_view.dart';
import 'package:secure_note/view/home/home_view.dart';
import 'package:secure_note/view/note/note_view.dart';
import 'package:secure_note/view/register/register_view.dart';
import 'package:secure_note/view/splash/splash_bloc.dart';
import 'package:secure_note/view/splash/splash_view.dart';

class AppRoutes {
  static const String initial = splash;
  static const String home = "/home";
  static const String auth = "/auth";
  static const String register = "/register";
  static const String note = "/note";
  static const String splash = "/splash";

  static GetIt getIt = GetIt.I;

  static Map<String, WidgetBuilder> get routes => {
        splash: (_) => SplashView(getIt.get<ISplashBloc>()),
        home: (_) => getIt.get<HomeView>(),
        note: (_) => getIt.get<NoteView>(),
        auth: (_) => getIt.get<AuthView>(),
        register: (_) => getIt.get<RegisterView>(),
      };
}
