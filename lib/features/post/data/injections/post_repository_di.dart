import 'package:lemniscate_flutter/features/post/data/injections/post_api_provider_di.dart';
import 'package:lemniscate_flutter/features/post/data/repositories/post_repository_impl.dart';
import 'package:lemniscate_flutter/features/post/domain/repositories/post_repository.dart';

class PostRepositoryInject {
  static PostRepository? _postRepository;

  PostRepositoryInject._();

  static PostRepository? postRepository() {
    return _postRepository ??= PostRepositoryImpl(
      postApiProvider: PostApiProviderInject.postApiProvider()!,
    );
  }
}
