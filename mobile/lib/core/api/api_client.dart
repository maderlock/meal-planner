/// HTTP client for making API requests to the backend server.
/// 
/// This file is responsible for:
/// - Making HTTP requests to the backend API
/// - Handling request headers and authentication
/// - Error handling and response parsing
/// - Maintaining API endpoint configurations
/// 
/// Referenced by:
/// - Used by all service classes (AuthService, MealService, etc.)
/// - Used for any network requests to the backend
/// 
/// Dependencies:
/// - Requires AppConfig for base URL configuration
/// - Uses Dio package for network requests

import 'package:dio/dio.dart';
import 'package:meal_planner/core/config/app_config.dart';

/// Singleton class for making API requests.
class ApiClient {
  /// Private constructor to prevent instantiation.
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  /// Dio instance for making HTTP requests.
  late final Dio _dio;

  /// Private constructor to initialize Dio instance.
  ApiClient._internal() {
    _dio = Dio(
      BaseOptions(
        /// Base URL for API requests.
        baseUrl: AppConfig.instance.baseUrl,
        /// Connection timeout for API requests.
        connectTimeout: const Duration(seconds: 5),
        /// Receive timeout for API requests.
        receiveTimeout: const Duration(seconds: 3),
        /// Default headers for API requests.
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    /// Add interceptor for request and error handling.
    _dio.interceptors.add(
      InterceptorsWrapper(
        /// Handle request headers and authentication.
        onRequest: (options, handler) {
          // Add auth token if available
          // final token = AuthService().token;
          // if (token != null) {
          //   options.headers['Authorization'] = 'Bearer $token';
          // }
          return handler.next(options);
        },
        /// Handle common errors (401, 403, etc.).
        onError: (error, handler) {
          return handler.next(error);
        },
      ),
    );
  }

  /// Make a GET request to the specified endpoint.
  Future<Response<T>> get<T>(
    /// Endpoint for the GET request.
    String path, {
    /// Query parameters for the GET request.
    Map<String, dynamic>? queryParameters,
    /// Options for the GET request.
    Options? options,
    /// Cancel token for the GET request.
    CancelToken? cancelToken,
    /// Progress callback for the GET request.
    void Function(int, int)? onReceiveProgress,
  }) {
    return _dio.get<T>(
      path,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// Make a POST request to the specified endpoint.
  Future<Response<T>> post<T>(
    /// Endpoint for the POST request.
    String path, {
    /// Body for the POST request.
    dynamic data,
    /// Query parameters for the POST request.
    Map<String, dynamic>? queryParameters,
    /// Options for the POST request.
    Options? options,
    /// Cancel token for the POST request.
    CancelToken? cancelToken,
    /// Progress callback for sending data.
    void Function(int, int)? onSendProgress,
    /// Progress callback for receiving data.
    void Function(int, int)? onReceiveProgress,
  }) {
    return _dio.post<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// Make a PUT request to the specified endpoint.
  Future<Response<T>> put<T>(
    /// Endpoint for the PUT request.
    String path, {
    /// Body for the PUT request.
    dynamic data,
    /// Query parameters for the PUT request.
    Map<String, dynamic>? queryParameters,
    /// Options for the PUT request.
    Options? options,
    /// Cancel token for the PUT request.
    CancelToken? cancelToken,
    /// Progress callback for sending data.
    void Function(int, int)? onSendProgress,
    /// Progress callback for receiving data.
    void Function(int, int)? onReceiveProgress,
  }) {
    return _dio.put<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );
  }

  /// Make a DELETE request to the specified endpoint.
  Future<Response<T>> delete<T>(
    /// Endpoint for the DELETE request.
    String path, {
    /// Body for the DELETE request.
    dynamic data,
    /// Query parameters for the DELETE request.
    Map<String, dynamic>? queryParameters,
    /// Options for the DELETE request.
    Options? options,
    /// Cancel token for the DELETE request.
    CancelToken? cancelToken,
  }) {
    return _dio.delete<T>(
      path,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
  }
}
