import 'package:get_it/get_it.dart';
import 'package:secure_note/view/register/register_bloc.dart';
import 'package:secure_note/view/register/register_view.dart';

class RegistesModule {
  static GetIt getIt = GetIt.instance;
  void configure() {
    getIt
      ..registerFactory<IRegisterlBloc>(() => RegisterlBloc(getIt(), getIt()))
      ..registerFactory(() => RegisterView(getIt()));
  }
}
