import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart' show debugPrint;
import 'package:social_app/models/posts_model.dart';
import 'package:social_app/utils/consistent/consistent.dart';

import 'package:tuple/tuple.dart';

class PostsRepository {
  Stream<Tuple2<List<PostsModel>, List<String>>> getStreamPosts() {
    List<PostsModel> posts = [];
    List<String> postsId = [];

    return FirebaseFirestore.instance
        .collection('posts')
        .snapshots()
        .map((event) {
      posts = [];
      postsId = [];
      for (var element in event.docs) {
        postsId.add(element.id);
        posts.add(
          PostsModel.fromMap(
            element.data(),
          ),
        );
      }
      return Tuple2(posts, postsId);
    });
  }

  Future<void> addOrRemoveLike(
      {required String postId, required List likes}) async {
    if (likes.contains(currentUserId)) {
      await FirebaseFirestore.instance.collection('posts').doc(postId).update({
        'likes': FieldValue.arrayRemove([currentUserId]),
      });
    } else {
      await FirebaseFirestore.instance.collection('posts').doc(postId).update({
        'likes': FieldValue.arrayUnion([currentUserId]),
      });
    }
  }

  Future<void> createNewPost({
    required String? postImage,
    required String postDescription,
    required String name,
    required String profileImage,
  }) async {
    try {
      PostsModel postsModel = PostsModel(
        name: name,
        uId: currentUserId,
        profileImage: profileImage,
        date: DateTime.now().toString(),
        postDescription: postDescription,
        postImage: postImage,
        likes: [],
      );
      await FirebaseFirestore.instance.collection('posts').add(
            postsModel.toJson(),
          );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
