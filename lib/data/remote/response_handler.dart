import 'server_error.dart';

class ResponseHandler<T> {
  ServerError? _error;
  T? data;

  setException(ServerError error) {
    _error = error;
  }

  setData(T data) {
    this.data = data;
  }

  ServerError? getException() => _error;
}
