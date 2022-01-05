
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              title: const Text('Explore'),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.commentDots), label: 'Chats'),
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.plus), label: 'Add'),
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.user), label: 'Users'),
                BottomNavigationBarItem(
                    icon: FaIcon(FontAwesomeIcons.cog), label: 'settings'),
              ],
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeNavbar(index);
              },
            ),
            body: cubit.screens[cubit.currentIndex]);
      },
    );
  }
}
