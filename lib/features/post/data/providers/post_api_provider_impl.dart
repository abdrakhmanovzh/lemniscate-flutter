import 'package:lemniscate_flutter/features/post/data/providers/post_api_provider.dart';
import 'package:lemniscate_flutter/features/post/domain/entities/post_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PostApiProviderImpl implements PostApiProvider {
  @override
  Future<List<dynamic>> getPosts() async {
    try {
      final response = await Supabase.instance.client.from('posts').select() as List<dynamic>?;
      if (response?.isNotEmpty ?? false) {
        return response?.map((e) => PostModel.fromJson(e as Map<String, dynamic>)).toList() ?? [];
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
