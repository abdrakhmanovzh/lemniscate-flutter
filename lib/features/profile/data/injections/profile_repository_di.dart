import 'package:lemniscate_flutter/features/profile/data/injections/profile_provider_di.dart';
import 'package:lemniscate_flutter/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:lemniscate_flutter/features/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryInject {
  static ProfileRepository? _profileRepository;

  ProfileRepositoryInject._();

  static ProfileRepository profileRepository() {
    return _profileRepository ??= ProfileRepositoryImpl(
      profileProvider: ProfileProvideInject.profileProvider()!,
    );
  }
}
