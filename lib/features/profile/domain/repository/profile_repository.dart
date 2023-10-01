abstract class ProfileRepository {
  Future<void> updateBio(String bio, String userId);
  Future<void> updateAvatar(String avatar, String userName);
  Future<List<String>> getFollowers(String from);
  Future<void> followUser(String from, String to);
  Future<void> unfollowUser(String from, String to);
}
