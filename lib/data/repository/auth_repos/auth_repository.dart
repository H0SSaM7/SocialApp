import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:social_app/models/user_model.dart';

class AuthRepository {
  Future<String> userRegister({
    required String email,
    required String password,
  }) async {
    String state = 'SomeThing went Wrong';
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      state = 'success';
    } catch (e) {
      debugPrint(e.toString());
      state = e.toString();
    }
    return state;

    // userCreate(email: email, phone: phone, name: name, uId: value.user!.uid);
  }

  Future<void> createNewUserInDB({
    required String email,
    required String phone,
    required String name,
    required String uId,
  }) async {
    try {
      UserModel model = UserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        emailVerified: FirebaseAuth.instance.currentUser!.emailVerified,
        bio: 'Write your bio ...',
        profileImage:
            'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png',
        following: [],
        followers: [],
      );
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .set(model.toJson());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

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

  Future<void> updateUserToken(String userId) async {
    var token = await FirebaseMessaging.instance.getToken();
    FirebaseFirestore.instance.collection('users').doc(userId).update(
      {
        'token': token,
      },
    );
  }
}
