import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/shared/components/components.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/core/utils/enums.dart';
import 'package:social_app/cubit/cubit.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SocialCubit cubit = SocialCubit.get(context);
    TextEditingController nameController = TextEditingController();
    TextEditingController bioController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    nameController.text = userModel?.name.toString() ?? "Name";
    bioController.text = userModel?.bio.toString() ?? "Bio";
    phoneController.text = userModel?.phone.toString() ?? "Phone";
    emailController.text = userModel?.email.toString() ?? "Email";

    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if(state is UpdateUserDataSuccessState)
          showToast(msg: "Profile Updated Successfully", state: ToastState.success);

        if(state is UpdateUserDataErrorState)
          showToast(msg: "Something went wrong!, try again", state: ToastState.error);

      },
      builder: (context, state) {
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: "Edit Profile",
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: defaultTextbutton(
                  text: 'Update',
                  function: () {
                    cubit.updateUserData(
                      name: nameController.text,
                      bio: bioController.text,
                      phone: phoneController.text,
                      email: emailController.text
                    );
                  },
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if (state is UpdateUserDataLoadingState)
                    LinearProgressIndicator(),
                  SizedBox(height: 10),
                  Container(
                    height: 190,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 140,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                  image: DecorationImage(
                                    image:
                                        cubit.coverImage == null
                                            ? NetworkImage('${userModel?.cover}')
                                            : FileImage(
                                              File(cubit.coverImage!.path),
                                            ),
                                    fit: BoxFit.cover,
                                  ),
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
                                        cubit.uploadCoverImage();
                                      },
                                      icon: Icon(
                                        IconBroken.Camera,
                                        color: Colors.white,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 59,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 55,
                                backgroundImage:
                                    cubit.profileImage == null
                                        ? NetworkImage('${userModel?.image}')
                                        : FileImage(
                                          File(cubit.profileImage!.path),
                                        ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 5.0, top: 5),
                              child: CircleAvatar(
                                radius: 18,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  backgroundColor: Colors.lightBlueAccent,
                                  radius: 16,
                                  child: IconButton(
                                    onPressed: () {
                                      cubit.uploadProfileImage();
                                    },
                                    icon: Icon(
                                      IconBroken.Camera,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  defaultTextFormField(
                    controller: nameController,
                    labelText: "Your name",
                    icon: IconBroken.User,
                    validate: (value) {
                      if (value.isEmpty || value == null) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  defaultTextFormField(
                    controller: bioController,
                    labelText: "Bio",
                    icon: IconBroken.Paper,
                    validate: (value) {
                      if (value.isEmpty || value == null) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  defaultTextFormField(
                    controller: emailController,
                    labelText: "email",
                    icon: IconBroken.Message,
                    validate: (value) {
                      if (value.isEmpty || value == null) {
                        return "Phone must not be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  defaultTextFormField(
                    controller: phoneController,
                    labelText: "Phone",
                    icon: IconBroken.Call,
                    validate: (value) {
                      if (value.isEmpty || value == null) {
                        return "Phone must not be empty";
                      }
                      return null;
                    },
                  ),

                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
