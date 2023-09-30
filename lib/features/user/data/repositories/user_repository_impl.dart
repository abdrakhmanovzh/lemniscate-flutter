import 'package:lemniscate_flutter/features/user/data/providers/user_api_provider.dart';
import 'package:lemniscate_flutter/features/user/domain/entities/user_model.dart';
import 'package:lemniscate_flutter/features/user/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserApiProvider userApiProvider;

  UserRepositoryImpl({required this.userApiProvider});

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final result = await userApiProvider.getUsers();
      if (result.isNotEmpty) {
        return result as List<UserModel>;
      } else {
        return [];
      }
    } on Exception catch (e) {
      return Future.error(e);
    }
  }
}
