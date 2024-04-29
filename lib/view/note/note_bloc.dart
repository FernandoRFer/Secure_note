import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:secure_note/code/navigator_app.dart';
import 'package:secure_note/repositories/local_data_source/Model/note_model.dart';
import 'package:secure_note/repositories/local_data_source/bd/db_note.dart';
import 'package:secure_note/core/router/routes.dart';

class NoteModelBloc {
  bool isLoading;
  bool success;

  NoteModelBloc({
    this.isLoading = true,
    this.success = false,
  });
}

abstract class INoteBloc {
  Stream<NoteModelBloc> get onFetchingData;
  Future<bool> saveRegister(NoteModel noteModel);
  void navigatoHome();
  void navigatoPop();
  void dispose();
}

class NoteBloc extends ChangeNotifier implements INoteBloc {
  final IDbNotes _dbNotes;
  final INavigatorApp _navigatorApp;

  NoteBloc(
    this._dbNotes,
    this._navigatorApp,
  );

  final _fetchingDataController = BehaviorSubject<NoteModelBloc>();

  @override
  void dispose() {
    _fetchingDataController.close();
    super.dispose();
  }

  @override
  Future<bool> saveRegister(NoteModel noteModel) async {
    try {
      _fetchingDataController.add(NoteModelBloc(isLoading: true));

      var save = await _dbNotes.insert(noteModel);
      log(save.toString());

      _fetchingDataController
          .add(NoteModelBloc(isLoading: false, success: true));

      return true;
    } catch (e) {
      _fetchingDataController.addError(
        "Um erro  ocorreu ao conectar, tente novamente - $e",
      );
    }
    return false;
  }

  @override
  void navigatoPop() {
    _navigatorApp.pop();
    _fetchingDataController.add(NoteModelBloc(isLoading: false));
  }

  @override
  void navigatoHome() {
    _navigatorApp.popUntil(AppRoutes.home);
  }

  @override
  Stream<NoteModelBloc> get onFetchingData => _fetchingDataController.stream;
}
