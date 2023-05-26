import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:secure_note/routes.dart';

abstract class IHomeBloc {
  void navigatorRegister();
}

class HomeBloc extends BlocBase with IHomeBloc {
  @override
  void navigatorRegister() {
    Modular.to.pushNamed(AppRoutes.register);
  }
}
