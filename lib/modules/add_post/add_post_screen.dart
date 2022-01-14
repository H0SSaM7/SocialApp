import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var postController = TextEditingController();
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialSuccessCreateNewPostState) {
          myToast(
              msg: 'Create New Post Successfully ', state: toastStates.success);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create post'),
          ),
          bottomNavigationBar: SizedBox(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  // add image button -----------------
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        cubit.setPostImage();
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
                  Expanded(
                    child: myElevatedButton(context,
                        height: 38, borderCircular: 50, onPressed: () async {
                      // if the user didn't input any fields
                      if (cubit.postImage == null &&
                          postController.text.isEmpty) {
                        myToast(
                            msg: 'There is no Post to create !',
                            state: toastStates.warning);
                        // if the user input only description
                      } else if (cubit.postImage == null &&
                          postController.text.isNotEmpty) {
                        cubit.createNewPost(
                            postImage: '',
                            date: DateTime.now().toString(),
                            postDescription: postController.text);

                        // case the user input description and choose image
                      } else {
                        cubit.uploadPostImageAndCreatePost(
                            date: DateTime.now().toString(),
                            postDescription: postController.text);
                      }
                    },
                        child: ConditionalBuilder(
                            condition:
                                state is SocialLoadingUploadPostImageState,
                            builder: (context) {
                              return const FittedBox(
                                fit: BoxFit.contain,
                                child: CircularProgressIndicator.adaptive(
                                  backgroundColor: Colors.white,
                                  strokeWidth: 2,
                                ),
                              );
                            },
                            fallback: (context) {
                              return const Text('PUBLISH');
                            })),
                  ),
                ],
              ),
            ),
          ),
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
                            cubit.userModel!.profileImage!,
                          )),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Hossam Ramadan',
                        style: Theme.of(context).textTheme.subtitle1!.copyWith(
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
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      right: 10,
                    ),
                    child: ConditionalBuilder(
                      condition: cubit.postImage != null,
                      builder: (context) => buildAddImage(cubit),
                      fallback: (context) => const SizedBox(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Stack buildAddImage(SocialCubit cubit) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Image.file(
          cubit.postImage!,
          height: 300,
          fit: BoxFit.cover,
        ),
        IconButton(
          padding: const EdgeInsets.all(4),
          alignment: Alignment.topRight,
          onPressed: () {
            cubit.deletePickedPostImage();
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
    );
  }
}
