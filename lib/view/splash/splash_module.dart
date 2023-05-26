import 'package:flutter_modular/flutter_modular.dart';
import 'package:secure_note/view/splash/splash_bloc.dart';
import 'package:secure_note/view/splash/splash_view.dart';

class SplashModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton<ISplashBloc>(
          (i) => SplashBloc(),
        ),
        Bind.singleton(
          (i) => SplashView(i()),
        ),
      ];
  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute,
            child: (_, args) => Modular.get<SplashView>()),
      ];
}
