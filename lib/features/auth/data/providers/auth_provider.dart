import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthProvider {
  Future<AuthResponse> login(String email, String password);

  Future<AuthResponse> register(String email, String password, String avatar);

  getUser();

  Future<void> logout();
}
