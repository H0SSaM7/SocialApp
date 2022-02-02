part of 'profile_as_visitor_bloc.dart';

abstract class ProfileAsVisitorEvent extends Equatable {
  const ProfileAsVisitorEvent();
}

class OnOpenProfileEvent extends ProfileAsVisitorEvent {
  final String userId;

  const OnOpenProfileEvent(this.userId);
  @override
  List<Object?> get props => [userId];
}

class UpdateProfileEvent extends ProfileAsVisitorEvent {
  final UserModel user;

  const UpdateProfileEvent(this.user);
  @override
  List<Object?> get props => [];
}

class OnFollowProfileEvent extends ProfileAsVisitorEvent {
  final String userId;
  final List userFollowers;

  const OnFollowProfileEvent(
      {required this.userId, this.userFollowers = const []});
  @override
  List<Object?> get props => [];
}
