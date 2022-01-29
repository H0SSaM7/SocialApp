import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

class LoginRepository {
  Future<String?> userLogin(
      {required String email, required String password}) async {
    String? userId;
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then(
      (value) {
        return userId = value.user!.uid;
      },
    ).catchError(
      (onError) {
        debugPrint(onError.toString());
      },
    );
    return null;
  }

  updateUserToken(String userId) async {
    var token = await FirebaseMessaging.instance.getToken();
    FirebaseFirestore.instance.collection('users').doc(userId).update(
      {
        'token': token,
      },
    );
  }
}
