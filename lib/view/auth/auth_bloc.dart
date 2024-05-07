import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:local_auth/local_auth.dart';
import 'package:rxdart/rxdart.dart';

import 'package:secure_note/routes.dart';

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

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   log("Dipose auth");
  //   super.dispose();
  //   _fetchingDataController.close();
  // }

  @override
  Future<void> loadAuthenticate() async {
    bool authenticated = false;
    try {
      _fetchingDataController.add(AuthModelBloc(isLoading: true));
      final LocalAuthentication auth = LocalAuthentication();
      if (!await auth.isDeviceSupported()) {
        return Modular.to.navigate(AppRoutes.home);
        // throw Exception(
        //     "É necessário que o dispositivo possua uma autenticação, por favor verifique a compatibilidade do aplicativo com seu dispositivo.");
      }

      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        // authMessages: ,
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );

      if (authenticated) {
        // await Future.delayed(const Duration(seconds: 2));

        Modular.to.navigate(AppRoutes.home);
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
      _fetchingDataController.addError(e.toString());
    }
  }

  @override
  void navigateToPop() {
    _fetchingDataController.add(AuthModelBloc(isLoading: false));
    Modular.to.pop();
  }

  @override
  Stream<AuthModelBloc> get onFetchingData => _fetchingDataController.stream;
}
