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
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/config/app_config.dart';
import 'core/router/app_router.dart';
import 'features/auth/providers/auth_provider.dart';
import 'features/splash/widgets/splash_overlay.dart';
import 'firebase_options.dart';

/// Tracks the initialization state of the app
final initializingProvider = FutureProvider<void>((ref) async {
  // Get the auth service
  final auth = ref.read(authServiceProvider.notifier);

  // Try to restore the auth state
  await auth.getToken();
});

/// Tracks whether the app is fully ready (initialized and routed)
final appReadyProvider = StateProvider<bool>((ref) => false);

/// Main entry point for the application.
///
/// Initializes the app and sets up the root widget.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: '.env');

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
class MealPlannerApp extends ConsumerStatefulWidget {
  const MealPlannerApp({super.key});

  @override
  ConsumerState<MealPlannerApp> createState() => _MealPlannerAppState();
}

class _MealPlannerAppState extends ConsumerState<MealPlannerApp> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    _checkInitialization();
  }

  Future<void> _checkInitialization() async {
    // Wait for initialization
    await ref.read(initializingProvider.future);

    // Give the router time to settle
    await Future.delayed(const Duration(milliseconds: 100));

    // Mark app as ready
    ref.read(appReadyProvider.notifier).state = true;

    // Start splash fade out
    if (mounted) {
      setState(() => _showSplash = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Meal Planner',
      theme: ThemeData(
        primaryColor: const Color(0xFF4CAF50), // Material Green
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4CAF50),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      routerConfig: router,
      builder: (context, child) => Stack(
        children: [
          // Main app content
          child ?? const SizedBox.shrink(),

          // Splash overlay with fade animation
          AnimatedOpacity(
            opacity: _showSplash ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 500),
            onEnd: () {
              // Optional: remove splash from widget tree after fade
              if (!_showSplash && mounted) {
                setState(() {});
              }
            },
            child: _showSplash ? const SplashOverlay() : null,
          ),
        ],
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
