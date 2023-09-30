import 'package:lemniscate_flutter/features/user/data/providers/user_api_provider.dart';
import 'package:lemniscate_flutter/features/user/domain/entities/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserApiProviderImpl implements UserApiProvider {
  @override
  Future<List<dynamic>> getUsers() async {
    try {
      final response = await Supabase.instance.client.from('users').select() as List<dynamic>?;
      if (response?.isNotEmpty ?? false) {
        return response?.map((e) => UserModel.fromJson(e as Map<String, dynamic>)).toList() ?? [];
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<UserModel> getUser(String userId) async {
    try {
      final response = await Supabase.instance.client.from('users').select().eq('id', userId).single() as Map<String, dynamic>?;
      if (response != null) {
        return UserModel.fromJson(response);
      } else {
        throw Exception('user not found');
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
