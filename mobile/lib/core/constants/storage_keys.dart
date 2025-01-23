/// Constants for local storage keys used throughout the application.
/// 
/// This file is responsible for:
/// - Defining constant keys used for local storage
/// - Providing a centralized location for storage key management
/// - Preventing typos and inconsistencies in storage key usage
/// 
/// Referenced by:
/// - Used by StorageService for accessing local storage
/// - Used by AuthService for token management
/// - Used by any feature requiring persistent storage
/// 
/// Dependencies:
/// - No external dependencies
/// - Used as a pure constants file

class StorageKeys {
  StorageKeys._();

  /// Key for storing the authentication token
  static const String token = 'token';
  
  /// Key for storing the user's profile data
  static const String user = 'user';
  
  /// Key for storing the user's theme preference
  static const String theme = 'theme';
  
  /// Key for storing whether the user has completed onboarding
  static const String onboarding = 'onboarding';
  
  /// Key for storing the user's notification preferences
  static const String notifications = 'notifications';
  
  /// Key for storing the user's language preference
  static const String language = 'language';
}
