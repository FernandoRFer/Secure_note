import 'package:flutter_modular/flutter_modular.dart';
import 'package:secure_note/view/home/home_bloc.dart';
import 'package:secure_note/view/home/home_view.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton<IHomeBloc>((i) => HomeBloc()),
        Bind.singleton((i) => HomeView(i())),
      ];
  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute,
            child: (_, args) => Modular.get<HomeView>()),
      ];
}
