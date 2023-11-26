// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

abstract class IGlobalError {
  Future<GlobalErrorModel> errorHandling(
    dynamic message, [
    Object? error,
    StackTrace? stackTrace,
  ]);
}

class GlobalError implements IGlobalError {
  // final IAppLog _appLog;

  // GlobalError(this._appLog);

  @override
  Future<GlobalErrorModel> errorHandling(
    dynamic message, [
    Object? error,
    StackTrace? stackTrace,
  ]) async {
    // _appLog.severe(message, [
    //   error,
    //   stackTrace,
    // ]);

    switch (error.runtimeType) {
      case SocketException:
        error as SocketException;
        error.message;
        return GlobalErrorModel(
          GlobalErrorTypes.connection,
          "Verifique a conexão e tente novamente",
        );
      case PlatformException:
        error as PlatformException;
        return GlobalErrorModel(
          GlobalErrorTypes.hardware,
          platformExceptionReplace(error.toString()),
        );
      case TimeoutException:
        error as TimeoutException;
        return GlobalErrorModel(
          GlobalErrorTypes.timeout,
          "Tempo limite da requisição esgotado",
        );
      default:
        return GlobalErrorModel(
          GlobalErrorTypes.exception,
          error.toString().replaceAll("Exception:", ""),
        );
    }
  }

  String platformExceptionReplace(String error) {
    if (error.contains("Impressora sem papel")) {
      return "Impressora sem papel";
    } else if (error.contains("GediException(POWER_NO_BATTERY)")) {
      return "Bateria fraca";
    } else {
      return "Erro desconhecido";
    }
  }
}

class GlobalErrorModel {
  Enum type;
  String message;
  GlobalErrorModel(
    this.type,
    this.message,
  );
}

enum GlobalErrorTypes {
  request,
  timeout,
  hardware,
  connection,
  exception,
}

/*
Exemplo de aplicação
final IGlobalError _globalError;

catch (e) {
  final globalError = await _globalError.globalError(
          descrição da função,
          e,
          StackTrace.current);
      _stateController.addError(globalError);
    }    
 
*/
