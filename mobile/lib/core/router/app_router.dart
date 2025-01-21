import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_planner/features/auth/screens/auth_screen.dart';
import 'package:meal_planner/features/auth/services/auth_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@riverpod
GoRouter router(RouterRef ref) {
  final authState = ref.watch(authServiceProvider);

  return GoRouter(
    initialLocation: '/auth',
    redirect: (context, state) {
      // If the user is not logged in and not on the auth screen, redirect to auth
      if (authState.value == null &&
          state.matchedLocation != '/auth') {
        return '/auth';
      }

      // If the user is logged in and on the auth screen, redirect to home
      if (authState.value != null &&
          state.matchedLocation == '/auth') {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/',
        builder: (context, state) => const Scaffold(
          body: Center(
            child: Text('Home Screen - Coming Soon'),
          ),
        ),
      ),
    ],
  );
}
