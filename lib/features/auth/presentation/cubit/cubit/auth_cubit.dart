import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iti_training/features/auth/data/repo/auth_repo.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(AuthInitial());

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      await _authRepository.registerWithEmail(
        name: name,
        email: email,
        password: password,
      );

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(_getErrorMessage(e.code)));
    } catch (_) {
      emit(
        AuthError(
          'Something went wrong. Please try again.',
        ),
      );
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      await _authRepository.loginWithEmail(
        email: email,
        password: password,
      );

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(_getErrorMessage(e.code)));
    } catch (_) {
      emit(
        AuthError(
          'Something went wrong. Please try again.',
        ),
      );
    }
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());

    try {
      final result = await _authRepository.signInWithGoogle();

      if (result == null) {
        emit(AuthInitial());
        return;
      }

      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      debugPrint('Firebase Auth Error: ${e.code}');
      debugPrint('Firebase Auth Message: ${e.message}');
      emit(AuthError(_getErrorMessage(e.code)));
    } catch (e) {
      debugPrint('Google Sign-In Error: $e');
      emit(
        AuthError(
          e.toString(),
        ),
      );
    }
  }

  Future<void> signOut() async {
    emit(AuthLoading());
    try {
      await _authRepository.signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthError('Failed to sign out. Please try again.'));
    }
  }

  String _getErrorMessage(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'weak-password':
        return 'Password is too weak.';
      case 'user-not-found':
        return 'No account found with this email.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Invalid email or password.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many attempts. Please try again later.';
      case 'network-request-failed':
        return 'Please check your internet connection.';
      case 'operation-not-allowed':
        return 'This authentication method is not enabled.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }
}