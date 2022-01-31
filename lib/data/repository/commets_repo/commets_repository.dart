import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart' show debugPrint;
import 'package:social_app/models/comment_model.dart';
import 'package:social_app/utills/consistent/consistent.dart';

class CommentsRepository {
  Stream<List<CommentModel>>? getComment({required String postId}) {
    List<CommentModel> commentList = [];
    try {
      return FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .snapshots()
          .map((event) {
        for (var element in event.docs) {
          commentList.add(CommentModel.fromMap(element.data()));
        }
        return commentList;
      });
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  Future<void> postNewComment(
      {required String postId,
      required String comment,
      required String profileImage,
      required String userName}) async {
    CommentModel commentModel = CommentModel(
      userId: currentUserId,
      userImage: profileImage,
      userName: userName,
      comment: comment,
    );
    try {
      await FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('comments')
          .doc(currentUserId)
          .set(commentModel.toMap());
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
