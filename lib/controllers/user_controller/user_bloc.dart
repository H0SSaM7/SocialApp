import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_app/data/repository/user_repo/user_repository.dart';
import 'package:social_app/models/posts_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/utils/consistent/consistent.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  StreamSubscription? _userSubscription;
  UserModel? _user;
  UserModel get user => _user!;
  UserBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(UserLoadingState()) {
    on<LoadUserEvent>(_loadUser);

    on<LoadedUserEvent>(_loadedUser);
    on<LoadedUserPostsEvent>(_loadUserPosts);
  }

  FutureOr<void> _loadUser(LoadUserEvent event, Emitter<UserState> emit) {
    _userSubscription?.cancel();
    _userSubscription =
        _userRepository.getUserData(userId: currentUserId).listen((event) {
      add(LoadedUserEvent(event));
    });
  }

  FutureOr<void> _loadedUser(LoadedUserEvent event, Emitter<UserState> emit) {
    if (event.user != null) {
      _user = event.user!;
      emit(UserLoadedState(user: event.user!));
    } else {
      emit(const UserErrorState());
    }
  }

  FutureOr<void> _loadUserPosts(
      LoadedUserPostsEvent event, Emitter<UserState> emit) async {
    final state = this.state;
    if (state is UserLoadedState) {
      var _listOfPosts =
          await _userRepository.getUserPosts(postsId: state.user.posts!);
      emit(UserLoadedState(
        user: state.user,
        userPosts: _listOfPosts,
      ));
    }
  }
}
