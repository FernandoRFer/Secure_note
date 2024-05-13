import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'package:secure_note/code/navigator_app.dart';
import 'package:secure_note/core/router/routes.dart';
import 'package:secure_note/helpers/global_error.dart';
import 'package:secure_note/repositories/local_data_source/Model/user_model.dart';

class RegisterModelBloc {
  bool isLoading;
  UserModel? userModel;

  RegisterModelBloc({
    this.isLoading = true,
    this.userModel,
  });
}

abstract class IRegisterlBloc {
  Stream<RegisterModelBloc> get onFetchingData;
  Future<bool> saveRegister(UserModel userModel);
  void navigatoHome();
  void navigatoPop();
  void dispose();
}

class RegisterlBloc extends ChangeNotifier implements IRegisterlBloc {
  final INavigatorApp _navigatorApp;
  final IGlobalError _globalError;

  RegisterlBloc(
    this._navigatorApp,
    this._globalError,
  );

  final _fetchingDataController = BehaviorSubject<RegisterModelBloc>();
  @override
  Future<bool> saveRegister(UserModel userModel) async {
    try {
      _fetchingDataController.add(RegisterModelBloc(isLoading: true));
      await Future.delayed(const Duration(seconds: 2));

      _fetchingDataController.add(RegisterModelBloc(isLoading: false));

      return true;
    } catch (e) {
      final globalError = await _globalError.errorHandling(
          "Erro ao salvar registros", e, StackTrace.current);
      _fetchingDataController.addError(globalError);
    }
    return false;
  }

  @override
  void navigatoPop() {
    _fetchingDataController.add(RegisterModelBloc(isLoading: false));
    _navigatorApp.pop();
  }

  @override
  void navigatoHome() {
    _navigatorApp.popUntil(AppRoutes.home);
  }

  @override
  Stream<RegisterModelBloc> get onFetchingData =>
      _fetchingDataController.stream;

  @override
  void dispose() {
    _fetchingDataController.close();
    super.dispose();
  }
}
