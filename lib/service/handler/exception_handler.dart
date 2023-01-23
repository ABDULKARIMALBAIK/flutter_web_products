import 'package:dio/dio.dart';

class ExceptionHandler {
  String get exceptionCancel => 'Request Cancelled';
  String get exceptionConnectionTime => 'No Connection Time';
  String get exceptionReceiveTimeout => 'The Receive Timeout';
  String get exceptionSendTimeout => 'The Send Timeout';
  String get exceptionOther => 'Unknown Error';

  String get notDioError => 'Error is not Dio Error';
  String get notHandledError => 'Error is not Dio Error';
  String get errorNotException => 'Error is not Exception';
  String get unKnownError => 'Unknown Error';

  String get unKnownCode => '101';
  String get notDioCode => '102';
  String get notHandledCode => '103';
  String get errorNotExceptionCode => '104';

  ErrorModel handle(
    dynamic error, {
    String message400 = '',
    String message401 = '',
    String message402 = '',
    String message403 = '',
    String message404 = '',
    String message405 = '',
    String message406 = '',
    String message407 = '',
    String message408 = '',
    String message409 = '',
    String message500 = '',
    String message501 = '',
    String message502 = '',
    String message503 = '',
    String message504 = '',
    String message505 = '',
  }) {
    if (error is Exception) {
      try {
        if (error is DioError) {
          if (error.type == DioErrorType.cancel) {
            return ErrorModel(DioErrorType.cancel.toString(), exceptionCancel);
          } else if (error.type == DioErrorType.connectTimeout) {
            return ErrorModel(DioErrorType.connectTimeout.toString(),
                exceptionConnectionTime);
          } else if (error.type == DioErrorType.receiveTimeout) {
            return ErrorModel(DioErrorType.receiveTimeout.toString(),
                exceptionReceiveTimeout);
          } else if (error.type == DioErrorType.sendTimeout) {
            return ErrorModel(
                DioErrorType.sendTimeout.toString(), exceptionSendTimeout);
          }
          // else if (error.type == DioErrorType.other) {
          //   return ErrorModel(DioErrorType.other.toString() , exceptionOther);
          // }
          else if (error.type == DioErrorType.response) {
            switch (error.response!.statusCode) {
              case 400:
                return ErrorModel(400.toString(), message400);
              case 401:
                return ErrorModel(401.toString(), message401);
              case 402:
                return ErrorModel(402.toString(), message402);
              case 403:
                return ErrorModel(403.toString(), message403);
              case 404:
                return ErrorModel(404.toString(), message404);
              case 405:
                return ErrorModel(405.toString(), message405);
              case 406:
                return ErrorModel(406.toString(), message406);
              case 407:
                return ErrorModel(407.toString(), message407);
              case 408:
                return ErrorModel(408.toString(), message408);
              case 409:
                return ErrorModel(409.toString(), message409);
              case 500:
                return ErrorModel(500.toString(), message500);
              case 501:
                return ErrorModel(501.toString(), message501);
              case 502:
                return ErrorModel(502.toString(), message502);
              case 503:
                return ErrorModel(503.toString(), message503);
              case 504:
                return ErrorModel(504.toString(), message504);
              case 505:
                return ErrorModel(505.toString(), message505);
              default:
                return ErrorModel(unKnownCode, unKnownError);
            }
          } else {
            return ErrorModel(unKnownCode, unKnownError);
          }
        }
        //Error isn't DioError
        else {
          return ErrorModel(notDioCode, notDioError);
        }
      } catch (_) {
        return ErrorModel(notHandledCode, notHandledError);
      }
    }
    //Error isn't Exception
    else {
      return ErrorModel(errorNotExceptionCode, errorNotException);
    }
  }
}

class ErrorModel {
  String code;
  String message;

  ErrorModel(this.code, this.message);
}
