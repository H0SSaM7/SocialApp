import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_app/data/repository/commets_repo/commets_repository.dart';
import 'package:social_app/models/comment_model.dart';

part 'comments_event.dart';
part 'comments_state.dart';

class CommentsBloc extends Bloc<CommentsEvent, CommentsState> {
  final CommentsRepository _commentsRepository;
  StreamSubscription? _commentsSubscription;
  int commentsLength = 0;
  CommentsBloc({required CommentsRepository commentsRepository})
      : _commentsRepository = commentsRepository,
        super(CommentsLoadingState()) {
    on<CommentLoadEvent>(_loadComments);
    on<CommentUpdateEvent>(_updateComments);
    on<CommentsAddEvent>(_appNewComment);
  }

  _loadComments(CommentLoadEvent event, emit) {
    _commentsSubscription?.cancel();
    _commentsSubscription =
        _commentsRepository.getComment(postId: event.postId)?.listen(
      (event) {
        add(
          CommentUpdateEvent(comments: event),
        );
      },
    );
  }

  _updateComments(CommentUpdateEvent event, emit) {
    commentsLength = event.comments.length;
    emit(CommentsLoadedState(event.comments));
  }

  FutureOr<void> _appNewComment(
      CommentsAddEvent event, Emitter<CommentsState> emit) async {
    await _commentsRepository.postNewComment(
      postId: event.postId,
      comment: event.comment,
      profileImage: event.profileImage,
      userName: event.userName,
    );
    add(CommentLoadEvent(event.postId));
  }
}
