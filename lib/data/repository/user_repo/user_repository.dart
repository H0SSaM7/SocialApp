import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/models/user_model.dart';
import 'package:flutter/material.dart' show debugPrint;
import 'package:social_app/utills/consistent/consistent.dart';

class UserRepository {
  final _fireStore = FirebaseFirestore.instance;

  Stream<UserModel> getUserData() {
    return _fireStore
        .collection('users')
        .doc(currentUserId)
        .snapshots()
        .map((event) => UserModel.fromSnap(event));
  }

  Future<List<UserModel>> getAllUsers() async {
    List<UserModel> users = [];
    try {
      await FirebaseFirestore.instance.collection('users').get().then((value) {
        for (var element in value.docs) {
          if (element.data()['uId'] != currentUserId) {
            users.add(UserModel.fromJson(element.data()));
          }
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    return users;
  }
}
