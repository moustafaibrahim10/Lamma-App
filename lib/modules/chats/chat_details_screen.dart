import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/styles/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel user;
  TextEditingController messageController = TextEditingController();

  ChatDetailsScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(IconBroken.Arrow___Left_2),
            ),
            titleSpacing: 0.0,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage("${user.image}"),
                ),
                SizedBox(width: 15.0),
                Text(
                  "${user.name}",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Text("Hello, My friend"),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppConstants.primaryColor.withOpacity(0.25),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                    ),
                    child: Text("Hello, My friend"),
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey[300]!,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(15),


                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: messageController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Write a message...",
                          ),
                          onChanged: (value) {
                            (context as Element).markNeedsBuild();
                          },
                        ),
                      ),
                      if (messageController.text.isNotEmpty)
                        IconButton(onPressed: () {}, icon: Icon(IconBroken.Send)),
                      if (messageController.text.isEmpty)
                        Icon(IconBroken.Send, color: Colors.grey),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
