import 'package:lemniscate_flutter/core/services/supabase_service.dart';
import 'package:lemniscate_flutter/features/auth/data/providers/auth_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProviderImpl implements AuthProvider {
  @override
  Future<void> login(String email, String password) async {
    await SupabaseService.supabase.auth.signInWithPassword(email: email, password: password);
  }

  @override
  Future<void> register(String email, String password) async {
    await SupabaseService.supabase.auth.signUp(email: email, password: password);
  }

  @override
  Future<User> getSession() async {
    return SupabaseService.supabase.auth.currentSession!.user;
  }

  @override
  Future<void> logout() async {
    await SupabaseService.supabase.auth.signOut();
  }
}
