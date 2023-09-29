import 'package:supabase_flutter/supabase_flutter.dart';

class GetPostImage {
  static getPostImage(String name) {
    final imageUrl = Supabase.instance.client.storage.from('images').getPublicUrl(name);
    return imageUrl;
  }
}
