import 'package:lemniscate_flutter/features/post/domain/entities/post_model.dart';

abstract class PostRepository {
  Future<List<PostModel>> getPosts();
  // Future<PostModel> getPost(int id);
  // Future<PostModel> createPost(PostModel post);
  // Future<PostModel> updatePost(PostModel post);
  // Future<void> deletePost(int id);
}
