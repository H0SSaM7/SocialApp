part of 'profile_as_visitor_bloc.dart';

abstract class ProfileAsVisitorState extends Equatable {
  const ProfileAsVisitorState();
}

class ProfileAsVisitorInitial extends ProfileAsVisitorState {
  @override
  List<Object> get props => [];
}

class ProfileAsVisitorGetUserSuccess extends ProfileAsVisitorState {
  final UserModel user;
  final List<PostsModel> posts;
  final List<String> postsId;

  const ProfileAsVisitorGetUserSuccess(
      {this.posts = const [], this.postsId = const [], required this.user});
  @override
  List<Object> get props => [user];
}
