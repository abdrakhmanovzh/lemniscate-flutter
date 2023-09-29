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
      return result as List<PostModel>;
    } on Exception catch (e) {
      return Future.error(e);
    }
  }
}
