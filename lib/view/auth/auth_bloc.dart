// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:local_auth/local_auth.dart';
import 'package:rxdart/rxdart.dart';

import 'package:secure_note/code/navigator_app.dart';
import 'package:secure_note/core/router/routes.dart';
import 'package:secure_note/helpers/global_error.dart';

class AuthModelBloc {
  bool isLoading;

  AuthModelBloc({
    this.isLoading = true,
  });
}

abstract class IAuthBloc {
  Stream<AuthModelBloc> get onFetchingData;
  Future<void> loadAuthenticate();
  void navigateToPop();
  void dispose();
}

class AuthBloc extends ChangeNotifier implements IAuthBloc {
  final _fetchingDataController = BehaviorSubject<AuthModelBloc>();
  final INavigatorApp _navigatorApp;
  final IGlobalError _globalError;
  AuthBloc(
    this._navigatorApp,
    this._globalError,
  );

  @override
  void dispose() {
    super.dispose();
    _fetchingDataController.close();
  }

  @override
  Future<void> loadAuthenticate() async {
    bool authenticated = false;
    try {
      _fetchingDataController.add(AuthModelBloc(isLoading: true));
      final LocalAuthentication auth = LocalAuthentication();
      if (!await auth.isDeviceSupported()) {
        _navigatorApp.pushNamed(AppRoutes.home);
        return;
        // throw Exception(
        //     "É necessário que o dispositivo possua uma autenticação, por favor verifique a compatibilidade do aplicativo com seu dispositivo.");
      }

      authenticated = await auth.authenticate(
        localizedReason:
            'Deixe o sistema operacional determinar o método de autenticação',
        // authMessages: ,
        // authMessages: ,
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );

      if (authenticated) {
        // await Future.delayed(const Duration(seconds: 2));

        _navigatorApp.pushNamed(AppRoutes.home);
        _fetchingDataController.add(AuthModelBloc(isLoading: false));
      } else {
        _fetchingDataController.add(AuthModelBloc(isLoading: false));
        // loadAuthenticate();
      }
    }
    // on Exception catch (e) {
    //   _fetchingDataController.addError(
    //     "É necessário que o dispositivo possua uma autenticação, por favor verifique a compatibilidade do aplicativo com seu dispositivo. $e",
    //   );
    // }
    catch (e) {
      final globalError = await _globalError.errorHandling(
          "Erro ao carregar metodo de autendicação", e, StackTrace.current);
      _fetchingDataController.addError(globalError);
    }
  }

  @override
  void navigateToPop() {
    _fetchingDataController.add(AuthModelBloc(isLoading: false));
    _navigatorApp.pop();
  }

  @override
  Stream<AuthModelBloc> get onFetchingData => _fetchingDataController.stream;
}
