/// Authentication state management for the application.
/// 
/// This file is responsible for:
/// - Managing authentication state using Riverpod
/// - Providing user authentication status throughout the app
/// - Handling login, logout, and user session management
/// - Interfacing with Firebase Auth services
/// 
/// Referenced by:
/// - Used by app_router.dart for authentication-based routing
/// - Used throughout the app to check authentication status
/// - Used by auth_screen.dart for login/logout functionality
/// 
/// Dependencies:
/// - Uses Riverpod for state management
/// - Uses Firebase Auth for authentication
/// - Uses AuthService for authentication operations

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_planner/features/auth/models/user_model.dart';
import 'package:meal_planner/features/auth/services/auth_service.dart';

/// Provider for the AuthService instance
/// 
/// This provider returns an instance of AuthService, which is used for authentication operations.
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

/// Provider for the current authentication state
/// 
/// This provider returns the current authentication state as an AsyncValue of UserModel.
/// It is used to determine the current user's authentication status.
final authStateProvider = StateNotifierProvider<AuthService, AsyncValue<UserModel?>>(
  (ref) => ref.watch(authServiceProvider.notifier),
);

/// Provider for the current user
/// 
/// This provider returns the current user as a UserModel.
/// It is used to access the current user's data throughout the app.
final currentUserProvider = Provider<UserModel?>((ref) {
  return ref.watch(authStateProvider).value;
});
