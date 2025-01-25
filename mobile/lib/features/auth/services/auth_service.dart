/// Authentication service for handling user authentication operations.
/// 
/// This service is responsible for:
/// - Managing user sign-in and sign-out operations
/// - Handling authentication state changes
/// - Providing user information
/// 
/// Referenced by:
/// - Used by auth_provider.dart for authentication state management
/// - Used by auth_screen.dart for login/logout functionality
/// 
/// Dependencies:
/// - Uses REST API for authentication operations

import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:retrofit/retrofit.dart';
import '../models/user_model.dart';
import '../../../core/config/app_config.dart';
import '../../../core/network/api_client.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_service.g.dart';

class AuthException implements Exception {
  final String message;
  final int? statusCode;

  AuthException(this.message, {this.statusCode});

  @override
  String toString() => message;
}

@JsonSerializable()
class AuthResponse {
  final UserModel user;
  final String token;

  AuthResponse({required this.user, required this.token});

  factory AuthResponse.fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AuthResponseToJson(this);
}

@JsonSerializable()
class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable()
class RegisterRequest {
  final String email;
  final String password;
  final String? username;

  RegisterRequest({required this.email, required this.password, this.username});

  factory RegisterRequest.fromJson(Map<String, dynamic> json) => _$RegisterRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}

@RestApi()
abstract class AuthServiceApi {
  factory AuthServiceApi(Dio dio, {String? baseUrl}) = _AuthServiceApi;

  @POST('/auth/register')
  Future<AuthResponse> register(@Body() RegisterRequest credentials);

  @POST('/auth/login')
  Future<AuthResponse> login(@Body() LoginRequest credentials);

  @POST('/auth/logout')
  Future<void> logout();

  @POST('/auth/reset-password')
  Future<void> resetPassword(@Body() Map<String, String> request);

  @GET('/auth/me')
  Future<UserModel> me();
}

/// Service for handling authentication operations
class AuthService extends StateNotifier<UserModel?> {
  final AuthServiceApi _api;

  AuthService(this._api) : super(null) {
    developer.log('Initializing AuthService', name: 'Auth');
    // Try to restore the auth state when service is created
    _restoreAuthState();
  }

  Future<void> _restoreAuthState() async {
    try {
      developer.log('Starting auth state restoration', name: 'Auth');
      final token = await getToken();
      developer.log('Retrieved token: ${token != null ? 'Token exists' : 'No token found'}', name: 'Auth');
      
      if (token != null) {
        // Token exists, try to fetch user info
        developer.log('Attempting to fetch user info with token', name: 'Auth');
        final user = await _api.me();
        developer.log('Successfully fetched user info: ${user.email}', name: 'Auth');
        state = user;
        developer.log('Auth state restored successfully', name: 'Auth');
      } else {
        developer.log('No token found, skipping auth restoration', name: 'Auth');
      }
    } catch (e) {
      // If token is invalid or user fetch fails, clear the token
      developer.log('Failed to restore auth state: $e', name: 'Auth');
      await _removeToken();
      state = null;
    }
  }

  /// Register a new user
  Future<UserModel> register(String email, String password, {String? username}) async {
    try {
      final response = await _api.register(RegisterRequest(
        email: email,
        password: password,
        username: username,
      ));
      developer.log('Registration successful, saving token', name: 'Auth');
      await _saveToken(response.token);
      state = response.user;
      developer.log('User state updated after registration', name: 'Auth');
      return response.user;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Log in an existing user
  Future<UserModel> login(String email, String password) async {
    try {
      final response = await _api.login(LoginRequest(
        email: email,
        password: password,
      ));
      developer.log('Login successful, saving token', name: 'Auth');
      await _saveToken(response.token);
      state = response.user;
      developer.log('User state updated after login', name: 'Auth');
      return response.user;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Log out the current user
  Future<void> logout() async {
    try {
      await _api.logout();
      await _removeToken();
      state = null;
      developer.log('Logout successful', name: 'Auth');
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Reset password for a user
  Future<void> resetPassword(String email) async {
    try {
      await _api.resetPassword({'email': email});
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Get the current user
  UserModel? getCurrentUser() => state;

  /// Get the auth token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    developer.log('Getting token: ${token != null ? 'Token exists' : 'No token found'}', name: 'Auth');
    return token;
  }

  /// Save the auth token
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final tokenWithPrefix = 'Bearer $token';
    await prefs.setString('auth_token', tokenWithPrefix);
    developer.log('Token saved successfully: $tokenWithPrefix', name: 'Auth');
  }

  /// Remove the auth token
  Future<void> _removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    developer.log('Token removed', name: 'Auth');
  }

  /// Update user profile
  Future<UserModel> updateProfile({
    String? displayName,
    String? photoUrl,
  }) async {
    final currentUser = state;
    if (currentUser == null) {
      throw AuthException('Not logged in');
    }

    try {
      final updatedUser = currentUser.copyWith(
        displayName: displayName ?? currentUser.displayName,
        photoUrl: photoUrl ?? currentUser.photoUrl,
      );
      state = updatedUser;
      return updatedUser;
    } catch (e) {
      developer.log('Error updating profile', error: e);
      throw AuthException('Failed to update profile');
    }
  }

  /// Handle Dio errors and convert them to AuthException
  AuthException _handleDioError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return AuthException('Connection timeout. Please check your internet connection.');
    }

    final data = e.response?.data;
    String message = 'An error occurred';
    
    if (data is Map<String, dynamic> && data.containsKey('error')) {
      message = data['error'] as String;
    }

    return AuthException(message, statusCode: e.response?.statusCode);
  }
}
