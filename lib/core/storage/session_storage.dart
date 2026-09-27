import 'package:shared_preferences/shared_preferences.dart';

/// Persists the owner's auth token (and its expiry) across app restarts.
class SessionStorage {
  static const String _tokenKey = 'owner_token';
  static const String _expireKey = 'owner_token_expire';

  Future<void> saveSession({required String token, String? expiresAt}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    if (expiresAt != null) {
      await prefs.setString(_expireKey, expiresAt);
    }
  }

  Future<String?> readToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<String?> readExpiry() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_expireKey);
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_expireKey);
  }
}
