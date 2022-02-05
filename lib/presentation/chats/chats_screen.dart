import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/controllers/chat_contacts_controller/chat_bloc.dart';

import 'package:social_app/data/repository/user_repo/user_repository.dart';
import 'package:social_app/models/user_model.dart';

import 'package:social_app/presentation/chat_room/chat_room_screen.dart';
import 'package:social_app/utils/components/components.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

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
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget buildChatsCard(
    UserModel user,
    BuildContext context,
  ) {
    return Card(
      elevation: 4.0,
      child: InkWell(
        onTap: () {
          navigateTo(
              context,
              ChatRoomScreen(
                userModel: user,
              ));
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
            ],
          ),
        ),
      ),
    );
  }
}
