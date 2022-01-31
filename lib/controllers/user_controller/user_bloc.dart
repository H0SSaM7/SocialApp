import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:social_app/data/repository/user_repo/user_repository.dart';
import 'package:social_app/models/user_model.dart';

part 'user_event.dart';

part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository _userRepository;
  StreamSubscription? _userSubscription;
  UserBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(UserLoadingState()) {
    on<LoadUserEvent>(_loadUser);

    on<LoadedUserEvent>(_loadedUser);
  }

  FutureOr<void> _loadUser(LoadUserEvent event, Emitter<UserState> emit) {
    _userSubscription?.cancel();
    _userSubscription = _userRepository.getUserData().listen((event) {
      add(LoadedUserEvent(event));
    });
  }

  FutureOr<void> _loadedUser(LoadedUserEvent event, Emitter<UserState> emit) {
    if (event.user != null) {
      emit(UserLoadedState(event.user!));
    } else {
      emit(const UserErrorState());
    }
  }
}