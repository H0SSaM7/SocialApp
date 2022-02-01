import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart' show debugPrint;
import 'package:social_app/data/data_provider/remote/notificaiton/dio_helper.dart';
import 'package:social_app/models/chats_model.dart';
import 'package:social_app/utills/consistent/consistent.dart';

class MessagesRepository {
  ChatsModel? chatsModel;

  sendMessages({
    required String receiverName,
    required String receiverToken,
    required String receiverId,
    required String message,
    required String date,
  }) {
    chatsModel = ChatsModel(
      receiverId: receiverId,
      message: message,
      date: date,
      senderId: currentUserId,
    );
    // setup message for me
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(chatsModel!.toMap())
        .then((value) {
      DioHelper.post(
          token: receiverToken, userName: receiverName, message: message);
    }).catchError((onError) {
      debugPrint(onError.toString());
    });
    // setup message for other user
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(currentUserId)
        .collection('messages')
        .add(chatsModel!.toMap())
        .then((value) {})
        .catchError((onError) {
      debugPrint(onError.toString());
    });
  }

  List<ChatsModel> messages = [];

  getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('date')
        .snapshots()
        .listen((event) {
      messages = [];
      for (var element in event.docs) {
        messages.add(ChatsModel.fromMap(element.data()));
      }
    });
  }
}
