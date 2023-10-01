abstract class ProfileProvider {
  Future<bool> updateBio(String bio, String userId);
  Future<bool> updateAvatar(String avatar, String userName);
  Future<List<String>> getFollowers(String from);
  Future<bool> followUser(String from, String to);
  Future<bool> unfollowUser(String from, String to);
}
