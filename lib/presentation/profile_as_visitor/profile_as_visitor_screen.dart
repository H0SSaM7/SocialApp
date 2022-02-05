import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/controllers/profile_as_visitor_controller/profile_as_visitor_bloc.dart';
import 'package:social_app/controllers/theme_controller/theme_cubit.dart';
import 'package:social_app/data/repository/user_repo/user_repository.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/utils/components/components.dart';
import 'package:social_app/utils/components/my_profile_image.dart';
import 'package:social_app/utils/consistent/consistent.dart';

class ProfileScreenAsVisitor extends StatelessWidget {
  const ProfileScreenAsVisitor({Key? key, required this.userId})
      : super(key: key);
  final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileAsVisitorBloc(userRepository: UserRepository())
            ..add(OnOpenProfileEvent(userId)),
      child: BlocBuilder<ProfileAsVisitorBloc, ProfileAsVisitorState>(
        builder: (context, state) {
          if (state is ProfileAsVisitorInitial) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (state is ProfileAsVisitorGetUserSuccess) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(state.user.name!),
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
                      buildUpperScreen(context, state.user),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildButtonsSection(context, state.user),
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
                                style: Theme.of(context).textTheme.headline5!,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // TODO posts which include specific user
                      // ListView.separated(
                      //     shrinkWrap: true,
                      //     physics: const NeverScrollableScrollPhysics(),
                      //     itemBuilder: (context, index) {
                      //       return PostCardWidget(
                      //         postId: '',
                      //         model: PostsModel(uId: userId),
                      //         // cubit.posts[index],
                      //         index: index,
                      //       );
                      //     },
                      //     separatorBuilder: (context, index) => const SizedBox(
                      //           height: 5,
                      //         ),
                      //     itemCount: 1
                      //     // cubit.posts.length,
                      //     ),
                    ],
                  ),
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Row buildButtonsSection(BuildContext context, UserModel user) {
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
          context.read<ProfileAsVisitorBloc>().add(
                OnFollowProfileEvent(
                    userId: userId, userFollowers: user.followers!),
              );
        },
            child: user.followers!.contains(currentUserId)
                ? const Text('unFollow')
                : const Text('Follow'),
            height: 40,
            color: user.followers!.contains(currentUserId)
                ? Colors.grey[600]
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
              MyProfileImage(
                radius: 55,
                enableEdit: false,
                image: NetworkImage(snapshot.profileImage!),
              )
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
