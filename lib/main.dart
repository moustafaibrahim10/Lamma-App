import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:social_app/core/shared/local/cache_helper.dart';
import 'package:social_app/core/styles.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/layout/social_layout.dart';

import 'core/services/location_service.dart';
import 'cubit/bloc_observer.dart';
import 'modules/login/login_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart'; // 👈
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/shared/local/cache_helper.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/layout/social_layout.dart';
import 'cubit/bloc_observer.dart';
import 'modules/login/login_screen.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  LocationService locationService = LocationService();
  try {
    await locationService.getUserLocation();
  } catch (e) {
    print("error is $e");
  }
  await Firebase.initializeApp();
  FirebaseMessaging.instance.requestPermission();

  const AndroidInitializationSettings androidInitializationSettings =
  AndroidInitializationSettings('@mipmap/ic_launcher');
  await flutterLocalNotificationsPlugin.initialize(
    InitializationSettings(android: androidInitializationSettings),
  );

  //App is open -- Foreground
  FirebaseMessaging.onMessage
      .listen((event) {
    print(event.data.toString());
    flutterLocalNotificationsPlugin.show(
      0,
      event.notification?.title,
      event.notification?.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'default_channel',
          "Default",
          channelDescription:
          'This channel is used for important notifications.',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
    );
  })
      .onError((error) {
    print("error is $error");
  });

  //Detect click on notification and open app from background
  FirebaseMessaging.onMessageOpenedApp
      .listen((event) {
    print("onMessageOpenedApp");
  })
      .onError((error) {
    print(error);
  });

  //Background
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await CacheHelper.init();
  AppConstants.uId = CacheHelper.getData(key: "uId");

  Widget widget = LoginScreen();
  if (AppConstants.uId != null) {
    widget = SocialLayout();
  }

  runApp(MyApp(startWidget: widget));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  const MyApp({super.key, required this.startWidget});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
      SocialCubit()
        ..getUserData()
        ..getPosts(),
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {
        },
        builder: (context, state) {
          SocialCubit cubit = SocialCubit.get(context);
          return MaterialApp(
            theme:cubit.isDark ? darkTheme : lightTheme,
            home: startWidget,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
