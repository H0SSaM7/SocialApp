part of 'comments_bloc.dart';

abstract class CommentsEvent extends Equatable {
  const CommentsEvent();
}

class CommentLoadEvent extends CommentsEvent {
  final String postId;

  const CommentLoadEvent(this.postId);
  @override
  List<Object?> get props => [postId];
}

class CommentUpdateEvent extends CommentsEvent {
  final List<CommentModel> comments;
  const CommentUpdateEvent({this.comments = const []});
  @override
  List<Object?> get props => [comments];
}
