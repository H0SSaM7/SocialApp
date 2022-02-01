part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();
}

class ChatInitial extends ChatState {
  @override
  List<Object> get props => [];
}

class ChatLoaded extends ChatState {
  final List<UserModel> users;
  const ChatLoaded({this.users = const []});
  @override
  List<Object> get props => [users];
}

class ChatError extends ChatState {
  @override
  List<Object> get props => [];
}
