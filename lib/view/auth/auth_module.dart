import 'package:get_it/get_it.dart';
import 'package:secure_note/view/auth/auth_bloc.dart';
import 'package:secure_note/view/auth/auth_view.dart';

class AuthModule {
  static GetIt getIt = GetIt.instance;
  void configure() {
    getIt
      ..registerFactory<IAuthBloc>(() => AuthBloc(getIt()))
      ..registerFactory(() => AuthView(getIt()));
  }
}
