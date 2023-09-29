import 'package:lemniscate_flutter/features/user/data/providers/user_api_provider.dart';
import 'package:lemniscate_flutter/features/user/data/providers/user_api_provider_impl.dart';

class UserApiProviderInject {
  static UserApiProvider? _userApiProvider;

  UserApiProviderInject._();

  static UserApiProvider? userApiProvider() {
    return _userApiProvider ??= UserApiProviderImpl();
  }
}
