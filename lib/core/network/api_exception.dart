/// Thrown by [ApiClient] whenever a request fails, either because the
/// server responded with a non-2xx status code or because of a
/// network/parsing problem.
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  const ApiException(this.message, {this.statusCode});

  /// True when the server responded 401, i.e. the stored token is missing,
  /// expired or invalid and the user should be sent back to the login
  /// screen.
  bool get isUnauthorized => statusCode == 401;

  @override
  String toString() => message;
}
