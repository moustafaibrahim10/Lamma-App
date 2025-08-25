import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/shared/local/cache_helper.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/layout/social_layout.dart';

import 'cubit/bloc_observer.dart';
import 'modules/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp();
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
      create: (context) => SocialCubit()..getUserData()..getPosts(),
      child: MaterialApp(
        title: 'Lamma',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Colors.white,
            scrolledUnderElevation: 0.0,
          ),
          scaffoldBackgroundColor: Colors.white,
          primaryColor: AppConstants.primaryColor,
          iconTheme: IconThemeData(color: AppConstants.primaryColor),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              side: BorderSide(color: Colors.grey, width: 1),
              foregroundColor: AppConstants.primaryColor,
            ),
          ),
          progressIndicatorTheme: ProgressIndicatorThemeData(
            color: AppConstants.primaryColor,
          ),
          fontFamily: "Jannah",
          textTheme: TextTheme(
            headlineSmall: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            bodyLarge: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              height: 1.4,
            ),

            bodyMedium: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              height: 1.4,
            ),
            labelSmall: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.black45,
            ),
            titleSmall: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Colors.black45,
            ),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppConstants.primaryColor,

            elevation: 20,
          ),
        ),
        home: startWidget,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
