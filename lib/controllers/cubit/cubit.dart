import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/controllers/cubit/states.dart';
import 'package:social_app/models/posts_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/presentation/chats/chats_screen.dart';
import 'package:social_app/presentation/explore/explore_screen.dart';
import 'package:social_app/presentation/user_profile/user_profile_screen.dart';
import 'package:social_app/presentation/users/users_screen.dart';
import 'package:social_app/utills/consistent/consistent.dart';
import 'package:social_app/utills/services/pick_services/pick_services.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());
  static SocialCubit get(context) => BlocProvider.of(context);

// home page work
  int currentIndex = 0;

  changeNavbar(int index) {
    if (index == 1) {}
    currentIndex = index;
    emit(SocialChangeNavBarState());
  }

  List<Widget> screens = const [
    ExploreScreen(),
    ChatsScreen(),
    UsersScreen(),
    UserProfileScreen(),
  ];
  List<String> appBarTitles = const ['Explore', 'Chats', 'Users', 'Profile'];

  // setting screen
  late int radioValue;

  // image picker and upload methods

  final PickServices _pickServices = PickServices();

  // file image variables
  File? profileImage;
  File? postImage;

  // Url image variables

  String? profileImageUrl;

  // this method only to render picked image
  setProfileImage() async {
    profileImage = await _pickServices.pickImage();
    emit(SocialPickImageState());
  }

  setPostImage() async {
    postImage = await _pickServices.pickImage();
    emit(SocialPickImageState());
  }

  deletePickedPostImage() {
    postImage = null;
    emit(SocialDeletePostImageState());
  }

  //its return url of the picked profile image after store it in firebase
  uploadProfileImage() {
    if (profileImage == null) {
      null;
    } else {
      emit(SocialLoadingUploadProfileImageState());
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
          .putFile(profileImage!)
          .then((p0) {
        p0.ref.getDownloadURL().then((value) {
          profileImageUrl = value;
          emit(SocialSuccessUploadProfileImageState());
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
      token: '',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserId)
        .update(model.toJson())
        .then((value) {})
        .catchError((error) {});
  }

  uploadPostImageAndCreatePost(
      {required String date, required String postDescription}) {
    if (postImage == null) {
      null;
    } else {
      emit(SocialLoadingUploadPostImageState());
      firebase_storage.FirebaseStorage.instance
          .ref()
          .child('users/${Uri.file(postImage!.path).pathSegments.last}')
          .putFile(postImage!)
          .then((p0) {
        p0.ref.getDownloadURL().then((value) {
          emit(SocialSuccessUploadPostImageState());
          createNewPost(
              postImage: value, date: date, postDescription: postDescription);
        }).catchError((error) {
          debugPrint(error.toString());
        });
      });
    }
  }

  createNewPost({
    required String? postImage,
    required String date,
    required String postDescription,
  }) {
    emit(SocialLoadingCreateNewPostState());
    var userModel;
    PostsModel postsModel = PostsModel(
      name: userModel!.name,
      uId: userModel!.uId,
      profileImage: userModel!.profileImage,
      date: date,
      postDescription: postDescription,
      postImage: postImage,
      likes: [],
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(
          postsModel.toJson(),
        )
        .then((value) {
      emit(SocialSuccessCreateNewPostState());
    }).catchError((error) {
      emit(SocialErrorCreateNewPostState());
      debugPrint(error.toString());
    });
  }
}
