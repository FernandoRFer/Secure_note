// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:secure_note/view/home/home_bloc.dart';
import 'package:secure_note/widget/appButton.dart';

class HomeView extends StatefulWidget {
  final IHomeBloc bloc;
  const HomeView(
    this.bloc, {
    Key? key,
  }) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SizedBox(
        width: 100,
        child: AppOutlinedButton(
          "teste",
          onPressed: () {
            widget.bloc.navigatorRegister();
          },
        ),
      ),
    ));
  }
}
