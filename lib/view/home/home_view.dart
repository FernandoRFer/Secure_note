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
  bool _value = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, widget.bloc.load);
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
              icon: const Icon(Icons.settings_applications_sharp),
              onPressed: () {},
            ),
          ]),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppOutlinedButton(
                  "Cadastro",
                  onPressed: () {
                    widget.bloc.navigatorRegister();
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                Switch(
                    value: _value,
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                        if (_value) {
                          AppWidget.of(context)!.changeTheme(Brightness.dark);
                        } else {
                          AppWidget.of(context)!.changeTheme(Brightness.light);
                        }
                      });
                    }),
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
                            return GestureDetector(
                              child: ListView.separated(
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
                                  return Card(
                                      margin: const EdgeInsets.all(0.0),
                                      child: ListTile(
                                          title: Text(nota.title),
                                          subtitle: Text(nota.note)));
                                },
                              ),
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

                      return const Text('sem dados');
                    }),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.bloc.navigatorNote();
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
