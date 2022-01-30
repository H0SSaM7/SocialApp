import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_app/data/repository/posts_repo/posts_repository.dart';
import 'package:social_app/models/posts_model.dart';
part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepository _postsRepository;
  StreamSubscription? _postsSubscription;

  PostsBloc(PostsRepository postsRepository)
      : _postsRepository = postsRepository,
        super(PostsInitial()) {
    on<LoadPostsEvent>(_loadPosts);
    on<UpdatePostsEvent>(_updatePost);
  }

  _loadPosts(event, Emitter<PostsState> emit) {
    _postsSubscription?.cancel();
    _postsSubscription =
        _postsRepository.getStreamPosts().listen((event) => add(
              UpdatePostsEvent(posts: event.item1, postsId: event.item2),
            ));
  }

  _updatePost(UpdatePostsEvent event, emit) {
    emit(GetPostsSuccessState(postsId: event.postsId, postsModel: event.posts));
  }
}
