class MyBookStoreException implements Exception {
  final String message;
  MyBookStoreException(this.message);

  @override
  String toString() {
    return 'MyBookStoreException: $message';
  }
}

class AuthUnauthorizedException extends MyBookStoreException {
  AuthUnauthorizedException() : super('Unauthorized access');
}

class ConnectionTimeoutException extends MyBookStoreException {
  ConnectionTimeoutException() : super('Connection timeout');
}
