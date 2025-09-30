import 'package:flutter/material.dart';

import '../../core/shared/components/components.dart';
import '../../models/user_model.dart';

class FollowingScreen extends StatelessWidget {
  List<FollowModel> following;

   FollowingScreen({required this.following});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: defaultAppBar(context: context, title: "Followers"),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(
          itemBuilder: (context, index) => followItem(index,following),
          separatorBuilder: (context,index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: myDivider(),
          ),
          itemCount: following.length,
        ),
      ),
    );
  }
}
