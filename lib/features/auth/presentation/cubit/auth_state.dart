part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class LoginInitialState extends AuthState {}

class LoginLoadingState extends AuthState {}

class LoginLoadedState extends AuthState {
  final AuthResponse authResponse;

  const LoginLoadedState({required this.authResponse});

  @override
  List<Object?> get props => [authResponse];
}

class LogoutState extends AuthState {}

class LoginErrorState extends AuthState {
  final String message;

  const LoginErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class RegisterInitialState extends AuthState {}

class RegisterLoadingState extends AuthState {}

class RegisterLoadedState extends AuthState {
  final AuthResponse authResponse;

  const RegisterLoadedState({required this.authResponse});

  @override
  List<Object?> get props => [authResponse];
}

class RegisterErrorState extends AuthState {
  final String message;

  const RegisterErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
