import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/controllers/user_controller/user_bloc.dart';
import 'package:social_app/presentation/explore/widgets/post_card_widget.dart';
import 'package:social_app/presentation/user_profile/widgets/user_properties_widget.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      context.read<UserBloc>().add(LoadedUserPostsEvent());
      return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        if (state is UserLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is UserLoadedState) {
          return SingleChildScrollView(
            child: Container(
              color: Theme.of(context).hoverColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserPropertiesWidget(state: state),
                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(30)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          child: Text(
                            'Posts',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        if (state.user.posts!.isEmpty)
                          const SizedBox(
                            height: 120,
                          ),
                        if (state.user.posts!.isEmpty)
                          Text(
                            'You have no posts yet',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        if (state.userPosts.isNotEmpty)
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return PostCardWidget(
                                model: state.userPosts[index],
                                postId: state.user.posts![index],
                              );
                            },
                            itemCount: state.userPosts.length,
                          )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        } else if (state is UserErrorState) {
          showDialog(
            context: (context),
            builder: (context) => AlertDialog(
              content: SizedBox(
                height: 100,
                width: 100,
                child: Center(
                  child: Text(
                    state.error,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
              ),
            ),
          );
        }
        return Container();
      });
    });
  }
}
