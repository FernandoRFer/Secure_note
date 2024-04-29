import 'package:get_it/get_it.dart';
import 'package:secure_note/view/home/home_bloc.dart';
import 'package:secure_note/view/home/home_view.dart';

class HomeModule {
  static GetIt getIt = GetIt.instance;
  void configure() {
    getIt
      ..registerFactory<IHomeBloc>(() => HomeBloc(getIt(), getIt(), getIt()))
      ..registerFactory(() => HomeView(getIt()));
  }
}
