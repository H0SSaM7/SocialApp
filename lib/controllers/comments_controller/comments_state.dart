part of 'comments_bloc.dart';

abstract class CommentsState extends Equatable {
  const CommentsState();
}

class CommentsLoadingState extends CommentsState {
  @override
  List<Object> get props => [];
}

class CommentsLoadedState extends CommentsState {
  final List<CommentModel> comments;

  const CommentsLoadedState(this.comments);
  @override
  List<Object> get props => [comments];
}

class CommentsLoadedErrorState extends CommentsState {
  @override
  List<Object> get props => [];
}
