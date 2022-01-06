import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
        builder: (context, state) {
          SocialCubit cubit = SocialCubit.get(context);
          return SingleChildScrollView(
            child: ConditionalBuilder(
              condition: cubit.userModel != null,
              builder: (context) {
                return SingleChildScrollView(
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
                            return buildPostsCard(context);
                          },
                          separatorBuilder: (context, index) => const SizedBox(
                                height: 10,
                              ),
                          itemCount: 10),
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

  Card buildPostsCard(BuildContext context) {
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
                vertical: 5.0,
                horizontal: 4,
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 26,
                    backgroundImage: NetworkImage(
                        'https://image.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg'),
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Hossam Ramadan',
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
                      Text(
                        'janyary 23, 2022 at 10:00 pm',
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
            const Divider(),
            Text(
                'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letterss',
                style: Theme.of(context).textTheme.bodyText1!),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                onTap: () {},
                child: const Text(
                  '#Software',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
            Image.network(
              'https://image.freepik.com/free-vector/espresso-coffee-cup-coffee-beans_79603-1038.jpg',
              height: 160,
              width: double.maxFinite,
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 30,
              child: Row(
                children: [
                  buildLoveCommentCard(
                    context,
                    icon: const FaIcon(
                      FontAwesomeIcons.heart,
                      color: Colors.pink,
                      size: 16,
                    ),
                    spacer: false,
                    title: '200',
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
                    title: '100 Comments',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const Divider(),
            Row(
              children: [
                const CircleAvatar(
                  radius: 18,
                  backgroundImage: NetworkImage(
                      'https://image.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg'),
                ),
                const SizedBox(width: 15),
                Text(
                  'Write a comment ...',
                  style: Theme.of(context).textTheme.caption,
                ),
                const Spacer(),
                InkWell(
                  onTap: () {},
                  child: Row(
                    children: const [
                      FaIcon(
                        FontAwesomeIcons.heart,
                        color: Colors.pink,
                        size: 20,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text('Like')
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
    required String title,
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
                title,
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
}
