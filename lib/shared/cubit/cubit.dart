import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
}
