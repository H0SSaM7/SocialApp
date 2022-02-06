import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/models/posts_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:flutter/material.dart' show debugPrint;
import 'package:social_app/utils/consistent/consistent.dart';

class UserRepository {
  final _fireStore = FirebaseFirestore.instance;

  Stream<UserModel> getUserData({required String userId}) {
    return _fireStore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((event) => UserModel.fromSnap(event));
  }

  Future<List<PostsModel>> getUserPosts({required List postsId}) async {
    List<PostsModel> posts = [];

    for (var elemnet in postsId) {
      DocumentSnapshot<Map<String, dynamic>> _data =
          await _fireStore.collection('posts').doc(elemnet).get();
      if (_data.exists) {
        posts.add(
          PostsModel.fromMap(_data.data()!),
        );
      }
    }
    return posts;
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

  Future<void> followUser(
      {required var userId, required List userFollowers}) async {
    if (userFollowers.contains(currentUserId)) {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'followers': FieldValue.arrayRemove([currentUserId])
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .update({
        'following': FieldValue.arrayRemove([userId])
      });
    } else {
      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'followers': FieldValue.arrayUnion([currentUserId])
      });
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId)
          .update({
        'following': FieldValue.arrayUnion([userId])
      });
    }
  }
}
