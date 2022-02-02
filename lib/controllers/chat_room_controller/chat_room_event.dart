part of 'chat_room_bloc.dart';

abstract class ChatRoomEvent extends Equatable {}

class GetMessagesEvent extends ChatRoomEvent {
  final String receiverId;
  GetMessagesEvent({required this.receiverId});
  @override
  List<Object?> get props => [receiverId];
}

class UpdateMessagesEvent extends ChatRoomEvent {
  final List<MessageModel> messages;
  UpdateMessagesEvent({this.messages = const []});
  @override
  List<Object?> get props => [messages];
}

class SendMessagesEvent extends ChatRoomEvent {
  // receiver
  final String receiverName;
  final String receiverToken;
  final String receiverId;
  final String message;

  SendMessagesEvent(
      {required this.receiverId,
      required this.receiverName,
      required this.receiverToken,
      required this.message});
  @override
  List<Object?> get props => [receiverName, receiverToken, message, receiverId];
}
