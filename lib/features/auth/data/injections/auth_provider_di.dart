import 'package:lemniscate_flutter/features/auth/data/providers/auth_provider.dart';
import 'package:lemniscate_flutter/features/auth/data/providers/auth_provider_impl.dart';

class AuthProviderInject {
  static AuthProvider? _authProvider;

  AuthProviderInject._();

  static AuthProvider? authProvider() {
    return _authProvider ??= AuthProviderImpl();
  }
}
