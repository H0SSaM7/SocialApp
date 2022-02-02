import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_app/data/repository/messages_repo/messages_repository.dart';
import 'package:social_app/models/message_model.dart';
part 'chat_room_event.dart';
part 'chat_room_state.dart';

class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState> {
  final MessagesRepository _messagesRepository;
  StreamSubscription? _messageSubscription;
  ChatRoomBloc({required MessagesRepository messagesRepository})
      : _messagesRepository = messagesRepository,
        super(ChatRoomInitial()) {
    on<GetMessagesEvent>(_getMessages);

    on<UpdateMessagesEvent>(_updateMessages);

    on<SendMessagesEvent>(_sendMessages);
  }

  FutureOr<void> _getMessages(
      GetMessagesEvent event, Emitter<ChatRoomState> emit) {
    _messageSubscription?.cancel();
    _messagesRepository
        .getMessages(receiverId: event.receiverId)
        ?.listen((event) {
      add(UpdateMessagesEvent(messages: event));
    });
  }

  FutureOr<void> _updateMessages(
      UpdateMessagesEvent event, Emitter<ChatRoomState> emit) {
    emit(ChatRoomUpdateMessages(messages: event.messages));
  }

  FutureOr<void> _sendMessages(
      SendMessagesEvent event, Emitter<ChatRoomState> emit) {}
}
