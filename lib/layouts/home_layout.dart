import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/modules/add_post/add_post_screen.dart';
import 'package:social_app/shared/components/components.dart';
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
            resizeToAvoidBottomInset: false,
            extendBody: true,
            appBar: AppBar(
              title: Text(cubit.appBarTitles[cubit.currentIndex]),
              centerTitle: true,
            ),
            bottomNavigationBar: customBottomNavigationBar(context, cubit),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterDocked,
            floatingActionButton: SizedBox(
              height: 45,
              width: 45,
              child: FittedBox(
                child: FloatingActionButton(
                  backgroundColor: Theme.of(context).primaryColor,
                  clipBehavior: Clip.none,
                  tooltip: 'New post',
                  onPressed: () {
                    navigateTo(context, const AddPostScreen());
                  },
                  child: const Icon(
                    Icons.add,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            body: cubit.screens[cubit.currentIndex]);
      },
    );
  }

  BottomAppBar customBottomNavigationBar(
      BuildContext context, SocialCubit cubit) {
    return BottomAppBar(
      notchMargin: 6.0,
      elevation: 20,
      //bottom navigation bar on scaffold
      color: Theme.of(context).bottomAppBarColor,
      shape: const CircularNotchedRectangle(), //shape of notch
      child: Container(
        margin: const EdgeInsets.all(5.0),
        height: 50,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            bottomBarIcon(cubit, context, FontAwesomeIcons.home, 0),
            bottomBarIcon(cubit, context, FontAwesomeIcons.commentDots, 1),
            const SizedBox(
              width: 70,
            ),
            bottomBarIcon(cubit, context, FontAwesomeIcons.user, 2),
            bottomBarIcon(cubit, context, Icons.settings_outlined, 3),
          ],
        ),
      ),
    );
  }

  CircleAvatar bottomBarIcon(SocialCubit cubit, BuildContext context,
      IconData icon, int currentNumber) {
    return CircleAvatar(
      backgroundColor: cubit.currentIndex == currentNumber
          ? Colors.grey[400]
          : Colors.transparent,
      radius: 35,
      child: FittedBox(
        child: IconButton(
          icon: FaIcon(
            icon,
            color: cubit.currentIndex == currentNumber
                ? Theme.of(context).primaryColor
                : Colors.grey,
          ),
          onPressed: () {
            cubit.changeNavbar(currentNumber);
          },
        ),
      ),
    );
  }
}
