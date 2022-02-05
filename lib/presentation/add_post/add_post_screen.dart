import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/controllers/add_new_post_controller/bloc/add_post_bloc.dart';
import 'package:social_app/data/repository/posts_repo/posts_repository.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/utils/components/components.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({
    Key? key,
    required this.user,
  }) : super(key: key);
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    var postController = TextEditingController();
    return BlocProvider(
      create: (context) => AddPostBloc(postsRepository: PostsRepository()),
      child: BlocConsumer<AddPostBloc, AddPostState>(
        listener: (context, state) {
          if (state is AddPostNoImageSelected) {
            myToast(msg: 'No Image Selected!', state: toastStates.warning);
          }

          if (state is AddPostSuccessfullyState) {
            myToast(
                msg: 'You Post Added Successfully.',
                state: toastStates.success);
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Create post'),
            ),
            bottomNavigationBar: buildCustomNavBar(context, postController),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                            radius: 26,
                            // profile image --------------
                            backgroundImage: NetworkImage(
                              user.profileImage!,
                            )),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          user.name!,
                          style:
                              Theme.of(context).textTheme.subtitle1!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                    TextFormField(
                      maxLines: 15,
                      minLines: 5,
                      controller: postController,
                      decoration: InputDecoration(
                        fillColor: Theme.of(context).scaffoldBackgroundColor,
                        hintText: 'What is in your mind !',
                        border: InputBorder.none,
                      ),
                    ),
                    if (state is ShowPostPickedImage)
                      Center(
                        child: Padding(
                            padding: const EdgeInsets.only(
                              top: 10,
                              right: 10,
                            ),
                            child: buildAddImage(
                              context,
                              state.image,
                            )),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  SizedBox buildCustomNavBar(
    BuildContext context,
    TextEditingController postController,
  ) {
    return SizedBox(
      height: 80,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            // add image button -----------------
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {
                  context.read<AddPostBloc>().add(AddImageToPostEvent());
                },
                icon: const FaIcon(
                  FontAwesomeIcons.image,
                  size: 16,
                ),
                label: const Text('Image'),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            // add tags button -----------------
            OutlinedButton(
              onPressed: () {},
              child: const Text('#Tags'),
            ),
            const SizedBox(
              width: 15,
            ),
            // Publish the post button -----------------
            BlocBuilder<AddPostBloc, AddPostState>(
              builder: (context, state) {
                return Expanded(
                  child: myElevatedButton(context,
                      height: 38, borderCircular: 50, onPressed: () async {
                    if (postController.text.isNotEmpty ||
                        state is ShowPostPickedImage) {
                      context.read<AddPostBloc>().add(
                            UploadPostEvent(user.name!, postController.text,
                                user.profileImage!),
                          );
                    } else {
                      myToast(
                          msg: 'No post to publish', state: toastStates.error);
                    }
                  }, child: const Text('Publish Now')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAddImage(
    BuildContext context,
    File? image,
  ) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Stack(
          alignment: Alignment.topRight,
          children: [
            Image.file(
              image!,
              height: 300,
              fit: BoxFit.cover,
            ),
            IconButton(
              padding: const EdgeInsets.all(4),
              alignment: Alignment.topRight,
              onPressed: () {
                context.read<AddPostBloc>().add(DeletepickedPostImageEvent());
              },
              icon: const CircleAvatar(
                backgroundColor: Colors.red,
                radius: 10,
                child: Icon(
                  Icons.cancel_outlined,
                  size: 15,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
