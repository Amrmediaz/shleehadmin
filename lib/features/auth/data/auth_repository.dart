import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';
import '../../../core/network/api_exception.dart';
import '../../../core/storage/session_storage.dart';
import 'owner_session.dart';

class AuthRepository {
  AuthRepository({ApiClient? apiClient, SessionStorage? sessionStorage})
      : _apiClient = apiClient ?? ApiClient(),
        _sessionStorage = sessionStorage ?? SessionStorage();

  final ApiClient _apiClient;
  final SessionStorage _sessionStorage;

  /// Calls POST /AppOwner/AppOwnerLogin and persists the returned token.
  Future<OwnerSession> login({
    required String username,
    required String password,
  }) async {
    final json = await _apiClient.post(
      ApiEndpoints.ownerLogin,
      body: {
        'username': username,
        'password': password,
      },
    );

    final session = OwnerSession.fromJson(json);

    if (session.token.isEmpty || !session.status) {
      throw const ApiException('Invalid username or password.');
    }

    await _sessionStorage.saveSession(
      token: session.token,
      expiresAt: session.expiresAt,
    );

    return session;
  }

  Future<bool> hasStoredSession() async {
    final token = await _sessionStorage.readToken();
    return token != null && token.isNotEmpty;
  }

  Future<void> logout() => _sessionStorage.clear();
}
