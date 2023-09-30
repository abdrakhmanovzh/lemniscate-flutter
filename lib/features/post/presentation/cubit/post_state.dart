part of 'post_cubit.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object?> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<PostModel> posts;

  const PostLoaded({required this.posts});

  PostLoaded copyWith({List<PostModel>? posts}) {
    return PostLoaded(posts: posts ?? this.posts);
  }

  @override
  List<Object?> get props => [posts];
}

class PostCreated extends PostState {}

class PostLiked extends PostState {}

class PostError extends PostState {
  final String message;

  const PostError({required this.message});

  @override
  List<Object?> get props => [message];
}
