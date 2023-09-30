abstract class UserApiProvider {
  Future<List<dynamic>> getUsers();
  Future<dynamic> getUser(String userId);
}
