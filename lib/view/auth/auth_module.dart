import 'package:flutter_modular/flutter_modular.dart';
import 'package:secure_note/view/auth/auth_bloc.dart';
import 'package:secure_note/view/auth/auth_view.dart';

class AuthModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton<IAuthBloc>(
          (i) => AuthBloc(),
          //  onDispose: (bloc) => bloc.dispose()
        ),
        Bind.singleton((i) => AuthView(i())),
      ];
  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute,
            child: (_, args) => Modular.get<AuthView>()),
      ];
}
