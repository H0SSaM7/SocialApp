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
            extendBody: true,
            appBar: AppBar(
              title: Text(cubit.appBarTitles[cubit.currentIndex]),
              centerTitle: true,
            ),
            bottomNavigationBar: customBottomNavigationBar(context, cubit),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterDocked,
            floatingActionButton: FloatingActionButton(
              tooltip: 'New post',
              onPressed: () {
                navigateTo(context, const AddPostScreen());
              },
              child: const Icon(Icons.add),
            ),
            body: cubit.screens[cubit.currentIndex]);
      },
    );
  }

  BottomAppBar customBottomNavigationBar(
      BuildContext context, SocialCubit cubit) {
    return BottomAppBar(
        elevation: 20,
        //bottom navigation bar on scaffold
        color: Theme.of(context).scaffoldBackgroundColor,
        shape: const CircularNotchedRectangle(), //shape of notch
        child: Container(
          margin: const EdgeInsets.all(5),
          height: 45,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.home,
                  color: cubit.currentIndex == 0
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                ),
                onPressed: () {
                  cubit.changeNavbar(0);
                },
              ),
              IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.commentDots,
                  color: cubit.currentIndex == 1
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                ),
                onPressed: () {
                  cubit.changeNavbar(1);
                },
              ),
              const SizedBox(
                width: 70,
              ),
              IconButton(
                icon: FaIcon(
                  FontAwesomeIcons.user,
                  color: cubit.currentIndex == 2
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                ),
                onPressed: () {
                  cubit.changeNavbar(2);
                },
              ),
              IconButton(
                icon: FaIcon(
                  Icons.settings_outlined,
                  color: cubit.currentIndex == 3
                      ? Theme.of(context).primaryColor
                      : Colors.grey,
                ),
                onPressed: () {
                  cubit.changeNavbar(3);
                },
              ),
            ],
          ),
        ));
  }
}
