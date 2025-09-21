import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/core/shared/components/components.dart';
import 'package:social_app/core/shared/local/cache_helper.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/modules/login/login_screen.dart';
import 'package:social_app/modules/profile/edit_profile.dart';
import 'package:social_app/styles/icon_broken.dart';

import '../../core/utils/enums.dart';
import '../new_post/new_post_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);

        if (userModel == null)
          return const Center(child: CircularProgressIndicator());

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                height: 190,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.topCenter,
                      child: Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            topRight: Radius.circular(4.0),
                          ),
                          image: DecorationImage(
                            image: NetworkImage('${userModel?.cover}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    CircleAvatar(
                      radius: 59,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      child: CircleAvatar(
                        radius: 55,
                        backgroundImage: NetworkImage(
                          '${userModel?.image}',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),
              Text(
                " ${userModel?.name}",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 5),
              Text(
                "${userModel?.bio}",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              "100",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              "Posts",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              "289",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              "Photos",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              "10K",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              "Following",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        child: Column(
                          children: [
                            Text(
                              "69",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            Text(
                              "Following",
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        navigateTo(context, EditProfileScreen());
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text("Edit Profile", style: TextStyle(fontSize: 14),),
                        SizedBox(width: 10.0),
                        Icon(IconBroken.Edit, size: 14),
                      ],),
                    ),
                  ),
                  SizedBox(width: 10.0),
                  OutlinedButton(
                    onPressed: () {
                      cubit.changeAppMode();
                    },
                    child: Icon(Icons.brightness_4_outlined, size: 14 ),
                  ),
                  SizedBox(width: 10.0),
                  OutlinedButton(
                    onPressed: () {
                      navigateTo(context, LoginScreen());
                      CacheHelper.removeData(key: "uId").then((value){
                        if(value){
                          showToast(
                            msg: "Logout done successfully",
                            state: ToastState.success,
                          );
                        }
                      });
                    },
                    child: Icon(IconBroken.Logout, size: 14),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
