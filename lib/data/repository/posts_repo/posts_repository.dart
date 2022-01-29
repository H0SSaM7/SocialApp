import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:social_app/models/posts_model.dart';
import 'package:tuple/tuple.dart';

class PostsRepository {
  // Stream<Tuple2<List<PostsModel>, List<String>>>
  Stream<QuerySnapshot<Map<String, dynamic>>> getStreamPosts() async* {
    List<PostsModel> posts = [];
    List<String> postsId = [];
    try {
      yield* FirebaseFirestore.instance.collection('posts').snapshots();
      //     .listen(
      //   (event)  {
      //     posts = [];
      //     postsId = [];
      //      for (var element in event.docs) {
      //       postsId.add(element.id);
      //       posts.add(
      //         PostsModel.fromMap(
      //           element.data(),
      //         ),
      //       );
      //     }
      //   },
      // );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  // Stream<Tuple2<List<PostsModel>, List<String>>> getStreamPosts()  async* {
  //   List<PostsModel> posts = [];
  //   List<String> postsId = [];
  //   try {
  //     FirebaseFirestore.instance.collection('posts').snapshots().listen(
  //       (event)  {
  //         posts = [];
  //         postsId = [];
  //          for (var element in event.docs) {
  //           postsId.add(element.id);
  //           posts.add(
  //             PostsModel.fromMap(
  //               element.data(),
  //             ),
  //           );
  //         }
  //       },
  //     );
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }
}
