import 'package:lemniscate_flutter/features/post/domain/entities/post_model.dart';

abstract class PostRepository {
  Future<List<PostModel>> getPosts();
  Future<bool> createPost(PostModel post);
  Future<bool> likePost(String postId, String userId);
  Future<List<PostModel>> getLikedPosts(String userId);
  // Future<void> deletePost(int id);
}
