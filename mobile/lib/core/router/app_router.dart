/// Router configuration for the application.
/// 
/// This file is responsible for:
/// - Defining all application routes
/// - Handling navigation and deep linking
/// - Managing route guards and authentication state
/// - Providing type-safe route parameters
/// 
/// Referenced by:
/// - Used in main.dart for app-wide routing configuration
/// - Used throughout the app for navigation
/// - Used by deep links and notifications for routing
/// 
/// Dependencies:
/// - Uses go_router package for routing
/// - Uses Riverpod for state management
/// - Requires auth_provider.dart for authentication state

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_planner/features/auth/screens/auth_screen.dart';
import 'package:meal_planner/features/auth/services/auth_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

/// Named routes for the application
class AppRoutes {
  static const String home = '/';
  static const String auth = '/auth';
}

/// Provider for the application router
@riverpod
GoRouter router(RouterRef ref) {
  final authState = ref.watch(authServiceProvider);

  return GoRouter(
    initialLocation: AppRoutes.auth,
    redirect: (context, state) {
      // If the user is not logged in and not on the auth screen, redirect to auth
      if (authState.value == null &&
          state.matchedLocation != AppRoutes.auth) {
        return AppRoutes.auth;
      }

      // If the user is logged in and on the auth screen, redirect to home
      if (authState.value != null &&
          state.matchedLocation == AppRoutes.auth) {
        return AppRoutes.home;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.auth,
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const Scaffold(
          body: Center(
            child: Text('Home Screen - Coming Soon'),
          ),
        ),
      ),
    ],
  );
}
