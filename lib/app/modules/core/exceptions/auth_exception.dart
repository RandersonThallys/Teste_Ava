abstract class AuthException implements Exception {
  final String message;
  final StackTrace? stackTrace;
  AuthException({
    required this.message,
    this.stackTrace,
  });
}

class PasswordInvalidException extends AuthException {
  PasswordInvalidException({required super.message, super.stackTrace});
}

class AccountNotExistException extends AuthException {
  AccountNotExistException({required super.message, super.stackTrace});
}
