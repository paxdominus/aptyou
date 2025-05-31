part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final String accessToken;
  AuthSuccess(this.accessToken);
}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}

class AssetsLoading extends AuthState {}

class AssetsSuccess extends AuthState {
  final dynamic assets;
  AssetsSuccess(this.assets);
}

class AssetsFailure extends AuthState {
  final String error;
  AssetsFailure(this.error);
}
