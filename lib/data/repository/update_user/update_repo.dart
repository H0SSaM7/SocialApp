import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/utills/consistent/consistent.dart';

class UpdateUserRepository {
  updateProfile({
    required String phone,
    required String name,
    required String bio,
    required String profileImage,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .update({
          'name': name,
          'bio': bio,
          'profileImage': profileImage,
          'phone': phone,
        })
        .then((value) {})
        .catchError((error) {});
  }
}
