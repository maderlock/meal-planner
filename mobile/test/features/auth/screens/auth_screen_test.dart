import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meal_planner/features/auth/models/user_model.dart';
import 'package:meal_planner/features/auth/screens/auth_screen.dart';
import 'package:meal_planner/features/auth/services/auth_service.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthService extends StateNotifier<AsyncValue<UserModel?>>
    with Mock
    implements AuthService {
  MockAuthService() : super(const AsyncValue.data(null));
}

void main() {
  late MockAuthService mockAuthService;
  late ProviderContainer container;

  setUp(() {
    mockAuthService = MockAuthService();
    container = ProviderContainer(
      overrides: [
        authServiceProvider.overrideWith((_) => mockAuthService),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  testWidgets('shows sign in form by default', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authServiceProvider.overrideWith((_) => mockAuthService),
        ],
        child: const MaterialApp(
          home: AuthScreen(),
        ),
      ),
    );

    expect(find.text('Welcome Back'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
    expect(find.text('Don\'t have an account? Sign Up'), findsOneWidget);
  });

  testWidgets('switches to sign up form when link is tapped', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authServiceProvider.overrideWith((_) => mockAuthService),
        ],
        child: const MaterialApp(
          home: AuthScreen(),
        ),
      ),
    );

    await tester.tap(find.text('Don\'t have an account? Sign Up'));
    await tester.pumpAndSettle();

    expect(find.text('Create Account'), findsOneWidget);
    expect(find.text('Sign Up'), findsOneWidget);
    expect(find.text('Already have an account? Sign In'), findsOneWidget);
  });

  testWidgets('shows validation errors for empty fields', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authServiceProvider.overrideWith((_) => mockAuthService),
        ],
        child: const MaterialApp(
          home: AuthScreen(),
        ),
      ),
    );

    // Try to submit without filling fields
    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();

    expect(find.text('Please enter your email'), findsOneWidget);
    expect(find.text('Please enter your password'), findsOneWidget);
  });

  testWidgets('shows validation error for invalid email', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authServiceProvider.overrideWith((_) => mockAuthService),
        ],
        child: const MaterialApp(
          home: AuthScreen(),
        ),
      ),
    );

    // Enter invalid email
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email'),
      'invalid-email',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'password123',
    );

    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();

    expect(find.text('Please enter a valid email'), findsOneWidget);
  });

  testWidgets('shows validation error for short password', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authServiceProvider.overrideWith((_) => mockAuthService),
        ],
        child: const MaterialApp(
          home: AuthScreen(),
        ),
      ),
    );

    // Enter valid email but short password
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email'),
      'test@example.com',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      '12345',
    );

    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();

    expect(find.text('Password must be at least 6 characters'), findsOneWidget);
  });

  testWidgets('calls sign in when form is valid', (tester) async {
    when(() => mockAuthService.signInWithEmail(
          email: any(named: 'email'),
          password: any(named: 'password'),
        )).thenAnswer((_) async => UserModel(
          id: 'test-id',
          email: 'test@example.com',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authServiceProvider.overrideWith((_) => mockAuthService),
        ],
        child: const MaterialApp(
          home: AuthScreen(),
        ),
      ),
    );

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Email'),
      'test@example.com',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Password'),
      'password123',
    );

    await tester.tap(find.text('Sign In'));
    await tester.pumpAndSettle();

    verify(() => mockAuthService.signInWithEmail(
          email: 'test@example.com',
          password: 'password123',
        )).called(1);
  });
}
