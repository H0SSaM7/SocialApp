import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthRepository {
  Future<String> userLogin(
      {required String email, required String password}) async {
    String state = 'Something went wrong please try later';
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      state = 'success';
    } catch (e) {
      debugPrint(e.toString());
      state = e.toString();
    }
    return state;
  }

  String getUserId() {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    return uid;
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
