import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:secure_note/routes.dart';

abstract class ISplashBloc {
  Future<void> load();
  void navigatoHome();
}

class SplashBloc extends BlocBase with ISplashBloc {
  @override
  Future<void> load() async {
    try {
      await Future.delayed(const Duration(seconds: 2));
      navigatoHome();
    } catch (e) {
      // _fetchingDataController.addError(
      //   "Um erro  ocorreu ao conectar, tente novamente - $e",
      // );
    }
  }

  @override
  void navigatoHome() {
    Modular.to.navigate(AppRoutes.auth);
  }
}
