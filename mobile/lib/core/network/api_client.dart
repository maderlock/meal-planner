/// Base API client configuration and setup.
///
/// This file provides a configured Dio instance with proper interceptors,
/// error handling, and authentication token management.

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/api_config.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/auth/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

/// Custom exception for API errors
class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, {this.statusCode});

  @override
  String toString() => message;

  /// Create a user-friendly error message
  String toUserMessage() {
    switch (statusCode) {
      case 400:
        return 'Invalid request. Please check your input.';
      case 401:
        return 'Please log in to continue.';
      case 403:
        return 'You do not have permission to perform this action.';
      case 404:
        return 'The requested resource was not found.';
      case 409:
        return 'This resource already exists.';
      case 500:
        return 'Something went wrong on our end. Please try again later.';
      default:
        return message;
    }
  }
}

extension DateTimeExtension on DateTime {
  bool isValidWeekStart() {
    return weekday == 1 && hour == 0 && minute == 0 && second == 0;
  }
}

/// ApiClient class for making HTTP requests
class ApiClient {
  final Dio _dio;

  ApiClient()
      : _dio = Dio(BaseOptions(
          baseUrl: ApiConfig.baseUrl,
          connectTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 3),
        )) {
    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add auth token if available
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('auth_token');
          developer.log('Request to ${options.path}', name: 'ApiClient');
          
          if (token != null) {
            developer.log('Adding token to request', name: 'ApiClient');
            options.headers['Authorization'] = token;  // Remove 'Bearer ' prefix since it's included in the token
          } else {
            developer.log('No auth token found', name: 'ApiClient');
          }

          // Validate weekStartDate in query parameters if present
          if (options.queryParameters.containsKey('weekStartDate')) {
            final date = DateTime.parse(options.queryParameters['weekStartDate'] as String);
            if (!date.isValidWeekStart()) {
              throw ApiException(
                'Invalid weekStartDate. Must be a Monday at 00:00:00',
                statusCode: 400,
              );
            }
          }

          // Validate weekStartDate in request body if present
          if (options.data is Map && (options.data as Map).containsKey('weekStartDate')) {
            final date = DateTime.parse((options.data as Map)['weekStartDate'] as String);
            if (!date.isValidWeekStart()) {
              throw ApiException(
                'Invalid weekStartDate. Must be a Monday at 00:00:00',
                statusCode: 400,
              );
            }
          }
          
          developer.log('Request headers: ${options.headers}', name: 'ApiClient');
          return handler.next(options);
        },
        onError: (error, handler) {
          developer.log('API Error: ${error.message}', name: 'ApiClient');
          developer.log('Error response: ${error.response?.data}', name: 'ApiClient');
          return handler.next(error);
        },
      ),
    );
  }

  Future<Response> get(String path,
      {Map<String, dynamic>? queryParameters, Options? options}) async {
    try {
      return await _dio.get(path,
          queryParameters: queryParameters, options: options);
    } on DioException catch (e) {
      developer.log('GET error: $e', name: 'ApiClient');
      throw ApiException(
        e.response?.statusMessage ?? e.message ?? 'Unknown error',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      developer.log('GET error: $e', name: 'ApiClient');
      throw ApiException('Failed to perform GET request: ${e.toString()}');
    }
  }

  Future<Response> post(String path, {dynamic data, Options? options}) async {
    try {
      developer.log('POST request to $path with data: $data', name: 'ApiClient');
      final response = await _dio.post(path, data: data, options: options);
      developer.log('POST response: ${response.data}', name: 'ApiClient');
      return response;
    } on DioException catch (e) {
      developer.log('POST error: $e', name: 'ApiClient');
      throw ApiException(
        e.response?.statusMessage ?? e.message ?? 'Unknown error',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      developer.log('POST error: $e', name: 'ApiClient');
      throw ApiException('Failed to perform POST request: ${e.toString()}');
    }
  }

  Future<Response> put(String path, {dynamic data}) async {
    try {
      return await _dio.put(path, data: data);
    } on DioException catch (e) {
      developer.log('PUT error: $e', name: 'ApiClient');
      throw ApiException(
        e.response?.statusMessage ?? e.message ?? 'Unknown error',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      developer.log('PUT error: $e', name: 'ApiClient');
      throw ApiException('Failed to perform PUT request: ${e.toString()}');
    }
  }

  Future<Response> delete(String path) async {
    try {
      return await _dio.delete(path);
    } on DioException catch (e) {
      developer.log('DELETE error: $e', name: 'ApiClient');
      throw ApiException(
        e.response?.statusMessage ?? e.message ?? 'Unknown error',
        statusCode: e.response?.statusCode,
      );
    } catch (e) {
      developer.log('DELETE error: $e', name: 'ApiClient');
      throw ApiException('Failed to perform DELETE request: ${e.toString()}');
    }
  }
}

/// Provider for the base Dio client
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      connectTimeout: Duration(milliseconds: ApiConfig.connectionTimeout),
      receiveTimeout: Duration(milliseconds: ApiConfig.receiveTimeout),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // Add auth interceptor
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add auth token if available and not a login/register endpoint
        final isPublicEndpoint = options.path == '/auth/login' ||
            options.path == '/auth/register' ||
            options.path == '/auth/reset-password';

        if (!isPublicEndpoint) {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('auth_token');
          developer.log('Checking token for request to ${options.path}',
              name: 'API');
          if (token != null) {
            developer.log('Adding token to request: $token', name: 'API');
            options.headers['Authorization'] =
                token; // Token already includes 'Bearer' prefix
          } else {
            developer.log('No token found for request', name: 'API');
          }
        } else {
          developer.log('Skipping token for public endpoint ${options.path}',
              name: 'API');
        }

        // Log request details
        developer.log(
          'Making request to ${options.path}\n'
          'Method: ${options.method}\n'
          'Headers: ${options.headers}',
          name: 'API',
        );

        return handler.next(options);
      },
      onResponse: (response, handler) {
        developer.log(
          'Response from ${response.requestOptions.path}\n'
          'Status: ${response.statusCode}',
          name: 'API',
        );
        return handler.next(response);
      },
      onError: (error, handler) {
        developer.log(
          'Error on ${error.requestOptions.path}\n'
          'Status: ${error.response?.statusCode}\n'
          'Message: ${error.message}',
          name: 'API',
        );
        return handler.next(error);
      },
    ),
  );

  return dio;
});
