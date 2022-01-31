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

class CommentsAddEvent extends CommentsEvent {
  final String postId;
  final String comment;
  final String profileImage;
  final String userName;
  const CommentsAddEvent(
      {required this.postId,
      required this.comment,
      required this.profileImage,
      required this.userName});

  @override
  List<Object?> get props => [postId, comment, profileImage, userName];
}
