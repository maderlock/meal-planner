import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meal_planner/core/storage/storage_service.dart';
import 'package:meal_planner/features/auth/models/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_service.g.dart';

class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => message;
}

@riverpod
class AuthService extends _$AuthService {
  late final FirebaseAuth _auth = FirebaseAuth.instance;
  late final GoogleSignIn _googleSignIn = GoogleSignIn();
  late final StorageService _storage = StorageService();

  @override
  Future<UserModel?> build() async {
    // Listen to auth state changes
    _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        state = AsyncData(UserModel.fromFirebase(user.toJson()));
      } else {
        state = const AsyncData(null);
      }
    });

    // Return current user if exists
    final user = _auth.currentUser;
    if (user != null) {
      return UserModel.fromFirebase(user.toJson());
    }
    return null;
  }

  Future<UserModel> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user == null) {
        throw AuthException('Failed to create user');
      }

      final user = UserModel.fromFirebase(result.user!.toJson());
      state = AsyncData(user);
      return user;
    } on FirebaseAuthException catch (e) {
      throw AuthException(_getErrorMessage(e));
    }
  }

  Future<UserModel> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user == null) {
        throw AuthException('Failed to sign in');
      }

      final user = UserModel.fromFirebase(result.user!.toJson());
      state = AsyncData(user);
      return user;
    } on FirebaseAuthException catch (e) {
      throw AuthException(_getErrorMessage(e));
    }
  }

  Future<UserModel> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        throw AuthException('Google sign in cancelled');
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final result = await _auth.signInWithCredential(credential);
      if (result.user == null) {
        throw AuthException('Failed to sign in with Google');
      }

      final user = UserModel.fromFirebase(result.user!.toJson());
      state = AsyncData(user);
      return user;
    } on FirebaseAuthException catch (e) {
      throw AuthException(_getErrorMessage(e));
    } catch (e) {
      throw AuthException('Failed to sign in with Google: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
      state = const AsyncData(null);
    } catch (e) {
      throw AuthException('Failed to sign out: $e');
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AuthException(_getErrorMessage(e));
    }
  }

  Future<void> updateProfile({
    String? displayName,
    String? photoUrl,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        throw AuthException('No user signed in');
      }

      await user.updateDisplayName(displayName);
      await user.updatePhotoURL(photoUrl);

      state = AsyncData(UserModel.fromFirebase(user.toJson()));
    } on FirebaseAuthException catch (e) {
      throw AuthException(_getErrorMessage(e));
    }
  }

  String _getErrorMessage(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Wrong password provided.';
      case 'email-already-in-use':
        return 'The email address is already in use.';
      case 'invalid-email':
        return 'The email address is invalid.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      case 'weak-password':
        return 'The password is too weak.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'invalid-credential':
        return 'The credentials are invalid.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with the same email address.';
      default:
        return 'An error occurred: ${e.message}';
    }
  }
}
