import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/search/profile_search_screen.dart';

import '../core/shared/components/components.dart';
import '../cubit/cubit.dart';
import '../cubit/states.dart';
import '../models/user_model.dart';

class FollowingScreen extends StatelessWidget {
  List<FollowModel> following;

  FollowingScreen({required this.following});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: defaultAppBar(context: context, title: "Following"),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.separated(
              itemBuilder:
                  (context, index) => InkWell(
                    onTap: () {
                      cubit.getUserById(following[index].uId.toString());
                      navigateTo(context, ProfileSearchScreen());
                    },
                    child: followItem(index, following),
                  ),
              separatorBuilder:
                  (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: myDivider(),
                  ),
              itemCount: following.length,
            ),
          ),
        );
      },
    );
  }
}
