import 'package:lemniscate_flutter/features/auth/data/providers/auth_provider.dart';
import 'package:lemniscate_flutter/features/auth/domain/repositories/auth_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthProvider authProvider;

  AuthRepositoryImpl({required this.authProvider});

  @override
  Future<AuthResponse> login(String email, String password) async {
    return await authProvider.login(email, password);
  }

  @override
  Future<AuthResponse> register(String email, String password, String avatar) async {
    return await authProvider.register(email, password, avatar);
  }

  @override
  getUser() {
    return authProvider.getUser();
  }

  @override
  Future<void> logout() async {
    await authProvider.logout();
  }
}
