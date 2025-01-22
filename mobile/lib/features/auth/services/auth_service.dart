import 'dart:developer' as developer;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meal_planner/features/auth/models/user_model.dart';

final authServiceProvider =
    StateNotifierProvider<AuthService, AsyncValue<UserModel?>>((ref) {
  return AuthService(
    firebaseAuth: FirebaseAuth.instance,
    googleSignIn: GoogleSignIn(
      scopes: [
        'email',
        'profile',
        'openid',
      ],
    ),
  );
});

class AuthException implements Exception {
  final String message;
  final dynamic originalError;
  final StackTrace? stackTrace;
  final bool isEmailInUse;
  final bool isGoogleAccount;

  AuthException(
    this.message, {
    this.originalError,
    this.stackTrace,
    this.isEmailInUse = false,
    this.isGoogleAccount = false,
  }) {
    developer.log(
      'AuthException: $message',
      error: originalError,
      stackTrace: stackTrace,
      name: 'AuthService',
    );
  }

  @override
  String toString() => message;
}

class AuthService extends StateNotifier<AsyncValue<UserModel?>> {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthService({
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
  })  : _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn,
        super(const AsyncValue.loading()) {
    _init();
  }

  void _init() {
    _firebaseAuth.authStateChanges().listen((User? user) {
      if (user != null) {
        developer.log(
          'Auth state changed: User logged in',
          name: 'AuthService',
          error: {
            'uid': user.uid,
            'email': user.email,
            'displayName': user.displayName,
          },
        );
        state = AsyncValue.data(_userFromFirebase(user));
      } else {
        developer.log(
          'Auth state changed: User logged out',
          name: 'AuthService',
        );
        state = const AsyncValue.data(null);
      }
    });
  }

  UserModel? _userFromFirebase(User? user) {
    if (user == null) return null;
    
    return UserModel(
      id: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
      photoUrl: user.photoURL,
      emailVerified: user.emailVerified,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      developer.log(
        'Starting email sign up',
        name: 'AuthService',
        error: {'email': email},
      );

      // First check if the email is already associated with a Google account
      final signInMethods = await _firebaseAuth.fetchSignInMethodsForEmail(email);
      if (signInMethods.contains('google.com')) {
        throw AuthException(
          'This email is already associated with a Google account. Please sign in with Google.',
          isGoogleAccount: true,
        );
      }

      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        throw AuthException('Failed to create user account');
      }

      final userModel = UserModel(
        id: user.uid,
        email: user.email ?? '',
        displayName: user.displayName,
        photoUrl: user.photoURL,
        emailVerified: user.emailVerified,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      state = AsyncValue.data(userModel);
      return userModel;
    } on FirebaseAuthException catch (e, stackTrace) {
      developer.log(
        'Firebase Auth Exception during sign up',
        error: e,
        stackTrace: stackTrace,
        name: 'AuthService',
      );

      if (e.code == 'email-already-in-use') {
        throw AuthException(
          'An account already exists with this email. Please try logging in instead.',
          originalError: e,
          stackTrace: stackTrace,
          isEmailInUse: true,
        );
      }

      throw AuthException(
        _getErrorMessage(e.code),
        originalError: e,
        stackTrace: stackTrace,
      );
    } catch (e, stackTrace) {
      if (e is AuthException) {
        rethrow;
      }
      developer.log(
        'Error during sign up with email',
        error: e,
        stackTrace: stackTrace,
        name: 'AuthService',
      );
      throw AuthException(
        'Failed to create account: ${e.toString()}',
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      developer.log(
        'Starting email sign in',
        name: 'AuthService',
        error: {'email': email},
      );

      try {
        final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        final user = userCredential.user;
        if (user == null) {
          throw AuthException('Failed to sign in');
        }

        final userModel = UserModel(
          id: user.uid,
          email: user.email ?? '',
          displayName: user.displayName,
          photoUrl: user.photoURL,
          emailVerified: user.emailVerified,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

        state = AsyncValue.data(userModel);
        return userModel;
      } on FirebaseAuthException catch (e, stackTrace) {
        if (e.code == 'user-not-found' || e.code == 'wrong-password') {
          // Check if this email is associated with a Google account
          final signInMethods = await _firebaseAuth.fetchSignInMethodsForEmail(email);
          if (signInMethods.contains('google.com')) {
            throw AuthException(
              'This email is associated with a Google account. Please sign in with Google.',
              originalError: e,
              stackTrace: stackTrace,
              isGoogleAccount: true,
            );
          }
        }
        rethrow;
      }
    } on FirebaseAuthException catch (e, stackTrace) {
      developer.log(
        'Firebase Auth Exception during sign in',
        error: e,
        stackTrace: stackTrace,
        name: 'AuthService',
      );
      throw AuthException(
        _getErrorMessage(e.code),
        originalError: e,
        stackTrace: stackTrace,
      );
    } catch (e, stackTrace) {
      if (e is AuthException) {
        rethrow;
      }
      developer.log(
        'Error during sign in with email',
        error: e,
        stackTrace: stackTrace,
        name: 'AuthService',
      );
      throw AuthException(
        'Failed to sign in: ${e.toString()}',
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  Future<UserModel> signInWithGoogle() async {
    try {
      developer.log(
        'Starting Google Sign In process',
        name: 'AuthService',
      );

      // Sign out first to ensure a fresh sign-in
      await signOut();

      // Start fresh Google sign in
      final googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        developer.log(
          'Google Sign In cancelled by user',
          name: 'AuthService',
        );
        throw AuthException('Google sign in was cancelled');
      }

      developer.log(
        'Google Sign In successful, getting authentication',
        name: 'AuthService',
        error: {
          'email': googleUser.email,
          'displayName': googleUser.displayName,
        },
      );

      try {
        // Get auth details from Google Sign in
        final googleAuth = await googleUser.authentication;
        
        developer.log(
          'Got Google authentication tokens',
          name: 'AuthService',
          error: {
            'hasAccessToken': googleAuth.accessToken != null,
            'hasIdToken': googleAuth.idToken != null,
          },
        );

        if (googleAuth.accessToken == null) {
          throw AuthException('Failed to get Google access token');
        }

        if (googleAuth.idToken == null) {
          throw AuthException('Failed to get Google ID token');
        }

        try {
          developer.log(
            'Creating Firebase auth provider',
            name: 'AuthService',
          );

          // Create auth provider
          final googleAuthProvider = GoogleAuthProvider();
          googleAuthProvider.setCustomParameters({
            'login_hint': googleUser.email,
          });
          
          // Add ID token to provider
          googleAuthProvider.addScope('email');
          googleAuthProvider.addScope('profile');

          developer.log(
            'Signing in to Firebase with provider',
            name: 'AuthService',
          );

          // Sign in to Firebase with provider
          final userCredential = await _firebaseAuth.signInWithProvider(googleAuthProvider);
          final user = userCredential.user;
          
          if (user == null) {
            developer.log(
              'Firebase sign in failed - no user returned',
              name: 'AuthService',
            );
            throw AuthException('Failed to sign in with Google');
          }
          
          developer.log(
            'Firebase sign in successful',
            name: 'AuthService',
            error: {
              'uid': user.uid,
              'email': user.email,
              'displayName': user.displayName,
            },
          );

          final userModel = UserModel(
            id: user.uid,
            email: user.email ?? '',
            displayName: user.displayName ?? googleUser.displayName ?? '',
            photoUrl: user.photoURL ?? googleUser.photoUrl ?? '',
            emailVerified: user.emailVerified,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          );
          
          state = AsyncValue.data(userModel);
          return userModel;
        } on FirebaseAuthException catch (e, stackTrace) {
          developer.log(
            'Firebase Auth Exception',
            error: e,
            stackTrace: stackTrace,
            name: 'AuthService',
          );
          throw AuthException(
            _getErrorMessage(e.code),
            originalError: e,
            stackTrace: stackTrace,
          );
        }
      } catch (e, stackTrace) {
        developer.log(
          'Error in Google authentication process',
          error: e,
          stackTrace: stackTrace,
          name: 'AuthService',
        );
        throw AuthException(
          'Failed to get Google authentication: ${e.toString()}',
          originalError: e,
          stackTrace: stackTrace,
        );
      }
    } catch (e, stackTrace) {
      if (e is AuthException) {
        rethrow;
      }
      developer.log(
        'Unexpected error during Google Sign In',
        error: e,
        stackTrace: stackTrace,
        name: 'AuthService',
      );
      throw AuthException(
        'Google sign in failed: ${e.toString()}',
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> signOut() async {
    try {
      developer.log(
        'Starting sign out process',
        name: 'AuthService',
      );

      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);

      developer.log(
        'Sign out successful',
        name: 'AuthService',
      );

      state = const AsyncValue.data(null);
    } on FirebaseAuthException catch (e, stackTrace) {
      developer.log(
        'Firebase Auth Exception during sign out',
        error: e,
        stackTrace: stackTrace,
        name: 'AuthService',
      );
      throw AuthException(
        _getErrorMessage(e.code),
        originalError: e,
        stackTrace: stackTrace,
      );
    } catch (e, stackTrace) {
      developer.log(
        'Error during sign out',
        error: e,
        stackTrace: stackTrace,
        name: 'AuthService',
      );
      throw AuthException(
        'Failed to sign out: ${e.toString()}',
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      developer.log(
        'Sending password reset email',
        name: 'AuthService',
        error: {
          'email': email,
        },
      );

      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e, stackTrace) {
      developer.log(
        'Firebase Auth Exception during password reset email',
        error: e,
        stackTrace: stackTrace,
        name: 'AuthService',
      );
      throw AuthException(
        _getErrorMessage(e.code),
        originalError: e,
        stackTrace: stackTrace,
      );
    } catch (e, stackTrace) {
      developer.log(
        'Error during password reset email',
        error: e,
        stackTrace: stackTrace,
        name: 'AuthService',
      );
      throw AuthException(
        'Failed to send password reset email: ${e.toString()}',
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> updateProfile({String? displayName, String? photoUrl}) async {
    try {
      developer.log(
        'Updating profile',
        name: 'AuthService',
        error: {
          'displayName': displayName,
          'photoUrl': photoUrl,
        },
      );

      await _firebaseAuth.currentUser?.updateDisplayName(displayName);
      await _firebaseAuth.currentUser?.updatePhotoURL(photoUrl);
      
      state = AsyncValue.data(_userFromFirebase(_firebaseAuth.currentUser));
    } on FirebaseAuthException catch (e, stackTrace) {
      developer.log(
        'Firebase Auth Exception during profile update',
        error: e,
        stackTrace: stackTrace,
        name: 'AuthService',
      );
      throw AuthException(
        _getErrorMessage(e.code),
        originalError: e,
        stackTrace: stackTrace,
      );
    } catch (e, stackTrace) {
      developer.log(
        'Error during profile update',
        error: e,
        stackTrace: stackTrace,
        name: 'AuthService',
      );
      throw AuthException(
        'Failed to update profile: ${e.toString()}',
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'sign_in_canceled':
        return 'Sign in was canceled by the user.';
      case 'sign_in_failed':
        return 'Sign in failed. Please try again.';
      case 'network_error':
        return 'A network error occurred. Please check your connection.';
      case 'sign_in_required':
        return 'Please sign in to continue.';
      case 'invalid-credential':
        return 'The credential is malformed or has expired.';
      case 'operation-not-allowed':
        return 'Google sign-in is not enabled for this project.';
      case 'user-not-found':
        return 'No user found for the given credentials.';
      default:
        return 'An error occurred during sign in. Please try again.';
    }
  }
}
