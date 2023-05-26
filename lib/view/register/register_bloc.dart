// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

import 'package:secure_note/repositories/local_data_source/Model/user_model.dart';
import 'package:secure_note/routes.dart';

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
}

class RegisterlBloc extends BlocBase with IRegisterlBloc {
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
    Modular.to.pop();
    _fetchingDataController.add(RegisterModelBloc(isLoading: false));
  }

  @override
  void navigatoHome() {
    Modular.to.popUntil(ModalRoute.withName(AppRoutes.home));
  }

  @override
  Stream<RegisterModelBloc> get onFetchingData =>
      _fetchingDataController.stream;
}
