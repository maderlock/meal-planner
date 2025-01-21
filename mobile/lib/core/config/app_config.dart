import 'package:flutter/foundation.dart';

enum Environment { dev, staging, prod }

class AppConfig {
  static final AppConfig _instance = AppConfig._internal();
  factory AppConfig() => _instance;
  AppConfig._internal();

  static const String appName = 'Meal Planner';
  late Environment environment;
  late String apiBaseUrl;
  late String apiKey;

  void initialize({
    required Environment env,
    required String baseUrl,
    required String key,
  }) {
    environment = env;
    apiBaseUrl = baseUrl;
    apiKey = key;
  }

  bool get isDevelopment => environment == Environment.dev;
  bool get isStaging => environment == Environment.staging;
  bool get isProduction => environment == Environment.prod;
  bool get shouldCollectCrashlytics => !isDevelopment;
  bool get shouldReportAnalytics => !isDevelopment;

  @visibleForTesting
  void reset() {
    environment = Environment.dev;
    apiBaseUrl = '';
    apiKey = '';
  }
}
