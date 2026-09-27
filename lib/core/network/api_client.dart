import 'dart:convert';

import 'package:http/http.dart' as http;

import '../storage/session_storage.dart';
import 'api_endpoints.dart';
import 'api_exception.dart';

/// Thin wrapper around [http] that:
/// - prefixes every call with [ApiEndpoints.baseUrl]
/// - attaches the stored Bearer token when [requiresAuth] is true
/// - decodes JSON responses and turns non-2xx responses into
///   [ApiException]s with the server's error message when available.
class ApiClient {
  ApiClient({http.Client? client, SessionStorage? sessionStorage})
      : _client = client ?? http.Client(),
        _sessionStorage = sessionStorage ?? SessionStorage();

  final http.Client _client;
  final SessionStorage _sessionStorage;

  Future<Map<String, dynamic>> post(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
    bool requiresAuth = false,
  }) async {
    final headers = await _buildHeaders(requiresAuth: requiresAuth);
    final response = await _client.post(
      _buildUri(path, queryParams),
      headers: headers,
      body: body == null ? null : jsonEncode(body),
    );
    return _handleResponse(response);
  }

  Future<Map<String, dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParams,
    bool requiresAuth = false,
  }) async {
    final headers = await _buildHeaders(requiresAuth: requiresAuth);
    final response = await _client.get(
      _buildUri(path, queryParams),
      headers: headers,
    );
    return _handleResponse(response);
  }

  /// Most AppOwner endpoints wrap their payload as `{"status": bool,
  /// "message": <payload>}`. This unwraps that envelope and throws when
  /// `status` is false, so feature repositories can work directly with the
  /// inner payload.
  Future<Map<String, dynamic>> getEnvelope(
    String path, {
    Map<String, dynamic>? queryParams,
  }) async {
    final json = await get(path, queryParams: queryParams, requiresAuth: true);
    return _unwrapEnvelope(json);
  }

  Future<Map<String, dynamic>> postEnvelope(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
  }) async {
    final json = await post(
      path,
      body: body,
      queryParams: queryParams,
      requiresAuth: true,
    );
    return _unwrapEnvelope(json);
  }

  Map<String, dynamic> _unwrapEnvelope(Map<String, dynamic> json) {
    if (json['status'] != true) {
      throw ApiException(json['message']?.toString() ?? 'Request failed.');
    }
    final message = json['message'];
    if (message is Map<String, dynamic>) return message;
    return <String, dynamic>{};
  }

  Uri _buildUri(String path, Map<String, dynamic>? queryParams) {
    final uri = Uri.parse('${ApiEndpoints.baseUrl}$path');
    if (queryParams == null || queryParams.isEmpty) return uri;
    final stringParams = queryParams.map((key, value) => MapEntry(key, '$value'));
    return uri.replace(queryParameters: {...uri.queryParameters, ...stringParams});
  }

  Future<Map<String, String>> _buildHeaders({required bool requiresAuth}) async {
    final headers = <String, String>{
      'Accept': '*/*',
      'Content-Type': 'application/json',
    };
    if (requiresAuth) {
      final token = await _sessionStorage.readToken();
      if (token == null || token.isEmpty) {
        throw const ApiException(
          'Not signed in. Please log in again.',
          statusCode: 401,
        );
      }
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }

  Map<String, dynamic> _handleResponse(http.Response response) {
    Map<String, dynamic> decoded = <String, dynamic>{};
    if (response.body.isNotEmpty) {
      try {
        final parsed = jsonDecode(response.body);
        if (parsed is Map<String, dynamic>) {
          decoded = parsed;
        }
      } catch (_) {
        // Non-JSON body (e.g. empty 401 response) — fall through, keep decoded empty.
      }
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return decoded;
    }

    final message = decoded['message']?.toString() ??
        decoded['title']?.toString() ??
        _defaultErrorMessage(response.statusCode);

    throw ApiException(message, statusCode: response.statusCode);
  }

  String _defaultErrorMessage(int statusCode) {
    switch (statusCode) {
      case 401:
        return 'Your session has expired. Please log in again.';
      case 404:
        return 'Requested resource was not found.';
      case 500:
        return 'Server error. Please try again later.';
      default:
        return 'Something went wrong (code $statusCode).';
    }
  }
}
