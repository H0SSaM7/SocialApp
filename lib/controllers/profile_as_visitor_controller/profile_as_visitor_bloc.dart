import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_app/data/repository/user_repo/user_repository.dart';
import 'package:social_app/models/user_model.dart';

part 'profile_as_visitor_event.dart';
part 'profile_as_visitor_state.dart';

class ProfileAsVisitorBloc
    extends Bloc<ProfileAsVisitorEvent, ProfileAsVisitorState> {
  final UserRepository _userRepository;
  StreamSubscription<UserModel>? _profileSubscription;
  UserModel? user;
  ProfileAsVisitorBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(ProfileAsVisitorInitial()) {
    on<OnOpenProfileEvent>(_onOpenProfile);
    on<UpdateProfileEvent>(_updateProfile);
    on<OnFollowProfileEvent>(_followUser);
  }

  FutureOr<void> _onOpenProfile(
      OnOpenProfileEvent event, Emitter<ProfileAsVisitorState> emit) {
    _profileSubscription?.cancel();
    _profileSubscription =
        _userRepository.getUserData(userId: event.userId).listen((event) {
      add(
        UpdateProfileEvent(event),
      );
    });
  }

  FutureOr<void> _updateProfile(
      UpdateProfileEvent event, Emitter<ProfileAsVisitorState> emit) {
    user = event.user;
    emit(ProfileAsVisitorGetUserSuccess(event.user));
  }

  FutureOr<void> _followUser(
      OnFollowProfileEvent event, Emitter<ProfileAsVisitorState> emit) async {
    await _userRepository.followUser(
        userId: event.userId, userFollowers: event.userFollowers);
  }
}
