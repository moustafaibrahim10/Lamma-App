import 'package:flutter/material.dart';
import 'package:social_app/core/shared/components/components.dart';
import 'package:social_app/models/user_model.dart';

class FollowersScreen extends StatelessWidget {
  List<FollowModel> followers;

  FollowersScreen({required this.followers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar(context: context, title: "Followers"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(
          itemBuilder: (context, index) => followItem(index,followers),
          separatorBuilder: (context,index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: myDivider(),
          ),
          itemCount: followers.length,
        ),
      ),
    );
  }


}
