import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          return Column(
            children: [
              ConditionalBuilder(
                condition: cubit.userModel != null,
                builder: (context) {
                  return Column(
                    children: [
                      buildEmailVerifyCheck(),
                    ],
                  );
                },
                fallback: (context) {
                  return const Center(child: CircularProgressIndicator());
                },
              )
            ],
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
