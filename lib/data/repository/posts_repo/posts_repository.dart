import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/models/posts_model.dart';
import 'package:tuple/tuple.dart';

class PostsRepository {
  Stream<Tuple2<List<PostsModel>, List<String>>> getStreamPosts() {
    List<PostsModel> posts = [];
    List<String> postsId = [];

    return FirebaseFirestore.instance
        .collection('posts')
        .snapshots()
        .map((event) {
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
}