import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/explore/widgets/post_card_widget.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';

class ProfileScreenAsVisitor extends StatelessWidget {
  const ProfileScreenAsVisitor({Key? key, required this.userId})
      : super(key: key);
  final String userId;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                // currentUser!.name ??
                '',
              ),
              titleTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            body: FutureBuilder<UserModel>(
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return Container(
                    color: cubit.isDarkTheme
                        ? Theme.of(context).hoverColor
                        : Theme.of(context).scaffoldBackgroundColor,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildUpperScreen(context, cubit),
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
                                Text(
                                  'Posts',
                                  style: Theme.of(context).textTheme.headline5!,
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
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
              future: SocialCubit.get(context).getUserById(userId: userId),
            ));
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
        myElevatedButton(context,
            onPressed: () {},
            child: const Text('Follow'),
            height: 40,
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

  Column buildUpperScreen(BuildContext context, SocialCubit cubit) {
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
                  image: NetworkImage(cubit.userModel!.profileImage!),
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
            cubit.userModel!.bio!,
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
            buildPropertiesOption(context, '20 K', 'Followers'),
            Container(
              height: 50,
              width: 1,
              color: Colors.grey[400],
            ),
            buildPropertiesOption(context, '77', 'Following'),
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
