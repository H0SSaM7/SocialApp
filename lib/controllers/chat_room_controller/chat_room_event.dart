part of 'chat_room_bloc.dart';

abstract class ChatRoomEvent extends Equatable {}

class GetMessagesEvent extends ChatRoomEvent {
  @override
  List<Object?> get props => [];
}

class UpdateMessagesEvent extends ChatRoomEvent {
  final List<ChatsModel> messages;
  UpdateMessagesEvent({this.messages = const []});
  @override
  List<Object?> get props => [messages];
}

class SendMessagesEvent extends ChatRoomEvent {
  @override
  List<Object?> get props => [];
}
