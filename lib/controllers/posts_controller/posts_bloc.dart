import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_app/data/repository/posts_repo/posts_repository.dart';
import 'package:social_app/models/posts_model.dart';
import 'package:tuple/tuple.dart';

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc(PostsRepository postsRepository)
      : _postsRepository = postsRepository,
        super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      await _postsRepository.getStreamPosts().listen((event) {
        List<PostsModel> posts = [];
        List<String> postsId = [];
        if (event.docs.isNotEmpty) {
          for (var element in event.docs) {
            postsId.add(element.id);
            posts.add(
              PostsModel.fromMap(
                element.data(),
              ),
            );
            emit(
              GetPostsSuccessState(posts, postsId),
            );
          }
        }
      }
          // if (tuple.item1.isNotEmpty && tuple.item2.isNotEmpty) {
          //   emit(GetPostsSuccessState(tuple.item1, tuple.item2));
          // } else {
          //   emit(
          //     const GetPostErrorState(
          //         'Error Loading Posts Please Try Again Latter'),
          //   );
          // }
          );
    });
  }

  final PostsRepository _postsRepository;
}
