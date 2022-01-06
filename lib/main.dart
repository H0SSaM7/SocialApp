import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_app/layouts/home_layout.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/shared/bloc_observer.dart';
import 'package:social_app/shared/consistent/consistent.dart';
import 'package:social_app/shared/cubit/cubit.dart';
import 'package:social_app/shared/network/local/shared_prefrences/cached_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () async {
      await Firebase.initializeApp();
      await CachedHelper.init();
      uId = CachedHelper.getPref(key: 'uId');
      firstPage() {
        if (uId == null) {
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
  const MyApp({Key? key, this.page}) : super(key: key);
  final Widget? page;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SocialCubit()..getUserDate(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: FlexColorScheme.light(
                fontFamily: GoogleFonts.ptSans().fontFamily,
                scheme: FlexScheme.bahamaBlue)
            .toTheme,
        darkTheme: FlexColorScheme.dark(
                fontFamily: GoogleFonts.ptSans().fontFamily,
                scheme: FlexScheme.bahamaBlue)
            .toTheme,
        themeMode: ThemeMode.dark,
        home: page,
      ),
    );
  }
}
