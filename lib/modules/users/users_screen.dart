import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/chat_room/chat_room_screen.dart';
import 'package:social_app/modules/profile_as_visitor/profile_as_visitor_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);
        return ConditionalBuilder(
            condition: cubit.users.isNotEmpty,
            builder: (context) {
              return ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return buildChatsCard(cubit, context, index);
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 5.0,
                      ),
                  itemCount: cubit.users.length);
            },
            fallback: (context) => const Center(
                  child: CircularProgressIndicator.adaptive(
                    strokeWidth: 3,
                  ),
                ));
      },
    );
  }

  Widget buildChatsCard(SocialCubit cubit, BuildContext context, int index) {
    return Card(
      elevation: 4.0,
      child: InkWell(
        onTap: () {
          navigateTo(
            context,
            ProfileScreenAsVisitor(userId: cubit.users[index].uId!),
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
                  backgroundImage:
                      NetworkImage(cubit.users[index].profileImage!)),
              const SizedBox(width: 15),
              Text(
                cubit.users[index].name!,
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
