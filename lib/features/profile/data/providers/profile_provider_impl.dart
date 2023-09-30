import 'package:lemniscate_flutter/features/profile/data/providers/profile_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileProviderImpl implements ProfileProvider {
  @override
  Future<bool> updateBio(String bio, String userId) async {
    try {
      await Supabase.instance.client.from('users').update({'bio': bio}).eq('id', userId);
      return true;
    } catch (e) {
      return false;
    }
  }
}
