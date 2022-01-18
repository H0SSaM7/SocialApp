import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_app/layouts/home_layout.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/shared/bloc_observer.dart';
import 'package:social_app/shared/consistent/consistent.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/cubit/states.dart';
import 'package:social_app/shared/network/local/shared_prefrences/cached_helper.dart';
import 'package:social_app/shared/network/remote/dio_helper.dart';

Future<void> backGroundMessage(RemoteMessage message) async {
  // print(message.data.toString() + 'ONBACKGROUND');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // var token = await FirebaseMessaging.instance.getToken();
  // print(token.toString());
  FirebaseMessaging.onMessage.listen((event) {
    // print(event.data);
  }).onError((error) {
    debugPrint(error.toString());
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    // print(event.data);
  }).onError((error) {
    debugPrint(error.toString());
  });

  FirebaseMessaging.onBackgroundMessage(backGroundMessage);

  BlocOverrides.runZoned(
    () async {
      await CachedHelper.init();
      await DioHelper.init();
      currentUserId = CachedHelper.getPref(key: 'uId');

      firstPage() {
        if (currentUserId == null) {
          return const LoginScreen();
        } else {
          return const HomeLayout();
        }
      }

      runApp(MyApp(
        page: firstPage(),
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    this.page,
  }) : super(key: key);
  final Widget? page;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialCubit()
        ..getUserDate()
        ..getStreamPosts(),
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: FlexColorScheme.light(
              textTheme: const TextTheme(
                  bodyText1: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                  caption: TextStyle(fontSize: 12.5)),
              fontFamily: GoogleFonts.ptSans().fontFamily,
              scheme: FlexScheme.bigStone,
            ).toTheme,
            darkTheme: FlexColorScheme.dark(
              textTheme: const TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              fontFamily: GoogleFonts.ptSans().fontFamily,
              scheme: FlexScheme.bigStone,
            ).toTheme,
            themeMode: SocialCubit.get(context).isDarkTheme
                ? ThemeMode.dark
                : ThemeMode.light,
            home: page,
          );
        },
      ),
    );
  }
}
