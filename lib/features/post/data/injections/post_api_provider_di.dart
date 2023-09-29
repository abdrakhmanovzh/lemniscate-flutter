import 'package:lemniscate_flutter/features/post/data/providers/post_api_provider.dart';
import 'package:lemniscate_flutter/features/post/data/providers/post_api_provider_impl.dart';

class PostApiProviderInject {
  static PostApiProvider? _postApiProvider;

  PostApiProviderInject._();

  static PostApiProvider? postApiProvider() {
    return _postApiProvider ??= PostApiProviderImpl();
  }
}
