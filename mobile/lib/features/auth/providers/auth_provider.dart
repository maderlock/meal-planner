/// Authentication state management for the application.
///
/// This file is responsible for:
/// - Managing authentication state using Riverpod
/// - Providing user authentication status throughout the app
/// - Handling login, logout, and user session management
/// - Interfacing with API services
///
/// Referenced by:
/// - Used by app_router.dart for authentication-based routing
/// - Used throughout the app to check authentication status
/// - Used by auth_screen.dart for login/logout functionality
///
/// Dependencies:
/// - Uses Riverpod for state management
/// - Uses Dio for API requests
/// - Uses AuthService for authentication operations

import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/config/api_config.dart';
import '../../../core/network/api_client.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

part 'auth_provider.g.dart';

/// Provider for the AuthService instance
final authServiceProvider =
    StateNotifierProvider<AuthService, UserModel?>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthService(AuthServiceApi(dio, baseUrl: ApiConfig.apiUrl));
});

/// Provider for the current authentication state
@riverpod
class AuthState extends _$AuthState {
  @override
  UserModel? build() => null;

  Future<void> login(String email, String password) async {
    final auth = ref.read(authServiceProvider.notifier);
    state = await auth.login(email, password);
  }

  Future<void> register(String email, String password,
      {String? username}) async {
    final auth = ref.read(authServiceProvider.notifier);
    state = await auth.register(email, password, username: username);
  }

  Future<void> logout() async {
    final auth = ref.read(authServiceProvider.notifier);
    await auth.logout();
    state = null;
  }

  Future<void> resetPassword(String email) async {
    final auth = ref.read(authServiceProvider.notifier);
    await auth.resetPassword(email);
  }

  Future<String?> getToken() async {
    final auth = ref.read(authServiceProvider.notifier);
    return auth.getToken();
  }
}

/// Provider for checking if a user is authenticated
@riverpod
bool isAuthenticated(Ref ref) {
  final user = ref.watch(authServiceProvider);
  return user != null;
}

/// Provider for the user's display name
@riverpod
String? userDisplayName(UserDisplayNameRef ref) =>
    ref.watch(authStateProvider.select((value) => value?.displayName));

/// Provider for the user's email
@riverpod
String? userEmail(UserEmailRef ref) =>
    ref.watch(authStateProvider.select((value) => value?.email));

/// Provider for the user's photo URL
@riverpod
String? userPhotoUrl(UserPhotoUrlRef ref) =>
    ref.watch(authStateProvider.select((value) => value?.photoUrl));
