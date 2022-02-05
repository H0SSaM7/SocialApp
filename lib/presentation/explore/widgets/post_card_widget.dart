import 'package:flutter/material.dart ';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import 'package:social_app/controllers/cubit/cubit.dart';
import 'package:social_app/controllers/posts_controller/posts_bloc.dart';
import 'package:social_app/controllers/user_controller/user_bloc.dart';
import 'package:social_app/models/posts_model.dart';
import 'package:social_app/presentation/comment/comment_screen.dart';
import 'package:social_app/presentation/profile_as_visitor/profile_as_visitor_screen.dart';
import 'package:social_app/utils/components/components.dart';
import 'package:social_app/utils/consistent/consistent.dart';

class PostCardWidget extends StatelessWidget {
  final PostsModel model;
  final String postId;
  final int index;
  const PostCardWidget(
      {Key? key,
      required this.model,
      required this.index,
      required this.postId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            nameAndPhotoOfThePublisher(context),
            if (model.postDescription!.isNotEmpty)
              descriptionOfThePost(context),
            if (model.postImage!.isNotEmpty) imageOfThePost(),
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
                    title: '${model.likes!.length}',
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
                    title: '0',
                    onTap: () {
                      navigateTo(
                          context,
                          CommentScreen(
                            postId: postId,
                          ));
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            writeCommentAndAddLoveSection(context),
          ],
        ),
      ),
    );
  }

  Row writeCommentAndAddLoveSection(BuildContext context) {
    return Row(
      children: [
        BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoadedState) {
              return CircleAvatar(
                radius: 18,
                // user photo in beside comments
                backgroundImage: NetworkImage(state.user.profileImage!),
              );
            }

            return const CircleAvatar();
          },
        ),
        const SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () {
            navigateTo(
                context,
                CommentScreen(
                  postId: postId,
                ));
          },
          child: Text(
            'Write a Comment',
            style: Theme.of(context).textTheme.caption!.copyWith(fontSize: 14),
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () {
            BlocProvider.of<PostsBloc>(context).add(
              LikePostEvent(postId, model.likes!),
            );
          },
          child: Row(
            children: [
              FaIcon(
                model.likes!.contains(currentUserId)
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
    );
  }

  Padding nameAndPhotoOfThePublisher(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 2,
      ),
      child: Row(
        children: [
// profile image -----------------------
          CircleAvatar(
              radius: 26, backgroundImage: NetworkImage(model.profileImage!)),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  if (model.uId != currentUserId) {
                    navigateTo(
                        context,
                        ProfileScreenAsVisitor(
                          userId: model.uId!,
                        ));
                  } else {
                    SocialCubit.get(context).changeNavbar(3);
                  }
                },
                child: Row(
                  children: [
// publisher name -----------------------------
                    Text(
                      model.name!,
                      style: Theme.of(context).textTheme.subtitle1!.copyWith(
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
              ),
// date of the post --------------
              Text(
                DateFormat.yMMMd()
                    .format(DateTime.parse(model.date!))
                    .toString(),
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
    );
  }

  Padding imageOfThePost() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Image.network(
        model.postImage!,
        height: 400,
        width: double.maxFinite,
        fit: BoxFit.cover,
      ),
    );
  }

  Column descriptionOfThePost(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        Text(model.postDescription!,
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 16)),
      ],
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
}
