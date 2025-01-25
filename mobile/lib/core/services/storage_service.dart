import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Service for securely storing sensitive data like auth tokens
class StorageService {
  static const _storage = FlutterSecureStorage();
  static const _tokenKey = 'auth_token';

  /// Store the authentication token securely
  static Future<void> setAuthToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  /// Retrieve the stored authentication token
  static Future<String?> getAuthToken() async {
    return await _storage.read(key: _tokenKey);
  }

  /// Remove the stored authentication token
  static Future<void> removeAuthToken() async {
    await _storage.delete(key: _tokenKey);
  }
}
