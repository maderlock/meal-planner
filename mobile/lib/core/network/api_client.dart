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

  // Add logging interceptor
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Add auth token if available and not an auth endpoint
        if (!options.path.contains('/auth/')) {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('auth_token');
          developer.log('Checking token for request to ${options.path}', name: 'API');
          if (token != null) {
            developer.log('Adding token to request', name: 'API');
            options.headers['Authorization'] = token;  // Token already includes 'Bearer' prefix
          } else {
            developer.log('No token found for request', name: 'API');
          }
        } else {
          developer.log('Skipping token for auth endpoint ${options.path}', name: 'API');
        }

        // Log request details
        developer.log('*** Request ***',
            name: 'API Log');
        developer.log('uri: ${options.uri}',
            name: 'API Log');
        developer.log('method: ${options.method}',
            name: 'API Log');
        developer.log('responseType: ${options.responseType}',
            name: 'API Log');
        developer.log('followRedirects: ${options.followRedirects}',
            name: 'API Log');
        developer.log('persistentConnection: ${options.persistentConnection}',
            name: 'API Log');
        developer.log('connectTimeout: ${options.connectTimeout}',
            name: 'API Log');
        developer.log('sendTimeout: ${options.sendTimeout}',
            name: 'API Log');
        developer.log('receiveTimeout: ${options.receiveTimeout}',
            name: 'API Log');
        developer.log('receiveDataWhenStatusError: ${options.receiveDataWhenStatusError}',
            name: 'API Log');
        developer.log('extra: ${options.extra}',
            name: 'API Log');
        developer.log('headers:',
            name: 'API Log');
        options.headers.forEach((key, value) {
          developer.log(' $key: $value',
              name: 'API Log');
        });
        if (options.data != null) {
          developer.log('data:',
              name: 'API Log');
          developer.log('${options.data}',
              name: 'API Log');
        }
        developer.log('',
            name: 'API Log');

        return handler.next(options);
      },
      onResponse: (response, handler) async {
        // Log response details
        developer.log('*** Response ***',
            name: 'API Log');
        developer.log('uri: ${response.requestOptions.uri}',
            name: 'API Log');
        developer.log('statusCode: ${response.statusCode}',
            name: 'API Log');
        developer.log('headers:',
            name: 'API Log');
        response.headers.forEach((name, values) {
          developer.log(' $name: ${values.join(', ')}',
              name: 'API Log');
        });
        developer.log('Response Text:',
            name: 'API Log');
        developer.log('${response.data}',
            name: 'API Log');
        developer.log('',
            name: 'API Log');

        return handler.next(response);
      },
      onError: (error, handler) async {
        // Log error details
        developer.log('*** DioException ***:',
            name: 'API Log');
        developer.log('uri: ${error.requestOptions.uri}',
            name: 'API Log');
        developer.log('$error',
            name: 'API Log');
        developer.log('uri: ${error.requestOptions.uri}',
            name: 'API Log');
        if (error.response != null) {
          developer.log('statusCode: ${error.response?.statusCode}',
              name: 'API Log');
          developer.log('headers:',
              name: 'API Log');
          error.response?.headers.forEach((name, values) {
            developer.log(' $name: ${values.join(', ')}',
                name: 'API Log');
          });
          developer.log('Response Text:',
              name: 'API Log');
          developer.log('${error.response?.data}',
              name: 'API Log');
        }
        developer.log('',
            name: 'API Log');

        // Convert DioException to ApiException
        if (error.response != null) {
          final data = error.response!.data;
          String message = 'An error occurred';
          
          if (data is Map<String, dynamic> && data.containsKey('error')) {
            message = data['error'] as String;
          }

          // Handle unauthorized error
          if (error.response?.statusCode == 401) {
            await ref.read(authStateProvider.notifier).logout();
          }

          // Return a new error response with our custom error
          return handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              error: ApiException(
                message,
                statusCode: error.response!.statusCode,
              ),
              response: error.response,
              type: error.type,
            ),
          );
        }
        return handler.next(error);
      },
    ),
  );

  return dio;
});
