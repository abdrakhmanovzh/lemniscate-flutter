import 'package:supabase_flutter/supabase_flutter.dart';

class GetUserAvatar {
  static String getAvatar(String name) {
    final avatarUrl = '${Supabase.instance.client.storage.from('avatars').getPublicUrl(name)}?t=${DateTime.now()}';
    return avatarUrl;
  }
}
