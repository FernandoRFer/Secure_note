// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

import 'package:secure_note/routes.dart';

class SplashModel {
  bool iconData;

  SplashModel({
    this.iconData = true,
  });
}

abstract class ISplashBloc {
  Stream<SplashModel> get onFetchingData;
  Future<void> load();
  void navigatoHome();
  void dispose();
}

class SplashBloc extends ChangeNotifier implements ISplashBloc {
  final _fetchingDataController = BehaviorSubject<SplashModel>();

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
  void navigatoHome() {
    Modular.to.navigate(AppRoutes.auth);
  }
}
