import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/models/user_model.dart';

class SearchRepository {
  Future<List<UserModel>> getSearchResult({required String value}) async {
    List<UserModel> users = [];
    QuerySnapshot<Map<String, dynamic>> _data = await FirebaseFirestore.instance
        .collection('users')
        .where('name', isLessThanOrEqualTo: value)
        .get();
    if (_data.docs.isEmpty) {
      return users;
    }
    for (var element in _data.docs) {
      users.add(UserModel.fromSnap(element));
    }
    return users;
  }
}
