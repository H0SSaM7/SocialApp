part of 'posts_bloc.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();
  @override
  List<Object?> get props => [];
}

class LoadPostsEvent extends PostsEvent {}

class UpdatePostsEvent extends PostsEvent {
  final List<PostsModel> posts;
  final List<String> postsId;
  const UpdatePostsEvent({this.postsId = const [], this.posts = const []});

  @override
  List<Object?> get props => [posts, postsId];
}

class LikePostEvent extends PostsEvent {
  final String postId;
  final List likes;

  const LikePostEvent(this.postId, this.likes);
  @override
  List<Object?> get props => [postId, likes];
}
