import 'package:lemniscate_flutter/features/auth/data/providers/auth_provider.dart';
import 'package:lemniscate_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:lemniscate_flutter/features/user/domain/entities/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthProvider authProvider;

  AuthRepositoryImpl({required this.authProvider});

  @override
  Future<void> login(String email, String password) async {
    await authProvider.login(email, password);
  }

  @override
  Future<void> register(String email, String password) async {
    await authProvider.register(email, password);
  }

  @override
  Future<User> getSession() async {
    final user = await authProvider.getSession();
    return user;
  }

  @override
  Future<void> logout() async {
    await authProvider.logout();
  }
}
