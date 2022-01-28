import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_app/controllers/cubit/cubit.dart';
import 'package:social_app/controllers/cubit/states.dart';
import 'package:social_app/controllers/theme_controller/theme_cubit.dart';

import 'package:social_app/models/user_model.dart';
import 'package:social_app/presentation/explore/widgets/post_card_widget.dart';

import 'package:social_app/utills/components/components.dart';
import 'package:social_app/utills/consistent/consistent.dart';

class ProfileScreenAsVisitor extends StatelessWidget {
  const ProfileScreenAsVisitor({Key? key, required this.userId})
      : super(key: key);
  final String userId;
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getUserById(userId: userId);
        return BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            SocialCubit cubit = SocialCubit.get(context);
            return ConditionalBuilder(
              condition: cubit.userById != null,
              fallback: (context) {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
              builder: (context) {
                return Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: Text(cubit.userById!.name!),
                    titleTextStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  body: Container(
                    color: context.watch<ThemeCubit>().isDarkTheme
                        ? Theme.of(context).hoverColor
                        : Theme.of(context).scaffoldBackgroundColor,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildUpperScreen(context, cubit.userById!),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildButtonsSection(context, cubit),
                                const Divider(
                                  thickness: 1,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 3,
                                  ),
                                  child: Text(
                                    'Posts',
                                    style:
                                        Theme.of(context).textTheme.headline5!,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return PostCardWidget(
                                model: cubit.posts[index],
                                index: index,
                                cubit: cubit,
                              );
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              height: 5,
                            ),
                            itemCount: cubit.posts.length,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  Row buildButtonsSection(BuildContext context, SocialCubit cubit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          )),
          onPressed: () {},
          child: const Icon(Icons.share),
        ),
        const SizedBox(
          width: 10,
        ),
        myElevatedButton(context, onPressed: () {
          cubit.followUser(userId: userId);
        },
            child: cubit.userById!.followers!.contains(currentUserId)
                ? const Text('unFollow')
                : const Text('Follow'),
            height: 40,
            color: cubit.userById!.followers!.contains(currentUserId)
                ? Colors.transparent
                : Theme.of(context).primaryColor,
            width: MediaQuery.of(context).size.width * 0.5,
            borderCircular: 20),
        const SizedBox(
          width: 10,
        ),
        OutlinedButton(
          style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          )),
          onPressed: () {},
          child: const Icon(
            Icons.message,
          ),
        ),
      ],
    );
  }

  Column buildUpperScreen(BuildContext context, UserModel snapshot) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Align(
                alignment: AlignmentDirectional.topStart,
                child: Container(
                  height: 90.0,
                  decoration: BoxDecoration(
                    color: Theme.of(context).appBarTheme.backgroundColor,
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.elliptical(
                        140,
                        70,
                      ),
                    ),
                  ),
                ),
              ),
              myProfileImage(
                  radius: 55,
                  enableEdit: false,
                  image: NetworkImage(snapshot.profileImage!),
                  context: context)
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: 250,
          alignment: Alignment.center,
          child: Text(
            snapshot.bio!,
            style: Theme.of(context).textTheme.caption,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            buildPropertiesOption(context, '100', 'Posts'),
            Container(
              height: 50,
              width: 1,
              color: Colors.grey[400],
            ),
            buildPropertiesOption(
                context, '${snapshot.followers!.length}', 'Followers'),
            Container(
              height: 50,
              width: 1,
              color: Colors.grey[400],
            ),
            buildPropertiesOption(
                context, '${snapshot.following!.length}', 'Following'),
          ],
        ),
      ],
    );
  }

  Expanded buildPropertiesOption(
      BuildContext context, String number, String title) {
    return Expanded(
        child: Column(
      children: [
        Text(
          number,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.caption,
        ),
      ],
    ));
  }
}
