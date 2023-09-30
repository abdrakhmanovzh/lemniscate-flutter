import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {
  Future<void> login(String email, String password);

  Future<void> register(String email, String password);

  Future<User> getSession();

  Future<void> logout();
}
