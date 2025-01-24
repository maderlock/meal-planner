/// Main entry point for the Meal Planner application.
/// 
/// This file is responsible for:
/// - Initializing Firebase for authentication
/// - Setting up Riverpod providers
/// - Configuring the app theme and routing
/// - Starting the application
/// 
/// Dependencies:
/// - Uses Firebase Core for authentication
/// - Uses Riverpod for state management
/// - Uses GoRouter for navigation
/// - Uses flutter_dotenv for environment variables

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meal_planner/core/router/app_router.dart';
import 'package:meal_planner/firebase_options.dart';
import 'package:meal_planner/core/config/app_config.dart';

/// Main entry point for the application.
/// 
/// Initializes the app and sets up the root widget.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load environment variables
  await dotenv.load(fileName: ".env");
  
  // Initialize app config
  final apiUrl = dotenv.env['API_URL'] ?? 'http://localhost:3000';
  AppConfig.instance.initialize(
    env: Environment.dev,
    baseUrl: '$apiUrl/api',
    key: dotenv.env['API_KEY'] ?? '',
  );

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
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
      title: 'Meal Planner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
