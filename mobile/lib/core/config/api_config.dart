/// Configuration for API endpoints and settings.
/// 
/// This class is responsible for loading and providing API-related configuration
/// from environment variables.

import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConfig {
  /// Base URL for the API
  static String get baseUrl => dotenv.env['API_URL'] ?? 'http://localhost:3000';

  /// API version prefix
  static const String apiVersion = '/api';

  /// Full API URL including version
  static String get apiUrl => '$baseUrl$apiVersion';

  /// Authentication endpoints
  static String get loginEndpoint => '$apiUrl/auth/login';
  static String get logoutEndpoint => '$apiUrl/auth/logout';
  static String get registerEndpoint => '$apiUrl/auth/register';

  /// Meal endpoints
  static String get mealsEndpoint => '$apiUrl/meals';
  static String get weeklyPlansEndpoint => '$apiUrl/weekly-plans';
  static String get favoritesEndpoint => '$apiUrl/favorites';

  /// Timeout duration for API requests (in milliseconds)
  static const int connectionTimeout = 30000;
  static const int receiveTimeout = 30000;
}
