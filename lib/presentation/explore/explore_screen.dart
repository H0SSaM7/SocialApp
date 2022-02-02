import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/controllers/posts_controller/posts_bloc.dart';
import 'package:social_app/presentation/explore/widgets/post_card_widget.dart';
import 'package:social_app/presentation/explore/widgets/posts_shimmer_widget.dart';
import 'package:social_app/utills/components/components.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PostsBloc, PostsState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              // cubit.getStreamPosts();
            },
            child: SingleChildScrollView(
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
                  if (state is PostsInitial)
                    ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) =>
                            const PostsShimmerWidget(),
                        separatorBuilder: (context, index) => const SizedBox(
                              height: 5.0,
                            ),
                        itemCount: 5),
                  if (state is GetPostsSuccessState)
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return PostCardWidget(
                          postId: state.postsId[index],
                          model: state.postsModel[index],
                          index: index,
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 5,
                      ),
                      itemCount: state.postsModel.length,
                    ),
                  if (state is GetPostErrorState)
                    Center(
                      child: Text(
                        state.error,
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
          );
        },
        listener: (context, state) {});
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
