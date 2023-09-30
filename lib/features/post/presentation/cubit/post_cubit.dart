import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lemniscate_flutter/features/post/domain/entities/post_model.dart';
import 'package:lemniscate_flutter/features/post/domain/repositories/post_repository.dart';

part 'post_state.dart';

abstract class PostCubit extends Cubit<PostState> {
  PostCubit(super.state);

  Future<void> getPosts();
  Future<void> createPost(PostModel post);
  Future<void> likePost(String postId, String userId);
  Future<void> getLikedPosts(String userId);
}

class PostCubitImpl extends PostCubit {
  final PostRepository repository;

  List<PostModel> posts = [];

  PostCubitImpl({required this.repository}) : super(PostInitial());

  PostLoaded getPostLoadedState() {
    if (state is PostLoaded) {
      return state as PostLoaded;
    }

    return PostLoaded(posts: posts);
  }

  @override
  Future<void> getPosts() async {
    try {
      emit(PostLoading());
      posts = await repository.getPosts();
      final state = getPostLoadedState();

      emit(
        state.copyWith(posts: posts),
      );
    } catch (e) {
      emit(PostError(message: e.toString()));
    }
  }

  @override
  Future<void> createPost(PostModel post) async {
    try {
      emit(PostLoading());
      await repository.createPost(post);
      emit(PostCreated());
    } catch (e) {
      emit(PostError(message: e.toString()));
    }
  }

  @override
  Future<void> likePost(String postId, String userId) async {
    try {
      await repository.likePost(postId, userId);
    } catch (e) {
      emit(PostError(message: e.toString()));
    }
  }

  @override
  Future<void> getLikedPosts(String userId) async {
    try {
      emit(PostLoading());
      posts = await repository.getLikedPosts(userId);
      final state = getPostLoadedState();
      emit(
        state.copyWith(posts: posts),
      );
    } catch (e) {
      emit(PostError(message: e.toString()));
    }
  }
}
