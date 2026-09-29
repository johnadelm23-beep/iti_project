import 'package:iti_training/features/auth/data/models/user_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}
class AuthUserLoaded extends AuthState {
  final UserModel user;

  AuthUserLoaded(this.user);
}
class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}