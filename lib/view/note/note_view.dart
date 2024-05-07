import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:secure_note/helpers/bottom_sheet_helper.dart';
import 'package:secure_note/repositories/local_data_source/Model/note_model.dart';
import 'package:secure_note/view/note/note_bloc.dart';
import 'package:secure_note/widget/success.dart';

import '../../widget/appButton.dart';
import '../../widget/form.dart';

import 'package:shared_preferences/shared_preferences.dart';

class NoteView extends StatefulWidget {
  final INoteBloc bloc;
  const NoteView(
    this.bloc, {
    Key? key,
  }) : super(key: key);

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    log("Dispose view");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notas"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: StreamBuilder<NoteModelBloc>(
              stream: widget.bloc.onFetchingData,
              initialData: NoteModelBloc(isLoading: false),
              builder: (context, snapshot) {
                if (!snapshot.hasError) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.data!.success) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Successs().appShowDialog(
                          title: "Salvo com sucesso",
                          subtitle: snapshot.error.toString(),
                          isDismissible: true,
                          enableDrag: false,
                          context: context,
                          button: () {
                            widget.bloc.navigatoPop();
                          },
                        );
                      });
                    }

                    return Form(
                      key: _formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            AppFormText(
                                labelText: "Titulo",
                                maxLines: 1,
                                controller: _nameController,
                                validador: textValidator),
                            const SizedBox(height: 16),
                            AppFormText(
                                labelText: "Nota",
                                controller: _noteController,
                                validador: textValidator),
                            const SizedBox(height: 16),
                          ]),
                    );
                  }
                } else {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    BottomSheetHelper().bottomSheetError(
                        title: "Error",
                        subtitle: snapshot.error.toString(),
                        isDismissible: true,
                        enableDrag: false,
                        context: context,
                        buttons: [
                          AppOutlinedButton(
                            "Back",
                            onPressed: () {
                              widget.bloc.navigatoPop();
                            },
                          ),
                        ]);
                  });
                }
                return Container();
              }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            await widget.bloc.saveRegister(NoteModel(
                note: _noteController.text, title: _nameController.text));
            _nameController.clear();
            _noteController.clear();
          }
        },
        child: const Icon(Icons.save_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  String? textValidator(value) {
    if (value?.isEmpty ?? true) {
      return "Esse campo deve ser preenchido";
    } else {
      return null;
    }
  }

  // void shared(String value) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString('note', value);
  //   final String? note = prefs.getString('note');
  //   log(note ?? '');
  // }

  // Future<String> sharedGet() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();

  //   final String? note = prefs.getString('note');
  //   log(note ?? '');
  //   return note ?? '';
  // }
}
