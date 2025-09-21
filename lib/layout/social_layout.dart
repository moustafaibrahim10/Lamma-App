import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
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
import 'package:social_app/modules/search/search_screen.dart';
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
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text(
              cubit.titles[cubit.currentIndex],
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            actions: [
              IconButton(onPressed: () {
              }, icon: Icon(IconBroken.Notification,color: Colors.blue,)),
              IconButton(onPressed: () {
                navigateTo(context, SearchScreen());

              }, icon: Icon(IconBroken.Search,color: Colors.blue)),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: ConvexAppBar(
            style: TabStyle.flip,
            height: 40,
            onTap: (index) {
              cubit.chaneBottomNavIndex(index);
            },
            color: Colors.grey,
          elevation: 4.0,
            activeColor: Colors.blue,
            initialActiveIndex: cubit.currentIndex,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            items: [
              TabItem(
                icon: Icon(IconBroken.Home,),
                title: "Home",
              ),
              TabItem(
                icon: Icon(IconBroken.Chat,),
                title: "Chat",
              ),
              TabItem(
                icon: Icon(IconBroken.Paper_Upload),
                title: "Post",
              ),
              TabItem(
                icon: Icon(IconBroken.Location,),
                title: "Users",
              ),
              TabItem(
                icon: Icon(IconBroken.Profile),
                title: "Profile",
              ),
            ],
          ),
        );
      },
    );
  }
}
