import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/controllers/posts_controller/posts_bloc.dart';
import 'package:social_app/presentation/explore/widgets/advertise_card.dart';
import 'package:social_app/presentation/explore/widgets/post_card_widget.dart';
import 'package:social_app/presentation/explore/widgets/posts_shimmer_widget.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsBloc, PostsState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            // cubit.getStreamPosts();
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const AdvertiseCard(),
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
    );
  }
}
