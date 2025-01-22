import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meal_planner/features/auth/models/user_model.dart';
import 'package:meal_planner/features/auth/services/auth_service.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  bool _shouldThrowError = false;

  void setThrowError(bool shouldThrow) {
    _shouldThrowError = shouldThrow;
  }

  @override
  Stream<User?> authStateChanges() {
    return Stream.fromIterable([]);  // Empty stream to maintain loading state
  }

  @override
  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (_shouldThrowError) {
      throw FirebaseAuthException(code: 'error');
    }
    return MockUserCredential();
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    if (_shouldThrowError) {
      throw FirebaseAuthException(code: 'error');
    }
    return MockUserCredential();
  }

  @override
  Future<UserCredential> signInWithCredential(AuthCredential credential) async {
    if (_shouldThrowError) {
      throw FirebaseAuthException(code: 'error');
    }
    return MockUserCredential();
  }
}

class MockUserCredential extends Mock implements UserCredential {
  @override
  User? get user => MockUser();
}

class MockUser extends Mock implements User {
  @override
  String get uid => 'test-uid';
  
  @override
  String? get email => 'test@example.com';
  
  @override
  String? get displayName => 'Test User';
  
  @override
  String? get photoURL => null;
  
  @override
  bool get emailVerified => true;
}

class MockGoogleSignIn extends Mock implements GoogleSignIn {
  @override
  Future<GoogleSignInAccount?> signIn() async => MockGoogleSignInAccount();
}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {
  @override
  Future<GoogleSignInAuthentication> get authentication async => MockGoogleSignInAuthentication();
}

class MockGoogleSignInAuthentication extends Mock implements GoogleSignInAuthentication {
  @override
  String get accessToken => 'access-token';
  
  @override
  String get idToken => 'id-token';
}

class MockAuthCredential extends Mock implements AuthCredential {}

class TestAuthService extends AuthService {
  TestAuthService({
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
  }) : super(
          firebaseAuth: firebaseAuth,
          googleSignIn: googleSignIn,
        );

  @override
  AsyncValue<UserModel?> get debugState => state;
}

void main() {
  setUpAll(() {
    registerFallbackValue(MockGoogleSignInAccount());
    registerFallbackValue(MockGoogleSignInAuthentication());
    registerFallbackValue(MockUserCredential());
    registerFallbackValue(MockUser());
    registerFallbackValue(MockAuthCredential());
  });

  late MockFirebaseAuth mockFirebaseAuth;
  late MockGoogleSignIn mockGoogleSignIn;
  late TestAuthService authService;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockGoogleSignIn = MockGoogleSignIn();
    authService = TestAuthService(
      firebaseAuth: mockFirebaseAuth,
      googleSignIn: mockGoogleSignIn,
    );
  });

  test('initial state is loading', () {
    expect(authService.debugState, isA<AsyncLoading>());
  });

  group('signUpWithEmail', () {
    test('signUpWithEmail successfully creates new user', () async {
      mockFirebaseAuth.setThrowError(false);
      final user = await authService.signUpWithEmail(
        email: 'test@example.com',
        password: 'password123',
      );

      expect(user.email, equals('test@example.com'));
      expect(user.id, equals('test-uid'));
    });

    test('throws exception when user creation fails', () async {
      mockFirebaseAuth.setThrowError(true);
      expect(
        () => authService.signUpWithEmail(
          email: 'test@example.com',
          password: 'password123',
        ),
        throwsA(isA<AuthException>()),
      );
    });
  });

  group('signInWithEmail', () {
    test('signInWithEmail successfully signs in user', () async {
      mockFirebaseAuth.setThrowError(false);
      final user = await authService.signInWithEmail(
        email: 'test@example.com',
        password: 'password123',
      );

      expect(user.email, equals('test@example.com'));
      expect(user.id, equals('test-uid'));
    });

    test('throws exception when sign in fails', () async {
      mockFirebaseAuth.setThrowError(true);
      expect(
        () => authService.signInWithEmail(
          email: 'test@example.com',
          password: 'password123',
        ),
        throwsA(isA<AuthException>()),
      );
    });
  });

  group('signInWithGoogle', () {
    test('signInWithGoogle successfully signs in with Google', () async {
      mockFirebaseAuth.setThrowError(false);
      final user = await authService.signInWithGoogle();

      expect(user.email, equals('test@example.com'));
      expect(user.id, equals('test-uid'));
      expect(user.displayName, equals('Test User'));
      expect(user.photoUrl, isNull);
      expect(user.emailVerified, isTrue);
    });
  });
}
