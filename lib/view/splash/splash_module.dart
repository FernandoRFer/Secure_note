import 'package:get_it/get_it.dart';
import 'package:secure_note/view/splash/splash_bloc.dart';
import 'package:secure_note/view/splash/splash_view.dart';

class SplashModule {
  static GetIt getIt = GetIt.instance;
  void configure() {
    getIt
      ..registerLazySingleton<ISplashBloc>(() => SplashBloc(getIt()))
      ..registerSingleton(() => SplashView(getIt()));
  }
}
