import 'dart:developer';
import 'package:equatable/equatable.dart';


abstract class Failure extends Equatable {
  @override
  List<Object> get props => [];
}

class CacheFailure extends Failure {
  final dynamic error;
  final String? message;
  CacheFailure({this.error, this.message});

  CacheFailure get get {
    String message;
    log('DatabaseException', name: 'type');
    if (error.isDatabaseClosedError()){
      message = "databaseClosedError";
      log('databaseClosedError', name: 'error');
    } else if (error.isOpenFailedError()){
      message = "openFailedError";
      log('openFailedError', name: 'error');
    } else if (error.isReadOnlyError()){
      message = "readOnlyError";
      log('readOnlyError', name: 'error');
    } else if (error.isSyntaxError()){
      message = "syntaxError";
      log('syntaxError', name: 'error');
    } else {
      message = "defaultErrorDB";
      log('defaultErrorDB', name: 'error');
    }
    return CacheFailure(
      error: error,
      message: message
    );
  }
}

class ParseFailure extends Failure {
  final String message;
  ParseFailure(this.message);
}

class NullException extends Failure {
  final String message;
  NullException(this.message);

}

