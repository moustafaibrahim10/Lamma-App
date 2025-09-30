import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/shared/components/components.dart';
import 'package:social_app/models/user_model.dart';

import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../modules/search/profile_search_screen.dart';

class FollowersScreen extends StatelessWidget {
  List<FollowModel> followers;

  FollowersScreen({required this.followers});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context, state) {
      },
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: defaultAppBar(context: context, title: "Followers"),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.separated(
              itemBuilder: (context, index) =>
                  InkWell(
                      onTap: () {
                        cubit.getUserById(followers[index].uId.toString());
                        navigateTo(context, ProfileSearchScreen());
                      },
                      child: followItem(index, followers)),
              separatorBuilder: (context, index) =>
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: myDivider(),
                  ),
              itemCount: followers.length,
            ),
          ),
        );
      },
    );
  }


}
