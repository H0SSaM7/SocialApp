part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class LoadUserEvent extends UserEvent {
  @override
  List<Object?> get props => [];
}

class LoadedUserEvent extends UserEvent {
  final UserModel? user;
  const LoadedUserEvent(this.user);

  @override
  List<Object?> get props => [user];
}

class LoadedUserPostsEvent extends UserEvent {
  @override
  List<Object?> get props => [];
}
