import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:secure_note/core/navigator_app.dart';
import 'package:secure_note/core/theme/preferencies_user.dart';
import 'package:secure_note/helpers/helpers_module.dart';
import 'package:secure_note/repositories/repositories_module.dart';

import 'package:secure_note/view/view_module.dart';

class AppModule {
  final GlobalKey<NavigatorState> navigatorKey;
  AppModule(
    this.navigatorKey,
  );
  static GetIt getIt = GetIt.instance;
  // final GlobalRouteObserver globalRouteObserver ;

  void configure() {
    ViewModule().configure();
    RepositoriesModude().configutarion();
    HelpersModule().configutarion();

    getIt
      ..registerLazySingleton<INavigatorApp>(() => NavigatorApp(navigatorKey))
      ..registerSingleton<IUserTheme>(UserTheme());
  }
}

//Exemple modular
// class AppModule extends Module {
//   @override
//   List<Module> get imports => [
//         HomeModule(),
//         RegistesModule(),
//       ];

//   @override
//   List<Bind> get binds => [
//         Bind.singleton<IGlobalError>((i) => GlobalError()),
//         Bind.singleton<IDbNotes>(
//           (i) => DbNotes(),
//         ),
//       ];

//   @override
//   List<ModularRoute> get routes => [
//         ModuleRoute(AppRoutes.splash, module: SplashModule()),
//         ModuleRoute(AppRoutes.auth, module: AuthModule()),
//         ModuleRoute(AppRoutes.home, module: HomeModule()),
//         ModuleRoute(AppRoutes.register, module: RegistesModule()),
//         ModuleRoute(AppRoutes.note, module: NoteModule()),
//         // //ChildRoute('/', child: (_, args) => Modular.get<HomeView>()),
//         // ChildRoute(AppRoutes.register,
//         //     child: (_, args) => const RegisterView()),
//       ];
// }
