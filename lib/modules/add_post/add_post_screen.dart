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
                          onPressed: () async {
                            cubit.postImage = await cubit.pickImage();
                          },
                          icon: const FaIcon(
                            FontAwesomeIcons.image,
                            size: 16,
                          ),
                          label: const Text('Image')),
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
                      child: myElevatedButton(
                        context,
                        height: 38,
                        borderCircular: 50,
                        onPressed: () {},
                        child: const Text(
                          'PUBLISH',
                        ),
                      ),
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
                        const CircleAvatar(
                          radius: 26,
                          // profile image
                          backgroundImage: NetworkImage(
                              'https://image.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg'),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Hossam Ramadan',
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
        listener: (context, state) {});
  }

  Stack buildAddImage(SocialCubit cubit) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Image.file(
          cubit.postImage!,
          width: double.maxFinite,
          height: 180,
          fit: BoxFit.cover,
        ),
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            cubit.postImage = null;
          },
          icon: const CircleAvatar(
            radius: 15,
            child: Icon(
              Icons.delete_forever,
              size: 18,
            ),
          ),
        ),
      ],
    );
  }
}
