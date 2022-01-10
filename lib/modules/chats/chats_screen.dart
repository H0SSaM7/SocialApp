import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({Key? key}) : super(key: key);

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
                  separatorBuilder: (context, index) => const Divider(),
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

  InkWell buildChatsCard(SocialCubit cubit, BuildContext context, int index) {
    return InkWell(
      onTap: () {},
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
          ],
        ),
      ),
    );
  }
}
