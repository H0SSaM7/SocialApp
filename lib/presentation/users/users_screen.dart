import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/controllers/chats/chat_bloc.dart';
import 'package:social_app/controllers/cubit/cubit.dart';
import 'package:social_app/controllers/cubit/states.dart';
import 'package:social_app/data/repository/user_repo/user_repository.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/presentation/profile_as_visitor/profile_as_visitor_screen.dart';

import 'package:social_app/utills/components/components.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            ChatBloc(userRepository: UserRepository())..add(const ChatEvent()),
        child: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            if (state is ChatInitial) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (state is ChatLoaded) {
              return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return buildChatsCard(
                      state.users[index],
                      context,
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 5.0,
                      ),
                  itemCount: state.users.length);
            } else if (state is ChatError) {
              return const Center(
                  child: Text('Some Thing went Wrong , Please try Again'));
            }
            return const SizedBox();
          },
        ));
  }

  Widget buildChatsCard(UserModel user, BuildContext context) {
    return Card(
      elevation: 4.0,
      child: InkWell(
        onTap: () {
          navigateTo(
            context,
            ProfileScreenAsVisitor(userId: user.uId!),
          );
        },
        child: SizedBox(
          height: 90,
          child: Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              // profile image -----------------------
              CircleAvatar(
                  radius: 26,
                  backgroundImage: NetworkImage(user.profileImage!)),
              const SizedBox(width: 15),
              Text(
                user.name!,
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const Spacer(),
              myElevatedButton(
                context,
                onPressed: () {},
                child: const Text('Follow'),
                borderCircular: 17,
                height: 33,
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
