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

  @override
  Future<bool> updateAvatar(String avatar, String userName) async {
    try {
      final result = await profileProvider.updateAvatar(avatar, userName);
      return result;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> followUser(String from, String to) async {
    try {
      final result = await profileProvider.followUser(from, to);
      return result;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> unfollowUser(String from, String to) async {
    try {
      final result = await profileProvider.unfollowUser(from, to);
      return result;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<String>> getFollowers(String from) async {
    try {
      final result = await profileProvider.getFollowers(from);
      return result;
    } catch (e) {
      return [];
    }
  }
}
