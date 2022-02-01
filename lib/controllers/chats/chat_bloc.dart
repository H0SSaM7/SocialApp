import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:social_app/data/repository/user_repo/user_repository.dart';
import 'package:social_app/models/user_model.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final UserRepository _userRepository;
  ChatBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(ChatInitial()) {
    on<ChatEvent>(_loadChatsContact);
  }

  FutureOr<void> _loadChatsContact(
      ChatEvent event, Emitter<ChatState> emit) async {
    await _userRepository.getAllUsers().then((value) {
      emit(ChatLoaded(users: value));
    }).catchError((err) {
      emit(ChatError());
    });
  }
}
