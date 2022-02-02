import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart' show debugPrint;
import 'package:social_app/models/message_model.dart';
import 'package:social_app/utills/consistent/consistent.dart';

class MessagesRepository {
  Stream<List<MessageModel>>? getMessages({
    required String receiverId,
  }) {
    List<MessageModel> messages = [];
    try {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .collection('chats')
          .doc(receiverId)
          .collection('messages')
          .orderBy('date')
          .snapshots()
          .map((event) {
        for (var element in event.docs) {
          messages.add(MessageModel.fromMap(element.data()));
        }
        return messages;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> sendMessages({
    required String receiverName,
    required String receiverToken,
    required String receiverId,
    required String message,
  }) async {
    MessageModel? chatsModel;
    try {
      chatsModel = MessageModel(
        receiverId: receiverId,
        message: message,
        date: DateTime.now().toString(),
        senderId: currentUserId,
      );
      // setup message for me
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .collection('chats')
          .doc(receiverId)
          .collection('messages')
          .add(chatsModel.toMap());

      // DioHelper.post(
      //     token: receiverToken, userName: receiverName, message: message);

      // setup message for other user
      await FirebaseFirestore.instance
          .collection('users')
          .doc(receiverId)
          .collection('chats')
          .doc(currentUserId)
          .collection('messages')
          .add(chatsModel.toMap());
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
