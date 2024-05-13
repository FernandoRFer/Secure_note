import 'package:get_it/get_it.dart';
import 'package:secure_note/view/note/note_bloc.dart';
import 'package:secure_note/view/note/note_view.dart';

class NoteModule {
  static GetIt getIt = GetIt.instance;
  void configure() {
    getIt
      ..registerFactory<INoteBloc>(() => NoteBloc(getIt(), getIt(), getIt()))
      ..registerFactory(() => NoteView(getIt()));
  }
}
