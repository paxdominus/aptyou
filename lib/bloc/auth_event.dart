part of 'auth_bloc.dart';

abstract class AuthEvent {}

class SignInWithGoogle extends AuthEvent {}

class FetchSampleAssets extends AuthEvent {
  final String accessToken;
  FetchSampleAssets(this.accessToken);
}
