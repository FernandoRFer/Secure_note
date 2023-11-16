import 'dart:developer';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import 'package:secure_note/repositories/local_data_source/Model/note_model.dart';
import 'package:secure_note/repositories/local_data_source/bd/db_note.dart';
import 'package:secure_note/routes.dart';

class HomeModel {
  List<NoteModel>? list;
  bool isloading;
  HomeModel({this.list, this.isloading = false});
}

abstract class IHomeBloc {
  Stream<HomeModel> get onFetchingData;
  void navigatorRegister();
  void navigatorNote();
  void dispose();
  Future<void> load();
}

class HomeBloc extends BlocBase implements IHomeBloc {
  final IDbNotes _dbNotes;

  final _fetchingDataController = BehaviorSubject<HomeModel>();
  HomeBloc(this._dbNotes);

  List<NoteModel> _listNote = [];

  @override
  Stream<HomeModel> get onFetchingData => _fetchingDataController;

  @override
  Future<void> load() async {
    try {
      _fetchingDataController.add(HomeModel(isloading: true));

      _listNote = await _dbNotes.getProduct(null);

      _fetchingDataController.add(HomeModel(
        list: _listNote.reversed.toList(),
        isloading: false,
      ));
    } catch (e) {
      _fetchingDataController.addError(
        "Um erro  ocorreu ao conectar, tente novamente - $e",
      );
    }
  }

  @override
  void navigatorRegister() {
    Modular.to.pushNamed(AppRoutes.register).then((value) => load());
  }

  @override
  void navigatorNote() {
    Modular.to.pushNamed(AppRoutes.note).then((value) => load());
  }

  @override
  void dispose() {
    log("Dipose home");
    // TODO: implement dispose
    super.dispose();
  }
}
