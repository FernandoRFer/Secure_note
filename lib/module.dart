import 'package:flutter_modular/flutter_modular.dart';
import 'package:secure_note/repositories/local_data_source/bd/db_note.dart';
import 'package:secure_note/routes.dart';
import 'package:secure_note/view/auth/auth_module.dart';
import 'package:secure_note/view/home/home_module.dart';
import 'package:secure_note/view/note/note_module.dart';
import 'package:secure_note/view/register/register_module.dart';
import 'package:secure_note/view/splash/splash_module.dart';

class AppModule extends Module {
  @override
  List<Module> get imports => [
        HomeModule(),
        RegistesModule(),
      ];

  @override
  List<Bind> get binds => [
        Bind.singleton<IDbNotes>(
          (i) => DbNotes(),
        ),
      ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: SplashModule()),
        ModuleRoute(AppRoutes.auth, module: AuthModule()),
        ModuleRoute(AppRoutes.home, module: HomeModule()),
        ModuleRoute(AppRoutes.register, module: RegistesModule()),
        ModuleRoute(AppRoutes.note, module: NoteModule()),
        // //ChildRoute('/', child: (_, args) => Modular.get<HomeView>()),
        // ChildRoute(AppRoutes.register,
        //     child: (_, args) => const RegisterView()),
      ];
}
