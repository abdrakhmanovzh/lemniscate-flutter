import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lemniscate_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

abstract class AuthCubit extends Cubit<AuthState> {
  AuthCubit(super.state);

  Future<void> login(String email, String password);

  Future<void> register(String email, String password);

  Future<void> getSession();

  Future<void> logout();
}

class AuthCubitImpl extends AuthCubit {
  final AuthRepository authRepository;

  AuthCubitImpl({required this.authRepository}) : super(AuthInitial());

  @override
  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      await authRepository.login(email, password);
      emit(const AuthSuccess());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  @override
  Future<void> register(String email, String password) async {
    emit(AuthLoading());
    try {
      await authRepository.register(email, password);
      await authRepository.login(email, password);
      emit(const AuthSuccess());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  @override
  Future<void> getSession() async {
    emit(AuthLoading());
    try {
      final user = await authRepository.getSession();
      emit(AuthSuccess(
        user: user,
      ));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  @override
  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await authRepository.logout();
      emit(const AuthSuccess());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}
