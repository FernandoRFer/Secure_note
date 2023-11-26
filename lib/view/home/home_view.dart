import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:secure_note/helpers/bottom_sheet_helper.dart';
import 'package:secure_note/main.dart';
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
  final bool _value = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, widget.bloc.load);
  }

  bool _invisibleMessage = false;

  bool _brightness = false; // false = dart, true = light

  void _setinvisibleMessage() {
    setState(() {
      _invisibleMessage = !_invisibleMessage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Home'),
          centerTitle: true,
          actions: <Widget>[
            // botoes de acções
            IconButton(
                onPressed: () {
                  setState(() {
                    _brightness = !_brightness;
                    if (_brightness) {
                      AppWidget.of(context)!.changeTheme(Brightness.dark);
                    } else {
                      AppWidget.of(context)!.changeTheme(Brightness.light);
                    }
                  });
                },
                icon: _brightness
                    ? const Icon(Icons.flashlight_off)
                    : const Icon(Icons.flashlight_on)),
            IconButton(
              icon: const Icon(Icons.settings_applications_sharp),
              onPressed: () {},
            ),
          ]),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // AppOutlinedButton(
              //   "Cadastro",
              //   onPressed: () {
              //     widget.bloc.navigatorRegister();
              //   },
              // ),
              // const SizedBox(
              //   height: 8,
              // ),
              // Switch(
              //     value: _value,
              //     onChanged: (value) {
              //       setState(() {
              //         _value = value;
              //         if (_value) {
              //           AppWidget.of(context)!.changeTheme(Brightness.dark);
              //         } else {
              //           AppWidget.of(context)!.changeTheme(Brightness.light);
              //         }
              //       });
              //     }),

              StreamBuilder<HomeModel>(
                  initialData: HomeModel(isloading: true),
                  stream: widget.bloc.onFetchingData,
                  builder: (context, snapshot) {
                    if (!snapshot.hasError) {
                      if (snapshot.hasData) {
                        if (snapshot.data!.isloading) {
                          return const CircularProgressIndicator();
                        }
                        if (snapshot.data!.list!.isNotEmpty) {
                          final list = snapshot.data!.list!;
                          return ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const SizedBox(
                                height: 16,
                              );
                            },
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            // gridDelegate:
                            //     const SliverGridDelegateWithMaxCrossAxisExtent(
                            //   maxCrossAxisExtent: 300.0,
                            //   crossAxisSpacing: 8.0,
                            //   mainAxisSpacing: 8.0,
                            // ),
                            itemCount: list.length,
                            itemBuilder: (context, index) {
                              final nota = list[index];
                              return Dismissible(
                                direction: DismissDirection.endToStart,
                                onDismissed: (details) {
                                  widget.bloc.removeNote(nota.id ?? 0);
                                },
                                key: const Key("NotesHome"),
                                child: Card(
                                    margin: const EdgeInsets.all(0.0),
                                    child: ListTile(
                                        title: Text(nota.title),
                                        subtitle: _invisibleMessage
                                            ? const Text("*****")
                                            : Text(nota.note))),
                              );
                            },
                          );
                        }
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
                                  //   widget.bloc.navigateToPop();
                                },
                              ),
                            ]);
                      });
                    }

                    return Center(
                      child: Container(
                          color: Colors.transparent,
                          child: const Text('Sem Notas')),
                    );
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
            heroTag: UniqueKey(),
            onPressed: () {
              _setinvisibleMessage();
            },
            child: _invisibleMessage
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off)),
        const SizedBox(
          height: 12,
        ),
        FloatingActionButton(
          heroTag: UniqueKey(),
          onPressed: () {
            widget.bloc.navigatorNote();
          },
          child: const Icon(Icons.add),
        ),
        const SizedBox(
          height: 12,
        ),
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
