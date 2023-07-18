abstract class AddressException implements Exception {
  final String message;
  final StackTrace? stackTrace;
  AddressException({
    required this.message,
    this.stackTrace,
  });
}
