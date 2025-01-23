/// Service for managing local storage operations.
/// 
/// This file is responsible for:
/// - Providing a unified interface for local storage operations
/// - Managing persistent data storage using SharedPreferences
/// - Handling data serialization and deserialization
/// - Providing type-safe storage operations
/// 
/// Referenced by:
/// - Used by AuthService for token storage
/// - Used by UserService for user preferences
/// - Used throughout the app for persistent storage needs
/// 
/// Dependencies:
/// - Requires shared_preferences package
/// - Uses StorageKeys for consistent key management

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  /// Singleton instance of the StorageService.
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;

  /// Private constructor to prevent instantiation.
  StorageService._internal();

  /// SharedPreferences instance used for storage operations.
  late final SharedPreferences _prefs;

  /// Initialize the storage service.
  /// Must be called before using any storage operations.
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Store a string value.
  /// 
  /// [key] - Unique key for the stored value.
  /// [value] - String value to be stored.
  Future<bool> setString(String key, String value) async {
    return _prefs.setString(key, value);
  }

  /// Retrieve a string value.
  /// 
  /// [key] - Unique key for the stored value.
  /// Returns the stored string value, or null if not found.
  String? getString(String key) {
    return _prefs.getString(key);
  }

  /// Store a boolean value.
  /// 
  /// [key] - Unique key for the stored value.
  /// [value] - Boolean value to be stored.
  Future<bool> setBool(String key, bool value) async {
    return _prefs.setBool(key, value);
  }

  /// Retrieve a boolean value.
  /// 
  /// [key] - Unique key for the stored value.
  /// Returns the stored boolean value, or null if not found.
  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  /// Store an integer value.
  /// 
  /// [key] - Unique key for the stored value.
  /// [value] - Integer value to be stored.
  Future<bool> setInt(String key, int value) async {
    return _prefs.setInt(key, value);
  }

  /// Retrieve an integer value.
  /// 
  /// [key] - Unique key for the stored value.
  /// Returns the stored integer value, or null if not found.
  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  /// Store a double value.
  /// 
  /// [key] - Unique key for the stored value.
  /// [value] - Double value to be stored.
  Future<bool> setDouble(String key, double value) async {
    return _prefs.setDouble(key, value);
  }

  /// Retrieve a double value.
  /// 
  /// [key] - Unique key for the stored value.
  /// Returns the stored double value, or null if not found.
  double? getDouble(String key) {
    return _prefs.getDouble(key);
  }

  /// Store a list of string values.
  /// 
  /// [key] - Unique key for the stored value.
  /// [value] - List of string values to be stored.
  Future<bool> setStringList(String key, List<String> value) async {
    return _prefs.setStringList(key, value);
  }

  /// Retrieve a list of string values.
  /// 
  /// [key] - Unique key for the stored value.
  /// Returns the stored list of string values, or null if not found.
  List<String>? getStringList(String key) {
    return _prefs.getStringList(key);
  }

  /// Store a JSON-encodable object.
  /// 
  /// [key] - Unique key for the stored value.
  /// [value] - JSON-encodable object to be stored.
  Future<bool> setObject(String key, Map<String, dynamic> value) async {
    return _prefs.setString(key, jsonEncode(value));
  }

  /// Retrieve and decode a JSON object.
  /// 
  /// [key] - Unique key for the stored value.
  /// Returns the stored JSON object, or null if not found.
  Map<String, dynamic>? getObject(String key) {
    final data = _prefs.getString(key);
    if (data == null) return null;
    return jsonDecode(data) as Map<String, dynamic>;
  }

  /// Remove a value from storage.
  /// 
  /// [key] - Unique key for the stored value.
  Future<bool> remove(String key) async {
    return _prefs.remove(key);
  }

  /// Clear all stored values.
  Future<bool> clear() async {
    return _prefs.clear();
  }

  /// Check if a key exists in storage.
  /// 
  /// [key] - Unique key to check.
  bool containsKey(String key) {
    return _prefs.containsKey(key);
  }
}
