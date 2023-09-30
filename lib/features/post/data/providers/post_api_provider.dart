import 'package:lemniscate_flutter/features/post/domain/entities/post_model.dart';

abstract class PostApiProvider {
  Future<List<dynamic>> getPosts();
  Future<bool> createPost(PostModel post);
  Future<bool> likePost(String postId, String userId);
}
