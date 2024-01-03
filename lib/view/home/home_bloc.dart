import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';
import 'package:secure_note/helpers/global_error.dart';
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

  Future<void> removeNote(int id);
}

class HomeBloc extends ChangeNotifier implements IHomeBloc {
  final IDbNotes _dbNotes;
  final IGlobalError _globalError;

  final _fetchingDataController = BehaviorSubject<HomeModel>();
  HomeBloc(this._dbNotes, this._globalError);

  List<NoteModel> _listNote = [];

  @override
  Stream<HomeModel> get onFetchingData => _fetchingDataController;

  @override
  Future<void> load() async {
    try {
      _fetchingDataController.add(HomeModel(isloading: true));

      _listNote = await _dbNotes.get(null);

      _fetchingDataController.add(HomeModel(
        list: _listNote.reversed.toList(),
        isloading: false,
      ));
    } catch (exception, stackTrace) {
      final error = await _globalError.errorHandling(
          "Um erro  ocorreu ao conectar, tente novamente",
          exception,
          stackTrace);
      _fetchingDataController.addError(
        error.message,
      );
    }
  }

  @override
  Future<void> removeNote(int id) async {
    try {
      // _fetchingDataController.add(HomeModel(isloading: true));
      var result = await _dbNotes.remove(id);
      log("result $result");

      load();
    } catch (exception, stackTrace) {
      final error = await _globalError.errorHandling(
          "Um erro  ocorreu ao conectar, tente novamente",
          exception,
          stackTrace);
      _fetchingDataController.addError(
        error.message,
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
