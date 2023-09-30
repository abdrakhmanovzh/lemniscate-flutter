import 'package:lemniscate_flutter/features/profile/data/providers/profile_provider.dart';
import 'package:lemniscate_flutter/features/profile/data/providers/profile_provider_impl.dart';

class ProfileProvideInject {
  static ProfileProvider? _profileProvider;

  ProfileProvideInject._();

  static ProfileProvider? profileProvider() {
    return _profileProvider ??= ProfileProviderImpl();
  }
}
