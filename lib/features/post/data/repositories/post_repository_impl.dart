import 'package:lemniscate_flutter/features/post/data/providers/post_api_provider.dart';
import 'package:lemniscate_flutter/features/post/domain/entities/post_model.dart';
import 'package:lemniscate_flutter/features/post/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final PostApiProvider postApiProvider;

  PostRepositoryImpl({required this.postApiProvider});

  @override
  Future<List<PostModel>> getPosts() async {
    try {
      final result = await postApiProvider.getPosts();
      if (result.isNotEmpty) {
        return result as List<PostModel>;
      } else {
        return [];
      }
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<bool> createPost(PostModel post) async {
    final result = await postApiProvider.createPost(post);

    if (result) {
      return true;
    } else {
      return Future.error('error creating post');
    }
  }

  @override
  Future<bool> likePost(String postId, String userId) async {
    final result = await postApiProvider.likePost(postId, userId);

    if (result) {
      return true;
    } else {
      return Future.error('error liking post');
    }
  }
}
