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

import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';

part 'auth_provider.g.dart';

/// Provider for the AuthService instance
@riverpod
AuthService authService(AuthServiceRef ref) {
  final dio = Dio();
  return AuthService(AuthServiceApi(dio, baseUrl: 'https://api.example.com'));
}

/// Provider for the current authentication state
@riverpod
Stream<UserModel?> authState(AuthStateRef ref) {
  return ref.watch(authServiceProvider.notifier).stream;
}

/// Provider for the current user
@riverpod
UserModel? currentUser(CurrentUserRef ref) {
  return ref.watch(authServiceProvider).value;
}

/// Provider for checking if a user is authenticated
@riverpod
bool isAuthenticated(IsAuthenticatedRef ref) {
  return ref.watch(currentUserProvider) != null;
}

/// Provider for the user's display name
@riverpod
String? userDisplayName(UserDisplayNameRef ref) {
  return ref.watch(currentUserProvider)?.displayName;
}

/// Provider for the user's email
@riverpod
String? userEmail(UserEmailRef ref) {
  return ref.watch(currentUserProvider)?.email;
}

/// Provider for the user's photo URL
@riverpod
String? userPhotoUrl(UserPhotoUrlRef ref) {
  return ref.watch(currentUserProvider)?.photoUrl;
}
