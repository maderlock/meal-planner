/// Main entry point for the Meal Planner mobile application.
/// 
/// This file is responsible for:
/// - Initializing core services (Firebase, Environment variables, Storage)
/// - Setting up the app configuration
/// - Configuring the root widget with Riverpod provider scope
/// - Setting up the app theme and routing
/// 
/// Referenced by:
/// - This is the root file and is not referenced by other files
/// - Referenced in pubspec.yaml as the main entry point
/// 
/// Dependencies:
/// - Requires .env file for environment variables
/// - Requires firebase_options.dart for Firebase configuration
/// - Uses AppConfig for app-wide configuration
/// - Uses AppRouter for navigation
/// - Uses AppTheme for styling

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_planner/core/config/app_config.dart';
import 'package:meal_planner/core/router/app_router.dart';
import 'package:meal_planner/core/storage/storage_service.dart';
import 'package:meal_planner/core/theme/app_theme.dart';
import 'package:meal_planner/firebase_options.dart';

/// Main entry point for the application.
/// 
/// Initializes the app and sets up the root widget.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: '.env');

  // Initialize services
  await StorageService().init();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize app configuration
  AppConfig().initialize(
    env: Environment.dev,
    baseUrl: 'http://localhost:3000/api',
    key: '',
  );

  runApp(
    const ProviderScope(
      child: MealPlannerApp(),
    ),
  );
}

/// Root widget for the Meal Planner application.
/// 
/// Configures the app theme, routing, and sets up the Riverpod provider scope.
class MealPlannerApp extends ConsumerWidget {
  const MealPlannerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: AppConfig.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
