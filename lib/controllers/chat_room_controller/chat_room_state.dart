part of 'chat_room_bloc.dart';

abstract class ChatRoomState extends Equatable {}

class ChatRoomInitial extends ChatRoomState {
  @override
  List<Object?> get props => [];
}

class ChatRoomUpdateMessages extends ChatRoomState {
  final List<ChatsModel> messages;

  ChatRoomUpdateMessages({this.messages = const []});
  @override
  List<Object?> get props => [messages];
}

class ChatRoomGetMessagesError extends ChatRoomState {
  @override
  List<Object?> get props => [];
}
