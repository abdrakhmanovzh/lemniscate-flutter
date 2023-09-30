import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lemniscate_flutter/features/post/domain/entities/post_model.dart';
import 'package:lemniscate_flutter/features/post/domain/repositories/post_repository.dart';

part 'post_state.dart';

abstract class PostCubit extends Cubit<PostState> {
  PostCubit(super.state);

  Future<void> getPosts();
  Future<void> createPost(PostModel post);
}

class PostCubitImpl extends PostCubit {
  final PostRepository repository;

  PostCubitImpl({required this.repository}) : super(PostInitial());

  @override
  Future<void> getPosts() async {
    try {
      emit(PostLoading());
      final posts = await repository.getPosts();
      emit(PostLoaded(posts: posts));
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
}
