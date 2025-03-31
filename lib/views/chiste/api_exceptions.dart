class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}

class NoInternetException extends ApiException {
  NoInternetException() : super('No hay conexión a Internet. Verifica tu red.');
}

class ServerException extends ApiException {
  ServerException(int statusCode)
      : super('Error del servidor. Código de estado: $statusCode');
}

class UnexpectedException extends ApiException {
  UnexpectedException() : super('Ocurrió un error inesperado. Intenta más tarde.');
}
