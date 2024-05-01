// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import 'package:secure_note/code/navigator_app.dart';
import 'package:secure_note/core/router/routes.dart';

class SplashModel {
  bool iconData;

  SplashModel({
    this.iconData = true,
  });
}

abstract class ISplashBloc {
  Stream<SplashModel> get onFetchingData;
  Future<void> load();
  Future<void> navigatoHome();
  void dispose();
}

class SplashBloc extends ChangeNotifier implements ISplashBloc {
  final _fetchingDataController = BehaviorSubject<SplashModel>();

  final INavigatorApp _navigatorApp;
  SplashBloc(
    this._navigatorApp,
  );

  @override
  Future<void> load() async {
    try {
      // carregamento de funções
      // await Future.delayed(const Duration(seconds: 1));
      // _fetchingDataController.add(SplashModel(iconData: false));
      // await Future.delayed(const Duration(seconds: 1));
      navigatoHome();
    } catch (e) {
      // _fetchingDataController.addError(
      //   "Um erro  ocorreu ao conectar, tente novamente - $e",
      // );
    }
  }

  @override
  Stream<SplashModel> get onFetchingData => _fetchingDataController.stream;

  @override
  Future<void> navigatoHome() async {
    await _navigatorApp.pushNamed(AppRoutes.auth).then((_) => load());
  }
}
