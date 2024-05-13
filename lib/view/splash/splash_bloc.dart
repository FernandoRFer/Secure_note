// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import 'package:secure_note/code/navigator_app.dart';
import 'package:secure_note/core/router/routes.dart';
import 'package:secure_note/core/theme/preferencies_user.dart';

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
  void setTheme();
  void dispose();
}

class SplashBloc extends ChangeNotifier implements ISplashBloc {
  final _fetchingDataController = BehaviorSubject<SplashModel>();

  final INavigatorApp _navigatorApp;
  final IUserTheme _userTheme;
  SplashBloc(
    this._navigatorApp,
    this._userTheme,
  );

  @override
  Future<void> load() async {
    try {
      _fetchingDataController.add(SplashModel(iconData: true));

      await Future.wait([
        _userTheme.setColor(),
        Future.delayed(const Duration(seconds: 2)),
      ]);
      // _fetchingDataController.add(SplashModel(iconData: false));
      // await Future.delayed(const Duration(seconds: 1));

      _fetchingDataController.add(SplashModel(iconData: false));
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

  @override
  void setTheme() async {
    _userTheme.setColor();
  }
}
