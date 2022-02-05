import 'package:flutter/material.dart';

class MyProfileImage extends StatelessWidget {
  const MyProfileImage({
    Key? key,
    this.image,
    this.changeImageTap,
    required this.enableEdit,
    required this.radius,
  }) : super(key: key);
  final double radius;
  final bool enableEdit;
  final VoidCallback? changeImageTap;
  // ignore: prefer_typing_uninitialized_variables
  final image;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      radius: radius + 4,
      child: Stack(
        alignment: const Alignment(0.9, 0.9),
        children: [
          CircleAvatar(
            backgroundImage: image,
            radius: radius,
            child: image == null
                ? const Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.white,
                  )
                : null,
          ),
          enableEdit
              ? InkWell(
                  onTap: changeImageTap,
                  child: const CircleAvatar(
                    radius: 13,
                    child: Icon(
                      Icons.edit_outlined,
                      size: 12,
                    ),
                  ))
              : const SizedBox()
        ],
      ),
    );
  }
}
