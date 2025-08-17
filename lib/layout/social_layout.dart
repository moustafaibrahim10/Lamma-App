import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/shared/components/components.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/core/utils/enums.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is NewPostState) {
         navigateTo(context, NewPostScreen());
        }
      },
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);
        print(FirebaseAuth.instance.currentUser!.emailVerified);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              cubit.titles[cubit.currentIndex],
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(IconBroken.Notification)),
              IconButton(onPressed: () {}, icon: Icon(IconBroken.Search)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.chaneBottomNavIndex(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Chat),
                label: "Chat",
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Paper_Upload),
                label: "Post",
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Location),
                label: "Users",
              ),
              BottomNavigationBarItem(
                icon: Icon(IconBroken.Profile),
                label: "Profile",
              ),
            ],
          ),
        );
      },
    );
  }
}
