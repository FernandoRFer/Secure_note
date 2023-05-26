import 'package:flutter_modular/flutter_modular.dart';
import 'package:secure_note/view/register/register_bloc.dart';
import 'package:secure_note/view/register/register_view.dart';

class RegistesModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton<IRegisterlBloc>((i) => RegisterlBloc()),
        Bind.singleton(
          (i) => RegisterView(i()),
        ),
      ];
  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute,
            child: (_, args) => Modular.get<RegisterView>()),
      ];
}
