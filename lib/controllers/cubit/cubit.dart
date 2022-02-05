import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/controllers/cubit/states.dart';
import 'package:social_app/presentation/chats/chats_screen.dart';
import 'package:social_app/presentation/explore/explore_screen.dart';
import 'package:social_app/presentation/user_profile/user_profile_screen.dart';
import 'package:social_app/presentation/users/users_screen.dart';

import 'package:social_app/utils/services/pick_image_services.dart';

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

  final PickImageServices _pickServices = PickImageServices();

  File? postImage;

  setPostImage() async {
    postImage = await _pickServices.pickImage();
    emit(SocialPickImageState());
  }

  deletePickedPostImage() {
    postImage = null;
    emit(SocialDeletePostImageState());
  }

  // update the whole profile properties

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
        }).catchError((error) {
          debugPrint(error.toString());
        });
      });
    }
  }
}
