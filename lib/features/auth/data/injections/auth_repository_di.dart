import 'package:lemniscate_flutter/features/auth/data/injections/auth_provider_di.dart';
import 'package:lemniscate_flutter/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:lemniscate_flutter/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryInject {
  static AuthRepository? _authRepository;

  AuthRepositoryInject._();

  static AuthRepository? authRepository() {
    return _authRepository ??= AuthRepositoryImpl(
      authProvider: AuthProviderInject.authProvider()!,
    );
  }
}
