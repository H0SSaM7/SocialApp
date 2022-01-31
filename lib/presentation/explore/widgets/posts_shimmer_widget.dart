import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shimmer/shimmer.dart';
import 'package:social_app/controllers/theme_controller/theme_cubit.dart';

class PostsShimmerWidget extends StatelessWidget {
  const PostsShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Shimmer(
        gradient: LinearGradient(
          colors: BlocProvider.of<ThemeCubit>(context).isDarkTheme
              ? [
                  Colors.grey.shade700,
                  Colors.grey.shade800,
                ]
              : [Colors.grey.shade200, Colors.grey.shade300],
        ),
        child: SizedBox(
          height: 300,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildTopShimmerPosts(),
              Expanded(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Padding buildTopShimmerPosts() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 2,
      ),
      child: Row(
        children: [
// profile image -----------------------
          const CircleAvatar(
            backgroundColor: Colors.white,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 10,
                    color: Colors.white,
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                width: 50,
                height: 10,
                color: Colors.white,
              ),
            ],
          ),
          const Spacer(),
          const Icon(
            Icons.more_horiz,
            color: Colors.white,
            size: 30,
          ),
        ],
      ),
    );
  }
}
