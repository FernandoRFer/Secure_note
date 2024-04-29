import 'package:flutter/material.dart';
import 'package:secure_note/helpers/bottom_sheet_helper.dart';

import 'package:secure_note/view/auth/auth_bloc.dart';
import 'package:secure_note/components/appButton.dart';

class AuthView extends StatefulWidget {
  final IAuthBloc bloc;
  const AuthView(
    this.bloc, {
    Key? key,
  }) : super(key: key);

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  // final LocalAuthentication auth = LocalAuthentication();
  // final _SupportState _supportState = _SupportState.unknown;
  // bool? _canCheckBiometrics;
  // List<BiometricType>? _availableBiometrics;
  // final String _authorized = 'Not Authorized';
  // final bool _isAuthenticating = false;

  // @override
  // void initState() {
  //   super.initState();
  //   auth.isDeviceSupported().then(
  //         (bool isSupported) => setState(() => _supportState = isSupported
  //             ? _SupportState.supported
  //             : _SupportState.unsupported),
  //       );
  // }

  @override
  void initState() {
    super.initState();
    //Future.delayed(Duration.zero, widget.bloc.loadAuthenticate);
  }

  @override
  void dispose() {
    super.dispose();
    widget.bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(""),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
              child: SingleChildScrollView(
            child: StreamBuilder<AuthModelBloc>(
                stream: widget.bloc.onFetchingData,
                initialData: AuthModelBloc(isLoading: false),
                builder: (context, snapshot) {
                  if (!snapshot.hasError) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isLoading) {
                        return const CircularProgressIndicator();

                        // return ValueListenableBuilder(
                        //     valueListenable: isAuth,
                        //     builder: (context, value, child) {
                        //       return AnimatedSwitcher(
                        //         duration: const Duration(milliseconds: 400),
                        //         child: snapshot.data?.isLoading ?? true
                        //             ? const CircularProgressIndicator(
                        //                 key: ValueKey('Loading a'),
                        //               )
                        //             : const Icon(
                        //                 Icons.lock_open_outlined,
                        //                 size: 100,
                        //                 key: ValueKey('Icon b'),
                        //               ),

                        //         transitionBuilder: (Widget child,
                        //             Animation<double> animation) {
                        //           return ScaleTransition(
                        //             scale: animation,
                        //             child: child,
                        //           );
                        //         },
                        // const Icon(
                        //     Icons.lock_open,
                        //     size: 100,
                        //     key: ValueKey('Icon b'),
                        //   ),
                        //   )
                        // })
                      }
                      return AppOutlinedButton(
                        "Entrar",
                        onPressed: () async {
                          await widget.bloc.loadAuthenticate();
                        },
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
                                widget.bloc.navigateToPop();
                              },
                            ),
                          ]);
                    });
                  }

                  return Container();
                }),
          )),
        ));
  }
}

//   Future<void> _checkBiometrics() async {
//     late bool canCheckBiometrics;
//     try {
//       canCheckBiometrics = await auth.canCheckBiometrics;
//     } on PlatformException catch (e) {
//       canCheckBiometrics = false;
//       print(e);
//     }
//     if (!mounted) {
//       return;
//     }

//     setState(() {
//       _canCheckBiometrics = canCheckBiometrics;
//     });
//   }

//   Future<void> _getAvailableBiometrics() async {
//     late List<BiometricType> availableBiometrics;
//     try {
//       availableBiometrics = await auth.getAvailableBiometrics();
//     } on PlatformException catch (e) {
//       availableBiometrics = <BiometricType>[];
//       print(e);
//     }
//     if (!mounted) {
//       return;
//     }

//     setState(() {
//       _availableBiometrics = availableBiometrics;
//     });
//   }

//   Future<void> _authenticate() async {
//     bool authenticated = false;
//     try {
//       setState(() {
//         _isAuthenticating = true;
//         _authorized = 'Authenticating';
//       });
//       authenticated = await auth.authenticate(
//         localizedReason: 'Let OS determine authentication method',
//         options: const AuthenticationOptions(
//           stickyAuth: true,
//         ),
//       );
//       if (authenticated) {
//         Modular.to.pushNamed(AppRoutes.home);
//       }

//       setState(() {
//         _isAuthenticating = false;
//       });
//     } on PlatformException catch (e) {
//       print(e);
//       setState(() {
//         _isAuthenticating = false;
//         _authorized = 'Error - ${e.message}';
//       });
//       return;
//     }
//     if (!mounted) {
//       return;
//     }

//     setState(
//         () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
//   }

//   Future<void> _authenticateWithBiometrics() async {
//     bool authenticated = false;
//     try {
//       setState(() {
//         _isAuthenticating = true;
//         _authorized = 'Authenticating';
//       });
//       authenticated = await auth.authenticate(
//         localizedReason:
//             'Scan your fingerprint (or face or whatever) to authenticate',
//         options: const AuthenticationOptions(
//           stickyAuth: true,
//           biometricOnly: true,
//         ),
//       );

//       setState(() {
//         _isAuthenticating = false;
//         _authorized = 'Authenticating';
//       });
//     } on PlatformException catch (e) {
//       print(e);
//       setState(() {
//         _isAuthenticating = false;
//         _authorized = 'Error - ${e.message}';
//       });
//       return;
//     }
//     if (!mounted) {
//       return;
//     }

//     final String message = authenticated ? 'Authorized' : 'Not Authorized';
//     setState(() {
//       _authorized = message;
//     });
//   }

//   Future<void> _cancelAuthentication() async {
//     await auth.stopAuthentication();
//     setState(() => _isAuthenticating = false);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Plugin example app'),
//       ),
//       body: ListView(
//         padding: const EdgeInsets.only(top: 30),
//         children: <Widget>[
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 AppTextButton(
//                   'Iniciar',
//                   onPressed: _authenticate,
//                 ),
//                 // if (_supportState == _SupportState.unknown)
//                 //   const CircularProgressIndicator()
//                 // else if (_supportState == _SupportState.supported)
//                 //   const Text('This device is supported')
//                 // else
//                 //   const Text('This device is not supported'),
//                 // const Divider(height: 100),
//                 // Text('Can check biometrics: $_canCheckBiometrics\n'),
//                 // ElevatedButton(
//                 //   onPressed: _checkBiometrics,
//                 //   child: const Text('Check biometrics'),
//                 // ),
//                 // const Divider(height: 100),
//                 // Text('Available biometrics: $_availableBiometrics\n'),
//                 // ElevatedButton(
//                 //   onPressed: _getAvailableBiometrics,
//                 //   child: const Text('Get available biometrics'),
//                 // ),
//                 // const Divider(height: 100),

//                 // if (_isAuthenticating)
//                 //   ElevatedButton(
//                 //     onPressed: _cancelAuthentication,
//                 //     // TODO(goderbauer): Make this const when this package requires Flutter 3.8 or later.
//                 //     // ignore: prefer_const_constructors
//                 //     child: Row(
//                 //       mainAxisSize: MainAxisSize.min,
//                 //       children: const <Widget>[
//                 //         Text('Cancel Authentication'),
//                 //         Icon(Icons.cancel),
//                 //       ],
//                 //     ),
//                 //   )
//                 // else
//                 //   Column(
//                 //     children: <Widget>[
//                 //       ElevatedButton(
//                 //         onPressed: _authenticate,
//                 //         // TODO(goderbauer): Make this const when this package requires Flutter 3.8 or later.
//                 //         // ignore: prefer_const_constructors
//                 //         child: Row(
//                 //           mainAxisSize: MainAxisSize.min,
//                 //           children: const <Widget>[
//                 //             Text('Authenticate'),
//                 //             Icon(Icons.perm_device_information),
//                 //           ],
//                 //         ),
//                 //       ),
//                 //       ElevatedButton(
//                 //         onPressed: _authenticateWithBiometrics,
//                 //         child: Row(
//                 //           mainAxisSize: MainAxisSize.min,
//                 //           children: <Widget>[
//                 //             Text(_isAuthenticating
//                 //                 ? 'Cancel'
//                 //                 : 'Authenticate: biometrics only'),
//                 //             const Icon(Icons.fingerprint),
//                 //           ],
//                 //         ),
//                 //       ),
//                 //     ],
//                 //   ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// enum _SupportState {
//   unknown,
//   supported,
//   unsupported,
// }
