import 'package:lemniscate_flutter/features/profile/data/providers/profile_provider.dart';
import 'package:lemniscate_flutter/features/profile/domain/repository/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileProvider profileProvider;

  ProfileRepositoryImpl({required this.profileProvider});

  @override
  Future<bool> updateBio(String bio, String userId) async {
    try {
      final result = await profileProvider.updateBio(bio, userId);
      return result;
    } catch (e) {
      return false;
    }
  }
}
