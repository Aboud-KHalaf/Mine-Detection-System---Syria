class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, [this.statusCode]);

  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';
}

class OfflineException implements Exception {
  final String message;

  OfflineException(this.message);

  @override
  String toString() => 'OfflineException: $message';
}
