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

part 'auth_service.g.dart';

class AuthException implements Exception {
  final String message;
  final bool isNetworkError;
  final bool isServerError;
  final bool isAuthError;

  AuthException({
    required this.message,
    this.isNetworkError = false,
    this.isServerError = false,
    this.isAuthError = false,
  });
}

@RestApi()
abstract class AuthServiceApi {
  factory AuthServiceApi(Dio dio, {String baseUrl}) = _AuthServiceApi;

  @POST('/api/auth/register')
  Future<UserModel> register(@Body() Map<String, String> credentials);

  @POST('/api/auth/login')
  Future<UserModel> login(@Body() Map<String, String> credentials);

  @POST('/api/auth/logout')
  Future<void> logout();

  @POST('/api/auth/reset-password')
  Future<void> resetPassword(@Body() Map<String, String> request);

  @GET('/api/auth/me')
  Future<UserModel> getCurrentUser();

  @PATCH('/api/auth/profile')
  Future<UserModel> updateProfile(@Body() Map<String, String> profile);
}

class AuthService extends StateNotifier<UserModel?> {
  final AuthServiceApi _api;
  final Dio _dio;

  AuthService(this._api, this._dio) : super(null);

  Future<UserModel> register(String email, String password) async {
    try {
      final user = await _api.register({
        'email': email,
        'password': password,
      });
      state = user;
      return user;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<UserModel> login(String email, String password) async {
    try {
      final user = await _api.login({
        'email': email,
        'password': password,
      });
      state = user;
      return user;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<void> logout() async {
    try {
      await _api.logout();
      state = null;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _api.resetPassword({'email': email});
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<UserModel> getCurrentUser() async {
    try {
      final user = await _api.getCurrentUser();
      state = user;
      return user;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  Future<UserModel> updateProfile({
    String? displayName,
    String? photoUrl,
  }) async {
    try {
      final updates = <String, String>{};
      if (displayName != null) updates['displayName'] = displayName;
      if (photoUrl != null) updates['photoUrl'] = photoUrl;

      final user = await _api.updateProfile(updates);
      state = user;
      return user;
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  AuthException _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return AuthException(
          message: 'Network error. Please check your connection.',
          isNetworkError: true,
        );
      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        if (statusCode == 401 || statusCode == 403) {
          return AuthException(
            message: 'Authentication error. Please log in again.',
            isAuthError: true,
          );
        }
        return AuthException(
          message: e.response?.data['error'] ?? 'Server error occurred.',
          isServerError: true,
        );
      default:
        return AuthException(
          message: 'An unexpected error occurred.',
          isServerError: true,
        );
    }
  }
}

final authServiceProvider = StateNotifierProvider<AuthService, UserModel?>((ref) {
  final dio = Dio(BaseOptions(
    baseUrl: 'http://localhost:3000',
    contentType: 'application/json',
  ));
  
  final api = AuthServiceApi(dio);
  return AuthService(api, dio);
});
