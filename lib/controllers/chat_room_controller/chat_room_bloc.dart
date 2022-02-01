import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:social_app/models/chats_model.dart';
part 'chat_room_event.dart';
part 'chat_room_state.dart';

class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState> {
  ChatRoomBloc() : super(ChatRoomInitial()) {
    on<GetMessagesEvent>(_getMessages);

    on<UpdateMessagesEvent>(_updateMessages);

    on<SendMessagesEvent>(_sendMessages);
  }

  FutureOr<void> _getMessages(
      GetMessagesEvent event, Emitter<ChatRoomState> emit) {}

  FutureOr<void> _updateMessages(
      UpdateMessagesEvent event, Emitter<ChatRoomState> emit) {}

  FutureOr<void> _sendMessages(
      SendMessagesEvent event, Emitter<ChatRoomState> emit) {}
}
