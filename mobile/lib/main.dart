import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_planner/core/config/app_config.dart';
import 'package:meal_planner/core/router/app_router.dart';
import 'package:meal_planner/core/storage/storage_service.dart';
import 'package:meal_planner/core/theme/app_theme.dart';
import 'package:meal_planner/firebase_options.dart';

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
