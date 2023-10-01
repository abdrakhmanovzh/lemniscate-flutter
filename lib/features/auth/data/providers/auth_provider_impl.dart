import 'dart:io';

import 'package:lemniscate_flutter/core/services/supabase_service.dart';
import 'package:lemniscate_flutter/features/auth/data/providers/auth_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProviderImpl implements AuthProvider {
  @override
  Future<AuthResponse> login(String email, String password) async {
    return await SupabaseService.supabase.auth.signInWithPassword(email: email, password: password);
  }

  @override
  Future<AuthResponse> register(String email, String password, String avatar) async {
    await SupabaseService.supabase.storage.from('avatars').upload(email, File(avatar));
    return await SupabaseService.supabase.auth.signUp(email: email, password: password);
  }

  @override
  getUser() {
    return SupabaseService.supabase.auth.currentUser;
  }

  @override
  Future<void> logout() async {
    await SupabaseService.supabase.auth.signOut();
  }
}
