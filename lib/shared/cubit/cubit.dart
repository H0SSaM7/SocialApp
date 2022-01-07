import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/add_post/add_post_screen.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/explore/explore_screen.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:social_app/shared/consistent/consistent.dart';
import 'package:social_app/shared/cubit/states.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;
  // getting user data when the app open.
  getUserDate() {
    emit(SocialLoadingGetUserState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
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
    AddPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<String> appBarTitles = const [
    'Explore',
    'Chats',
    'Add Post',
    'Users',
    'Profile'
  ];
  // image picker and upload methods

  final ImagePicker _picker = ImagePicker();
  XFile? image;
  pickImage() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    emit(SocialPickImageState());
  }
}
