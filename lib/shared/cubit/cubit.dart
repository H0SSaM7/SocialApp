import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/explore/explore_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/consistent/consistent.dart';
import 'package:social_app/shared/cubit/states.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;
  // getting user data when the app open.
  getUserDate() {
    emit(SocialLoadingGetUserState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .get()
        .then((value) {
      print(value.data().toString());
      userModel = UserModel.fromJson(value.data()!);
      emit(SocialSuccessGetUserState());
    }).catchError((onError) {
      debugPrint(onError);
      emit(SocialErrorGetUserState());
    });
  }

// home page work
  int currentIndex = 0;
  changeNavbar(int index) {
    currentIndex = index;
    emit(SocialChangeNavBarState());
  }

  List<Widget> screens = const [
    ExploreScreen(),
    ChatsScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<String> appBarTitles = const ['Explore', 'Chats', 'Users', 'Profile'];
  // image picker and upload methods

  final ImagePicker _picker = ImagePicker();
  // file image variables
  File? profileImage;
  File? postImage;
  // Url image variables
  String? postImageUrl;
  String? profileImageUrl;
// it return the picked image from device and i store it in any variable
  pickImage() async {
    XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage == null) {
      null;
    } else {
      return File(pickedImage.path);
    }
    emit(SocialPickImageState());
  }

  //its return url of the picked image after store it in firebase
  uploadImage() {
    if (profileImage == null) {
      null;
    } else {
      emit(SocialLoadingUploadImageState());
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
          .putFile(profileImage!)
          .then((p0) {
        p0.ref.getDownloadURL().then((value) {
          profileImageUrl = value;
          emit(SocialSuccessUploadImageState());
        }).catchError((error) {
          debugPrint(error.toString());
        });
      });
    }
  }

// update the whole profile properties
  updateProfile({
    required String email,
    required String phone,
    required String name,
    required String uId,
    required String bio,
    required String profileImage,
  }) {
    UserModel model = UserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      emailVerified: FirebaseAuth.instance.currentUser!.emailVerified,
      bio: bio,
      profileImage: profileImage,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .update(model.toJson())
        .then((value) {
      getUserDate();
    }).catchError((error) {});
  }
}
