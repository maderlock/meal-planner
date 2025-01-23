import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meal_planner/features/auth/models/user_model.dart';
import 'package:meal_planner/features/auth/services/auth_service.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthServiceApi extends Mock implements AuthServiceApi {}
class MockDio extends Mock implements Dio {}

void main() {
  late AuthService authService;
  late MockAuthServiceApi mockApi;
  late MockDio mockDio;

  setUp(() {
    mockApi = MockAuthServiceApi();
    mockDio = MockDio();
    authService = AuthService(mockApi, mockDio);
  });

  final mockUser = UserModel(
    id: 'test-uid',
    email: 'test@example.com',
    displayName: 'Test User',
    photoUrl: null,
    emailVerified: false,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  group('register', () {
    test('should register user successfully', () async {
      when(() => mockApi.register({
        'email': 'test@example.com',
        'password': 'password123',
      })).thenAnswer((_) async => mockUser);

      final user = await authService.register(
        'test@example.com',
        'password123',
      );

      expect(user.email, equals('test@example.com'));
      expect(user.id, equals('test-uid'));
      expect(authService.state, equals(user));
    });

    test('should throw AuthException on network error', () async {
      when(() => mockApi.register(any())).thenThrow(
        DioException(
          type: DioExceptionType.connectionTimeout,
          requestOptions: RequestOptions(),
        ),
      );

      expect(
        () => authService.register('test@example.com', 'password123'),
        throwsA(
          isA<AuthException>()
              .having((e) => e.isNetworkError, 'isNetworkError', true),
        ),
      );
    });
  });

  group('login', () {
    test('should login user successfully', () async {
      when(() => mockApi.login({
        'email': 'test@example.com',
        'password': 'password123',
      })).thenAnswer((_) async => mockUser);

      final user = await authService.login(
        'test@example.com',
        'password123',
      );

      expect(user.email, equals('test@example.com'));
      expect(user.id, equals('test-uid'));
      expect(authService.state, equals(user));
    });

    test('should throw AuthException on invalid credentials', () async {
      when(() => mockApi.login(any())).thenThrow(
        DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 401,
            requestOptions: RequestOptions(),
          ),
          requestOptions: RequestOptions(),
        ),
      );

      expect(
        () => authService.login('test@example.com', 'wrong-password'),
        throwsA(
          isA<AuthException>()
              .having((e) => e.isAuthError, 'isAuthError', true),
        ),
      );
    });
  });

  group('getCurrentUser', () {
    test('should get current user successfully', () async {
      when(() => mockApi.getCurrentUser())
          .thenAnswer((_) async => mockUser);

      final user = await authService.getCurrentUser();

      expect(user.email, equals('test@example.com'));
      expect(user.id, equals('test-uid'));
      expect(authService.state, equals(user));
    });

    test('should throw AuthException when not authenticated', () async {
      when(() => mockApi.getCurrentUser()).thenThrow(
        DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            statusCode: 401,
            requestOptions: RequestOptions(),
          ),
          requestOptions: RequestOptions(),
        ),
      );

      expect(
        authService.getCurrentUser,
        throwsA(
          isA<AuthException>()
              .having((e) => e.isAuthError, 'isAuthError', true),
        ),
      );
    });
  });

  group('logout', () {
    test('should logout successfully', () async {
      when(() => mockApi.logout()).thenAnswer((_) async => null);

      await authService.logout();

      expect(authService.state, isNull);
    });
  });

  group('updateProfile', () {
    test('should update profile successfully', () async {
      final updatedUser = mockUser.copyWith(
        displayName: 'Updated Name',
        photoUrl: 'https://example.com/photo.jpg',
      );

      when(() => mockApi.updateProfile({
        'displayName': 'Updated Name',
        'photoUrl': 'https://example.com/photo.jpg',
      })).thenAnswer((_) async => updatedUser);

      final user = await authService.updateProfile(
        displayName: 'Updated Name',
        photoUrl: 'https://example.com/photo.jpg',
      );

      expect(user.displayName, equals('Updated Name'));
      expect(user.photoUrl, equals('https://example.com/photo.jpg'));
      expect(authService.state, equals(user));
    });
  });

  group('resetPassword', () {
    test('should request password reset successfully', () async {
      when(() => mockApi.resetPassword({'email': 'test@example.com'}))
          .thenAnswer((_) async => null);

      await authService.resetPassword('test@example.com');
      verify(() => mockApi.resetPassword({'email': 'test@example.com'}))
          .called(1);
    });
  });
}
