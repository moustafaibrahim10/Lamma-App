import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/shared/components/components.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/core/utils/enums.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController newPostController = TextEditingController();

    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is CreatePostSuccessState)
          {
            newPostController.clear();
            SocialCubit.get(context).removeNewPostImage();
            showToast(msg: "Post Created Successfully", state: ToastState.success);
            Navigator.pop(context);
          }
      },
      builder: (context, state) {
        SocialCubit cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: defaultAppBar(

            context: context,
            title: "Create Post",
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: defaultTextbutton(text: "Post", function: () {
                  cubit.createNewPost(
                    text: newPostController.text,
                    dateTime: DateTime.now().toString()
                  );
                  cubit.getPosts();
                  cubit.chaneBottomNavIndex(0);
                }),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is CreatePostLoadingState)
                  LinearProgressIndicator(),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        userModel!.image.toString() ?? "https://i.pinimg.com/736x/82/0e/ea/820eea066798dd89e782dae4076b5684.jpg",
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                userModel!.name.toString(),
                                style: TextStyle(height: 0.7),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.check_circle,
                                color: Colors.blue,
                                size: 15,
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Public",
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 15),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.more_horiz, size: 17),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "What is in your mind ..... ",
                      border: InputBorder.none,
                    ),
                    controller: newPostController,
                    maxLines: null,
                    cursorColor: AppConstants.primaryColor ,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "text must not be empty";
                      }
                      return null;
                    },

                  ),
                ),
                if(cubit.newPostImage != null )
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        image: DecorationImage(
                          image: FileImage(File(cubit.newPostImage!.path)),
                        )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 5.0,
                        top: 5,
                      ),
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          backgroundColor: Colors.lightBlueAccent,
                          radius: 16,
                          child: IconButton(
                            onPressed: () {
                              cubit.removeNewPostImage();

                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              cubit.getPostImage();
                            },
                            child: Row(
                              children: [
                                Icon(
                                  IconBroken.Image,
                                  color: Theme.of(context).primaryColor,
                                  size: 20,
                                ),
                                SizedBox(width: 5.0),
                                Text(
                                  "add photo",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "# tags",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
