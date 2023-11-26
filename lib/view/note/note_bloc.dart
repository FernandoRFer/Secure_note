// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:rxdart/rxdart.dart';

import 'package:secure_note/repositories/local_data_source/Model/note_model.dart';
import 'package:secure_note/repositories/local_data_source/Model/user_model.dart';
import 'package:secure_note/repositories/local_data_source/bd/db_note.dart';
import 'package:secure_note/routes.dart';

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
  NoteBloc(
    this._dbNotes,
  );
  final _fetchingDataController = BehaviorSubject<NoteModelBloc>();

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
    Modular.to.pop();
    _fetchingDataController.add(NoteModelBloc(isLoading: false));
  }

  @override
  void navigatoHome() {
    Modular.to.popUntil(ModalRoute.withName(AppRoutes.home));
  }

  @override
  Stream<NoteModelBloc> get onFetchingData => _fetchingDataController.stream;

  @override
  void dispose() {
    log("dispose stream");
    _fetchingDataController.close();
    super.dispose();
  }
}
