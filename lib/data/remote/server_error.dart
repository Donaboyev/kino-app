import 'package:dio/dio.dart';

class ServerError implements Exception {
  int _errorCode;
  String _errorMessage = '';

  ServerError.withError({DioError error}) {
    _handleError(error);
  }

  _handleError(DioError error) {
    _errorCode = error.response?.statusCode ?? 500;
    switch (error.type) {
      case DioErrorType.connectTimeout:
        _errorMessage = "Connection timeout";
        break;
      case DioErrorType.sendTimeout:
        _errorMessage = "Connection timeout";
        break;
      case DioErrorType.receiveTimeout:
        _errorMessage = "Connection timeout";
        break;
      case DioErrorType.response:
        {
          // if (error.message.contains('500')) {
          //   _errorMessage = "Server not working";
          //   break;
          // }
          if (error.response?.data['Error'] is Map<String, dynamic>) {
            _errorMessage = error.response.data['Error']['Message'].toString();
          } else {
            _errorMessage = error.response.data['Message'].toString();
          }
          break;
        }
      case DioErrorType.cancel:
        _errorMessage = "Canceled";
        break;
      case DioErrorType.other:
        _errorMessage = "Something wrong";
        break;
    }
    return _errorMessage;
  }

  int getErrorCode() => _errorCode;

  String getErrorMessage() => _errorMessage;
}
