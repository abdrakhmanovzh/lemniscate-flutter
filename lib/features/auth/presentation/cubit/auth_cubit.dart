import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lemniscate_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_state.dart';

abstract class AuthCubit extends Cubit<AuthState> {
  AuthCubit(super.state);

  Future<void> login(String email, String password);

  Future<void> register(String email, String password, String avatar);

  User getUser();

  Future logout();
}

class AuthCubitImpl extends AuthCubit {
  final AuthRepository authRepository;

  AuthCubitImpl({required this.authRepository}) : super(LoginInitialState());

  @override
  Future<void> login(String email, String password) async {
    emit(LoginLoadingState());
    try {
      final response = await authRepository.login(email, password);
      emit(
        LoginLoadedState(authResponse: response),
      );
    } catch (e) {
      emit(LoginErrorState(message: e.toString()));
    }
  }

  @override
  Future<void> register(String email, String password, String avatar) async {
    emit(RegisterLoadingState());
    try {
      await authRepository.register(email, password, avatar);
      final response = await authRepository.login(email, password);
      emit(
        LoginLoadedState(
          authResponse: response,
        ),
      );
    } catch (e) {
      emit(RegisterErrorState(message: e.toString()));
    }
  }

  @override
  User getUser() {
    return authRepository.getUser() as User;
  }

  @override
  Future logout() async {
    await authRepository.logout();
    emit(LogoutState());
  }
}
