import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meal_planner/features/auth/models/user_model.dart';
import 'package:meal_planner/features/auth/screens/auth_screen.dart';
import 'package:meal_planner/features/auth/services/auth_service.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  late MockAuthService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthService();
  });

  Widget createWidgetUnderTest() {
    return ProviderScope(
      overrides: [
        authServiceProvider.overrideWith((ref) => mockAuthService),
      ],
      child: const MaterialApp(
        home: AuthScreen(),
      ),
    );
  }

  final mockUser = UserModel(
    id: 'test-uid',
    email: 'test@example.com',
    displayName: 'Test User',
    photoUrl: null,
    emailVerified: false,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );

  group('AuthScreen', () {
    testWidgets('shows login form by default', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text('Welcome Back'), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
      expect(find.text('Need an account? Sign up'), findsOneWidget);
      expect(find.text('Forgot Password?'), findsOneWidget);
    });

    testWidgets('switches to signup form', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text('Need an account? Sign up'));
      await tester.pumpAndSettle();

      expect(find.text('Create Account'), findsOneWidget);
      expect(find.text('Sign Up'), findsOneWidget);
      expect(find.text('Have an account? Login'), findsOneWidget);
      expect(find.text('Forgot Password?'), findsNothing);
    });

    testWidgets('shows validation errors for empty fields', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter your email'), findsOneWidget);
      expect(find.text('Please enter your password'), findsOneWidget);
    });

    testWidgets('shows validation error for invalid email', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.enterText(find.widgetWithText(TextFormField, 'Email'), 'invalid-email');
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid email'), findsOneWidget);
    });

    testWidgets('shows validation error for short password on signup', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text('Need an account? Sign up'));
      await tester.pumpAndSettle();

      await tester.enterText(find.widgetWithText(TextFormField, 'Email'), 'test@example.com');
      await tester.enterText(find.widgetWithText(TextFormField, 'Password'), '123');
      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle();

      expect(find.text('Password must be at least 8 characters'), findsOneWidget);
    });

    testWidgets('handles successful login', (tester) async {
      when(() => mockAuthService.login(any(), any()))
          .thenAnswer((_) async => mockUser);

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.enterText(find.widgetWithText(TextFormField, 'Email'), 'test@example.com');
      await tester.enterText(find.widgetWithText(TextFormField, 'Password'), 'password123');
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      verify(() => mockAuthService.login('test@example.com', 'password123')).called(1);
    });

    testWidgets('handles successful registration', (tester) async {
      when(() => mockAuthService.register(any(), any()))
          .thenAnswer((_) async => mockUser);

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text('Need an account? Sign up'));
      await tester.pumpAndSettle();

      await tester.enterText(find.widgetWithText(TextFormField, 'Email'), 'test@example.com');
      await tester.enterText(find.widgetWithText(TextFormField, 'Password'), 'password123');
      await tester.tap(find.text('Sign Up'));
      await tester.pumpAndSettle();

      verify(() => mockAuthService.register('test@example.com', 'password123')).called(1);
    });

    testWidgets('handles login error', (tester) async {
      when(() => mockAuthService.login(any(), any()))
          .thenThrow(AuthException(message: 'Invalid credentials'));

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.enterText(find.widgetWithText(TextFormField, 'Email'), 'test@example.com');
      await tester.enterText(find.widgetWithText(TextFormField, 'Password'), 'password123');
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      expect(find.text('Invalid credentials'), findsOneWidget);
    });

    testWidgets('handles password reset', (tester) async {
      when(() => mockAuthService.resetPassword(any()))
          .thenAnswer((_) async {});

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.enterText(find.widgetWithText(TextFormField, 'Email'), 'test@example.com');
      await tester.tap(find.text('Forgot Password?'));
      await tester.pumpAndSettle();

      verify(() => mockAuthService.resetPassword('test@example.com')).called(1);
      expect(find.text('Password reset email sent'), findsOneWidget);
    });
  });
}
