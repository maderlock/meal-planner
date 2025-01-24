/// Configuration class for application-wide settings.
/// 
/// This file is responsible for:
/// - Managing environment-specific configurations
/// - Storing app-wide constants and settings
/// - Providing access to configuration values throughout the app
/// 
/// Referenced by:
/// - Used by ApiClient for base URL configuration
/// - Used by main.dart for app initialization
/// - Used throughout the app for environment-specific behavior
/// 
/// Dependencies:
/// - No external package dependencies
/// - Used as a singleton throughout the app

import 'package:flutter/foundation.dart';

/// Enum representing different environments for the application.
enum Environment { dev, staging, prod }

/// Configuration class for application-wide settings.
class AppConfig {
  /// Private constructor to prevent instantiation from outside.
  AppConfig._internal();

  /// Singleton instance of AppConfig.
  static final AppConfig _instance = AppConfig._internal();

  /// Public getter for the singleton instance.
  static AppConfig get instance => _instance;

  /// Application name.
  static const String appName = 'Meal Planner';

  /// Environment in which the app is running.
  late final Environment _env;
  /// Base URL for API requests.
  late final String _apiBaseUrl;
  /// API key for authentication.
  late final String _apiKey;

  /// Get the base URL for API requests.
  String get baseUrl => _apiBaseUrl;
  /// Get the API key.
  String get apiKey => _apiKey;

  /// Checks if the app is running in development environment.
  bool get isDevelopment => _env == Environment.dev;
  /// Checks if the app is running in staging environment.
  bool get isStaging => _env == Environment.staging;
  /// Checks if the app is running in production environment.
  bool get isProduction => _env == Environment.prod;
  /// Checks if crashlytics data should be collected.
  bool get shouldCollectCrashlytics => !isDevelopment;
  /// Checks if analytics data should be reported.
  bool get shouldReportAnalytics => !isDevelopment;

  /// Initializes the AppConfig instance with environment-specific settings.
  void initialize({
    required Environment env,
    required String baseUrl,
    required String key,
  }) {
    _env = env;
    _apiBaseUrl = baseUrl;
    _apiKey = key;
  }

  /// Resets the configuration to default values.
  /// Useful for testing and development.
  @visibleForTesting
  void reset() {
    _env = Environment.dev;
    _apiBaseUrl = '';
    _apiKey = '';
  }
}
