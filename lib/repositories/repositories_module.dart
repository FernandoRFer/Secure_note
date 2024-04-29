import 'package:get_it/get_it.dart';
import 'package:secure_note/repositories/local_data_source/bd/db_note.dart';

class RepositoriesModude {
  static GetIt getIt = GetIt.instance;
  void configutarion() {
    getIt.registerLazySingleton<IDbNotes>(() => DbNotes());
  }
}
