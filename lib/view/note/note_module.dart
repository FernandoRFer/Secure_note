import 'package:flutter_modular/flutter_modular.dart';
import 'package:secure_note/view/note/note_bloc.dart';
import 'package:secure_note/view/note/note_view.dart';

class NoteModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.singleton<INoteBloc>((i) => NoteBloc(i()),
            onDispose: (bloc) => bloc.dispose()),
        Bind.singleton(
          (i) => NoteView(i()),
        ),
      ];
  @override
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute,
            child: (_, args) => Modular.get<NoteView>()),
      ];
}
