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
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:meal_planner/features/auth/providers/auth_provider.dart';
import 'package:meal_planner/features/auth/screens/auth_screen.dart';
import 'package:meal_planner/features/home/screens/home_screen.dart';
import 'package:meal_planner/features/meals/screens/weekly_plan_screen.dart';

part 'app_router.g.dart';

/// Named routes for the application
class AppRoutes {
  static const String home = '/';
  static const String auth = '/auth';
  static const String weeklyPlan = '/weekly-plan';
}

/// Provider for the application router
@riverpod
GoRouter router(RouterRef ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      // Handle authentication redirects
      final isLoggedIn = authState.value != null;
      final isAuthRoute = state.uri.path == AppRoutes.auth;

      if (!isLoggedIn && state.uri.path != AppRoutes.auth) {
        return AppRoutes.auth;
      }

      if (isLoggedIn && state.uri.path == AppRoutes.auth) {
        return AppRoutes.home;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.auth,
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: AppRoutes.weeklyPlan,
        pageBuilder: (context, state) => CustomTransitionPage<void>(
          key: state.pageKey,
          child: const WeeklyPlanScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: animation.drive(
                Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).chain(CurveTween(curve: Curves.easeInOut)),
              ),
              child: child,
            );
          },
        ),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Error: ${state.error}'),
      ),
    ),
  );
}
