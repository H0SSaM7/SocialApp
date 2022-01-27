import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/controllers/cubit/cubit.dart';
import 'package:social_app/controllers/cubit/states.dart';

import 'package:social_app/models/comment_model.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({Key? key, required this.postId}) : super(key: key);
  final String postId;
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getComment(postId: postId);
      return BlocConsumer<SocialCubit, SocialStates>(
          builder: (context, state) {
            return SafeArea(
              child: Scaffold(
                body: Column(
                  children: [
                    buildTopCard(context),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ListView.separated(
                            itemBuilder: (context, index) {
                              return buildCommentCard(context,
                                  SocialCubit.get(context).commentList[index]);
                            },
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 10,
                                ),
                            itemCount:
                                SocialCubit.get(context).commentList.length),
                      ),
                    ),
                    buildBottomCard(
                      context,
                      SocialCubit.get(context),
                    ),
                  ],
                ),
              ),
            );
          },
          listener: (context, state) {});
    });
  }

  Card buildTopCard(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.adaptive.arrow_back),
            ),
            const SizedBox(
              width: 30,
            ),
            Text(
              'Comments',
              style: Theme.of(context).textTheme.bodyText1,
            )
          ],
        ),
      ),
    );
  }

  Row buildCommentCard(
    BuildContext context,
    CommentModel model,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // image -------------------------------------------------
        CircleAvatar(
          backgroundImage: NetworkImage(model.userImage!),
        ),
        const SizedBox(
          width: 13,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(
              left: 15.0,
              top: 8.0,
              bottom: 10,
            ),
            decoration: BoxDecoration(
                color: Theme.of(context).hoverColor,
                borderRadius: BorderRadius.circular(20)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
// name ----------------------------
                Text(
                  model.userName!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(fontWeight: FontWeight.w600, fontSize: 15),
                ),
// comment -----------------------------------
                Text(
                  model.comment!,
                  maxLines: 10,
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Card buildBottomCard(BuildContext context, SocialCubit cubit) {
    TextEditingController commentController = TextEditingController();
    return Card(
      margin: const EdgeInsets.all(0.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: [
            const SizedBox(
              width: 15,
            ),
            CircleAvatar(
                radius: 18,
                // user phone in beside comments
                backgroundImage: NetworkImage(
                    SocialCubit.get(context).userModel!.profileImage!)),
            const SizedBox(width: 5),

// write comment tap -----------------------------
            SizedBox(
              width: 210,
              child: TextFormField(
                controller: commentController,
                minLines: 1,
                maxLines: 4,
                onFieldSubmitted: (value) {},
                decoration: const InputDecoration(
                  hintText: 'Write a comment',
                  fillColor: Colors.transparent,
                  border: InputBorder.none,
                ),
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                if (commentController.text.isNotEmpty) {
                  cubit.postComment(
                      postId: postId, comment: commentController.text);
                }
              },
              child: const Text(
                'SEND',
                style: TextStyle(color: Colors.deepOrangeAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
