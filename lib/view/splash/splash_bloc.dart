import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

import 'package:secure_note/code/navigator_app.dart';
import 'package:secure_note/core/router/routes.dart';
import 'package:secure_note/core/theme/preferencies_user.dart';
import 'package:secure_note/helpers/global_error.dart';

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
  final IGlobalError _globalError;
  final IUserTheme _userTheme;
  SplashBloc(
    this._navigatorApp,
    this._userTheme,
    this._globalError,
  );

  @override
  Future<void> load() async {
    try {
      _fetchingDataController.add(SplashModel(iconData: true));

      await Future.wait([
        _userTheme.setColor(),
        Future.delayed(const Duration(seconds: 2)),
      ]);

      _fetchingDataController.add(SplashModel(iconData: false));
      navigatoHome();
    } catch (e) {
      final globalError = await _globalError.errorHandling(
          "Erro ao carregar splash", e, StackTrace.current);
      _fetchingDataController.addError(globalError);
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
