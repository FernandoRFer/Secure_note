// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:secure_note/helpers/bottom_sheet_helper.dart';
import 'package:secure_note/repositories/local_data_source/Model/user_model.dart';

import 'package:secure_note/view/register/register_bloc.dart';

import '../../components/appButton.dart';
import '../../components/form.dart';

class RegisterView extends StatefulWidget {
  final IRegisterlBloc bloc;
  const RegisterView(
    this.bloc, {
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  // final bloc = RegisterlBloc();

  final _formKey = GlobalKey<FormState>();
  //final _userFocus = FocusNode();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // final _passwordFocus = FocusNode();
  var maskFormatter = MaskTextInputFormatter(mask: '');
  var iconUser = Icons.phone;
  IconData iconPassword = Icons.lock;
  bool senhaVisivel = false;

  @override
  void initState() {
    super.initState();
    log("Log registro");
  }

  @override
  void dispose() {
    super.dispose();
    log("Dispose view");
  }

  String typeButton = "Autenticar-se com email";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Cadastro"),
          centerTitle: true,
        ),
        body: Center(
            child: SingleChildScrollView(
          child: StreamBuilder<RegisterModelBloc>(
              stream: widget.bloc.onFetchingData,
              initialData: RegisterModelBloc(isLoading: false),
              builder: (context, snapshot) {
                if (!snapshot.hasError) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: _formKey,
                        child: Column(children: [
                          AppForm(
                              labelText: "Nome",
                              controller: _nameController,
                              icon: Icons.account_circle,
                              validador: nameValidator),
                          const SizedBox(height: 20),
                          AppForm(
                              controller: _emailController,
                              labelText: "E-Mail",
                              icon: Icons.email,
                              validador: regExpEmail),
                          const SizedBox(height: 20),
                          AppForm(
                            controller: _celularController,
                            inputFormatters: [maskFormatter],
                            keyboardType: const TextInputType.numberWithOptions(
                              signed: false,
                              decimal: false,
                            ),
                            onChanged: maskCell,
                            validador: regExpCelular,
                            labelText: "Telefone",
                            icon: Icons.phone,
                          ),
                          const SizedBox(height: 20),
                          AppForm(
                            controller: _passwordController,
                            labelText: "Senha",
                            validador: passwordValidator,
                            isPassword: true,
                          ),
                          const SizedBox(height: 20),
                          AppForm(
                            controller: _passwordConfirmationController,
                            validador: passwordConfirmation,
                            labelText: "Confirmar senha",
                            isPassword: true,
                          ),
                          const SizedBox(height: 20),
                          AppOutlinedButton(
                            "Confirmar",
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (await widget.bloc.saveRegister(UserModel(
                                    name: _userController.text,
                                    password: _passwordController.text,
                                    phoneNumber: _celularController.text,
                                    eMail: _emailController.text))) {
                                  widget.bloc.navigatoHome();
                                }
                              }
                            },
                          )
                        ]),
                      ),
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
        )));
  }

  String? maskCell(value) {
    final v = value!
        .replaceAll("(", "")
        .replaceAll(")", "")
        .replaceAll(" ", "")
        .replaceAll("-", "");
    if (v.isNotEmpty) {
      _celularController.value =
          maskFormatter.updateMask(mask: "(##) #####-####");
    }
    return null;
  }

  String? regExpEmail(value) {
    if (value?.isEmpty ?? true) {
      return "Favor digite o e-mail";
    } else {
      if (!RegExp(
              r"^[a-zA-Z0-9]{1}[a-zA-Z0-9.a-zA-Z0-9.\.\-_]+@[a-zA-Z0-9.\.\-_]+\.[a-zA-Z0-9.\.\-_]+$")
          .hasMatch(value!)) {
        return "Email inválido";
      }
      return null;
    }
  }

  String? regExpCelular(value) {
    if (value?.isEmpty ?? true) {
      return "Favor digite o celular";
    } else {
      if (RegExp(
              r"^\((?:[14689][1-9]|2[12478]|3[1234578]|5[1345]|7[134579])\) (9[1-9])[0-9]{3}\-[0-9]{4}$")
          .hasMatch(value!)) {
        return null;
      } else {
        return "Celular inválido";
      }
    }
  }

  String? passwordValidator(value) {
    if (value?.isEmpty ?? true) {
      return "Favor digite a senha";
    } else {
      return null;
    }
  }

  String? nameValidator(value) {
    if (value?.isEmpty ?? true) {
      return "Favor digite do nome do usuario";
    } else {
      return null;
    }
  }

  String? passwordConfirmation(value) {
    if (value?.isEmpty ?? true) {
      return "Favor digite a confirmação de senha";
    } else if (value == _passwordController.text) {
      return null;
    } else {
      return "Confirmação invalida";
    }
  }
}
