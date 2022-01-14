import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart ';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:social_app/models/posts_model.dart';
import 'package:social_app/modules/comment/comment_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/consistent/consistent.dart';
import 'package:social_app/shared/cubit/cubit.dart';

class PostCardWidget extends StatelessWidget {
  final PostsModel model;
  final SocialCubit cubit;
  final int index;
  const PostCardWidget(
      {Key? key, required this.model, required this.cubit, required this.index})
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
// image of the post  ----------------------------
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
                    title: '${model.likes!.length}',
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
//                 SizedBox(
//                   width: 200,
//                   child: TextFormField(
//                     onFieldSubmitted: (value) {},
//                     decoration: const InputDecoration(
//                       hintText: 'Write a comment',
//                       fillColor: Colors.transparent,
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),
                InkWell(
                  onTap: () {
                    navigateTo(context, CommentScreen());
                  },
                  child: Text('Write a Comment'),
                ),
                const Spacer(),
                InkWell(
                  onTap: () {
                    cubit.addOrRemoveLike(
                        postId: cubit.postsId[index], likes: model.likes!);
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
}
