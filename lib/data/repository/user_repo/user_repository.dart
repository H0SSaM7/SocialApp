import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/utills/consistent/consistent.dart';

class UserRepository {
  final _fireStore = FirebaseFirestore.instance;

  Stream<UserModel> getUserData() {
    UserModel? user;
    return _fireStore
        .collection('users')
        .doc(currentUserId)
        .snapshots()
        .map((event) => UserModel.fromSnap(event));
  }
}
