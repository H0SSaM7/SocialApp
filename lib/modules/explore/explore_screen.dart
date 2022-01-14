import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/models/posts_model.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/consistent/consistent.dart';

import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        builder: (context, state) {
          SocialCubit cubit = SocialCubit.get(context);
          return RefreshIndicator(
            onRefresh: () async {
              cubit.getStreamPosts();
            },
            child: ConditionalBuilder(
              condition: cubit.posts.isNotEmpty && cubit.userModel != null,
              // cubit.commentsList.isNotEmpty &&
              // cubit.likesList.isNotEmpty,
              builder: (context) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      buildEmailVerifyCheck(),
                      Card(
                        elevation: 5.0,
                        clipBehavior: Clip.antiAlias,
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            Image.network(
                              'https://image.freepik.com/free-photo/bearded-man-denim-shirt-round-glasses_273609-11770.jpg',
                              height: 185,
                              width: double.maxFinite,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Communicate with friends',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return buildPostsCard(
                              context, cubit.posts[index], cubit, index);
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 10,
                        ),
                        itemCount: cubit.posts.length,
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                );
              },
              fallback: (context) {
                return const Center(child: CircularProgressIndicator());
              },
            ),
          );
        },
        listener: (context, state) {});
  }

  Card buildPostsCard(
      BuildContext context, PostsModel model, SocialCubit cubit, int index) {
    return Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 2,
              ),
              child: Row(
                children: [
                  // profile image -----------------------
                  CircleAvatar(
                      radius: 26,
                      backgroundImage: NetworkImage(model.profileImage!)),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
// publisher name -----------------------------
                          Text(
                            model.name!,
                            style:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const FaIcon(
                            FontAwesomeIcons.solidCheckCircle,
                            size: 14,
                            color: Colors.blue,
                          )
                        ],
                      ),
// date of the post --------------
                      Text(
                        model.date!,
                        style: Theme.of(context).textTheme.caption,
                      )
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz,
                    ),
                  )
                ],
              ),
            ),
//description of he post
            if (model.postDescription!.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  Text(model.postDescription!,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 16)),
                ],
              ),
            // Padding(
            //   padding: const EdgeInsets.all(5.0),
            //   child: InkWell(
            //     onTap: () {},
            //     child: const Text(
            //       '#Software',
            //       style: TextStyle(
            //         color: Colors.blue,
            //       ),
            //     ),
            //   ),
            // ),
            if (model.postImage!.isNotEmpty)
// Post image ----------------------------
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Image.network(
                  model.postImage!,
                  height: 400,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
            SizedBox(
              height: 30,
              child: Row(
                children: [
                  buildLoveCommentCard(
                    context,
                    icon: const FaIcon(
                      FontAwesomeIcons.solidHeart,
                      color: Colors.pink,
                      size: 16,
                    ),
                    spacer: false,
                    title: '0',
                    // '${cubit.likesList[index].length}',
                    onTap: () {},
                  ),
                  buildLoveCommentCard(
                    context,
                    spacer: true,
                    icon: FaIcon(
                      FontAwesomeIcons.commentDots,
                      color: Colors.yellow[800],
                      size: 16,
                    ),
                    title: '2',
                    // '${cubit.commentsList[index].length}',
                    // '${cubit.countComments[index]} Comments',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const Divider(),
            Row(
              children: [
                CircleAvatar(
                    radius: 18,
                    // user phone in beside comments
                    backgroundImage: NetworkImage(
                        SocialCubit.get(context).userModel!.profileImage!)),
                const SizedBox(
                  width: 10,
                ),

// write comment tap -----------------------------
                SizedBox(
                  width: 200,
                  child: TextFormField(
                    onFieldSubmitted: (value) {
                      cubit.postComment(
                          postId: cubit.postsId[index], comment: value);
                    },
                    decoration: const InputDecoration(
                      hintText: 'Write a comment',
                      fillColor: Colors.transparent,
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    cubit.postLike(postId: cubit.postsId[index]);
                  },
                  child: Row(
                    children: [
                      FaIcon(
                        checkIsLikedPost(cubit, index) != null
                            ? FontAwesomeIcons.solidHeart
                            : FontAwesomeIcons.heart,
                        color: Colors.pink,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      const Text('Like')
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Expanded buildLoveCommentCard(
    BuildContext context, {
    required Function() onTap,
    required String? title,
    required FaIcon icon,
    required bool spacer,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 30,
          alignment: Alignment.bottomCenter,
          child: Row(
            children: [
              if (spacer) const Spacer(),
              icon,
              const SizedBox(
                width: 5,
              ),
              Text(
                title ?? '0',
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEmailVerifyCheck() {
    return Visibility(
      visible: !FirebaseAuth.instance.currentUser!.emailVerified,
      child: Container(
        color: Colors.yellow[400],
        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        child: Row(
          children: [
            const Icon(Icons.info_outline),
            const SizedBox(width: 15),
            const Expanded(
              child: Text('Your email is not verified yet.'),
            ),
            TextButton(
              onPressed: () {
                FirebaseAuth.instance.currentUser!.sendEmailVerification();
                myToast(msg: 'Check your mail', state: toastStates.success);
              },
              child: const Text('verify'),
            ),
          ],
        ),
      ),
    );
  }

  checkIsLikedPost(SocialCubit cubit, int index) {
    return false;
    // for (var element in cubit.likesList[index]) {
    //   if (element.containsKey(currentUserId)) {
    //     return true;
    //   }
    // }
  }
}
