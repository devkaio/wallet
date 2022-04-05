class Failure {
  final int status;
  final String message;
  final dynamic exception;
  final String type;
  Failure({
    required this.status,
    required this.message,
    required this.type,
    required this.exception,
  });
}
