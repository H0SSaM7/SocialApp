import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/controllers/home_layout_controller/home_states.dart';

import 'package:social_app/presentation/chats/chats_screen.dart';
import 'package:social_app/presentation/explore/explore_screen.dart';
import 'package:social_app/presentation/user_profile/user_profile_screen.dart';
import 'package:social_app/presentation/users/users_screen.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutStates> {
  HomeLayoutCubit() : super(SocialInitialState());
  static HomeLayoutCubit get(context) => BlocProvider.of(context);

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
}
