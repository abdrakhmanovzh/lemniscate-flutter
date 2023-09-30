import 'package:lemniscate_flutter/features/user/domain/entities/user_model.dart';

abstract class UserRepository {
  Future<List<UserModel>> getUsers();
  Future<UserModel> getUser(String userId);
}
