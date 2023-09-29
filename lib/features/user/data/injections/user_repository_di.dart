import 'package:lemniscate_flutter/features/user/data/injections/user_api_provider_di.dart';
import 'package:lemniscate_flutter/features/user/data/repositories/user_repository_impl.dart';
import 'package:lemniscate_flutter/features/user/domain/repositories/user_repository.dart';

class UserRepositoryInject {
  static UserRepository? _userRepository;

  UserRepositoryInject._();

  static UserRepository? userRepository() {
    return _userRepository ??= UserRepositoryImpl(
      userApiProvider: UserApiProviderInject.userApiProvider()!,
    );
  }
}
