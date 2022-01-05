import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/shared/style/colors.dart';

Future<dynamic> navigateAndRemove(BuildContext context, Widget screen) {
  return Navigator.pushAndRemoveUntil(context,
      MaterialPageRoute(builder: (context) => screen), (route) => false);
}

Future<dynamic> navigateTo(BuildContext context, Widget screen) {
  return Navigator.push(
      context, MaterialPageRoute(builder: (context) => screen));
}

Widget buildListViewArticles(List<dynamic> articles) {
  return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(11),
          height: 135,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: getImage(
                    url: articles[index].imageUrl, height: 130, width: 130),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(articles[index].title!,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyText1),
                    const Spacer(),
                    Text(
                      articles[index].publishAt!,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              const SizedBox(
                width: 6.0,
              )
            ],
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: articles.length);
}

Widget getImage({String? url, required double width, required double height}) {
  Widget image;
  if (url == null) {
    image = Image.asset(
      'images/noImage.png',
      width: width,
      height: height,
      fit: BoxFit.fill,
    );
    return image;
  } else {
    image = Image.network(
      url,
      width: width,
      height: height,
      fit: BoxFit.fill,
    );
    return image;
  }
}

TextFormField myFormField(
    {required TextInputType type,
    bool? isObscure,
    required TextEditingController controller,
    Function()? onTap,
    required Widget icon,
    required String title,
    bool? readOnly,
    required String validateText,
    Function(String)? onChange,
    required BuildContext context,
    Widget? suffix,
    Function(String)? onSubmitted}) {
  return TextFormField(
      style: const TextStyle(
        fontSize: 16,
      ),
      onChanged: onChange,
      onFieldSubmitted: onSubmitted,
      readOnly: readOnly ?? false,
      keyboardType: type,
      obscureText: isObscure ?? false,
      controller: controller,
      onTap: onTap,
      validator: (value) {
        if (value!.isEmpty) {
          return validateText;
        } else {
          null;
        }
      },
      decoration: InputDecoration(
        suffixIcon: suffix,
        border: const OutlineInputBorder(),
        prefixIcon: icon,
        hintText: title,
        labelText: title,
        hintStyle: TextStyle(fontSize: 16, color: Colors.grey[700]),
      ));
}

Widget myElevatedButton({
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
        fixedSize: Size(
          width ?? double.maxFinite,
          height ?? 55,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            borderCircular ?? 0.0,
          ),
        ),
        primary: mainColor,
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

// profile image with edit icon on it.
Stack myProfileImage({ImageProvider? image, required Function() changeImage}) {
  return Stack(
    alignment: const Alignment(0.9, 0.9),
    children: [
      CircleAvatar(
        radius: 55,
        child: const Icon(
          Icons.person,
          size: 40,
        ),
        backgroundImage: image,
      ),
      InkWell(
        onTap: changeImage,
        child: CircleAvatar(
          radius: 13,
          backgroundColor: Colors.yellow[800],
          child: const Icon(
            Icons.edit_outlined,
            size: 12,
          ),
        ),
      )
    ],
  );
}
