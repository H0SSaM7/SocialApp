part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();
}

class PostsInitial extends PostsState {
  @override
  List<Object> get props => [];
}

class GetPostsSuccessState extends PostsState {
  final List<PostsModel> postsModel;
  final List postsId;
  const GetPostsSuccessState(
      {this.postsModel = const <PostsModel>[], required this.postsId});
  @override
  List<Object?> get props => [postsModel, postsId];
}

class GetPostErrorState extends PostsState {
  final String error;
  const GetPostErrorState(this.error);
  @override
  List<Object?> get props => [error];
}
