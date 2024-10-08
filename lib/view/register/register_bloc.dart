// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import 'package:secure_note/core/navigator_app.dart';
import 'package:secure_note/core/router/routes.dart';
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

class RegisterlBloc implements IRegisterlBloc {
  final INavigatorApp _navigatorApp;

  RegisterlBloc(
    this._navigatorApp,
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
      _fetchingDataController.addError(
        "Um erro  ocorreu ao conectar, tente novamente - $e",
      );
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
  Future<void> dispose() async {
    log("dispose stream");
    await _fetchingDataController.close();
  }
}
