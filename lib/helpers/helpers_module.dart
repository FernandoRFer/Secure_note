import 'package:get_it/get_it.dart';
import 'package:secure_note/helpers/global_error.dart';

class HelpersModule {
  static GetIt getIt = GetIt.instance;
  void configutarion() {
    getIt.registerLazySingleton<IGlobalError>(() => GlobalError());
  }
}
