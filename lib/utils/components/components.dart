import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<dynamic> navigateAndRemove(BuildContext context, Widget screen) {
  return Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => screen), (route) => false);
}

Future<dynamic> navigateTo(BuildContext context, Widget screen) {
  return Navigator.push(
      context, MaterialPageRoute(builder: (context) => screen));
}

Widget myElevatedButton(
  context, {
  Color? color,
  required Function() onPressed,
  required Widget child,
  double? width,
  double? height,
  double? borderCircular,
}) {
  return Container(
    alignment: Alignment.center,
    child: ElevatedButton(
      onPressed: onPressed,
      child: child,
      style: ElevatedButton.styleFrom(
        primary: color ?? Theme.of(context).primaryColor,
        fixedSize: Size(
          width ?? double.infinity,
          height ?? 55,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderCircular ?? 0.0,
          ),
        ),
      ),
    ),
  );
}

myToast({
  required String msg,
  required toastStates state,
}) {
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: toastColor(state),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum toastStates { success, error, warning }

Color toastColor(toastStates state) {
  switch (state) {
    case toastStates.success:
      return Colors.green;
    case toastStates.warning:
      return Colors.amber;
    case toastStates.error:
      return Colors.red;
  }
}

// settings card
Container myCard(
    {required String title,
    required IconData leadingIcon,
    required Function() onTap}) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 13, vertical: 5),
    width: double.maxFinite,
    height: 55,
    decoration: BoxDecoration(
        color: const Color(0xffe9ecef),
        borderRadius: BorderRadius.circular(25)),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(25),
      child: Row(
        children: [
          const SizedBox(width: 20),
          Icon(
            leadingIcon,
            color: const Color(0xff343a40),
          ),
          const SizedBox(width: 15),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Color(0xff212529),
            ),
          ),
          const Spacer(),
          Icon(
            Icons.adaptive.arrow_forward_outlined,
            color: const Color(0xff343a40),
          ),
          const SizedBox(
            width: 20,
          )
        ],
      ),
    ),
  );
}

mySnackBar({required String content, required BuildContext context}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}
