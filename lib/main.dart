import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/data/data_provider/remote/notificaiton/dio_helper.dart';
import 'package:social_app/my_app.dart';
import 'package:social_app/presentation/home_layout/home_layout.dart';
import 'package:social_app/presentation/login/login_screen.dart';
import 'package:social_app/utils/bloc_observer.dart';
import 'package:social_app/utils/consistent/consistent.dart';
import 'package:social_app/utils/network/local/shared_prefrences/cached_helper.dart';

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
