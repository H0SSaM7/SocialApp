import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart' show debugPrint;
import 'package:social_app/data/repository/posts_repo/posts_repository.dart';
import 'package:social_app/models/posts_model.dart';
import 'package:tuple/tuple.dart';
part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostsRepository _postsRepository;
  StreamSubscription<Tuple2<List<PostsModel>, List<String>>>?
      _postsSubscription;

  PostsBloc(PostsRepository postsRepository)
      : _postsRepository = postsRepository,
        super(PostsInitial()) {
    on<LoadPostsEvent>(_loadPosts);
    on<UpdatePostsEvent>(_updatePost);
    on<LikePostEvent>(_likePost);
  }

  _loadPosts(event, Emitter<PostsState> emit) {
    _postsSubscription?.cancel();
    _postsSubscription = _postsRepository.getStreamPosts().listen((event) {
      add(
        UpdatePostsEvent(posts: event.item1, postsId: event.item2),
      );
    }, onError: ((err) {
      debugPrint(err.toString());
      emit(const GetPostErrorState('Something wrong happen try again later'));
    }));
  }

  _updatePost(UpdatePostsEvent event, emit) {
    emit(GetPostsSuccessState(postsId: event.postsId, postsModel: event.posts));
  }

  _likePost(LikePostEvent event, emit) async {
    await _postsRepository.addOrRemoveLike(
        postId: event.postId, likes: event.likes);
    add(LoadPostsEvent());
  }
}
