part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserLoadingState extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoadedState extends UserState {
  final UserModel user;
  final List<PostsModel> userPosts;

  const UserLoadedState({
    required this.user,
    this.userPosts = const [],
  });
  @override
  List<Object> get props => [user, userPosts];
}

class UserErrorState extends UserState {
  final String error;
  const UserErrorState(
      {this.error = 'Something went wrong please try again Later'});
  @override
  List<Object> get props => [error];
}
