import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import '../modules/home/home_screen.dart';
import '../modules/profile/profile_screen.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(InitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  //GetUserData

  void getUserData() {
    emit(GetUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(AppConstants.uId)
        .get()
        .then((value) {
          userModel = UserModel.fromJson(value.data()!);
        })
        .catchError((error) {
          print("error");
          emit(GetUserErrorState(error.toString()));
        });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    ProfileScreen(),
  ];
  List<String> titles = ["Home", "Chats", "Posts", "Users", "Settings"];

  void chaneBottomNavIndex(int index) {
    if (index == 2)
      emit(NewPostState());
    else {
      currentIndex = index;
      emit(ChangeBottomNavBarState());
    }
  }

  XFile? profileImage;
  XFile? coverImage;
  var picker = ImagePicker();
  Future uploadProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = XFile(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else
      print("No Image Selected");
    emit(ProfileImagePickedErrorState());
  }
  Future uploadCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = XFile(pickedFile.path);
      emit(CoverImagePickedSuccessState());
    } else {
      emit(CoverImagePickedErrorState());
    }
  }

  //cloudinary
  final cloudinary = CloudinaryPublic("dadz62mgc", "lammaApp");

  Future<String?> uploadToCloudinary(
    File file, {
    required String publicId,
  }) async {
    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          file.path,
          resourceType: CloudinaryResourceType.Image,
          publicId: publicId,
        ),
      );
      return response.secureUrl;
    } on CloudinaryException catch (error) {
      print("Cloudinary error is $error");
      return null;
    }
  }

  //updateUserData
  void updateUserData({
    required String name,
    required String bio,
    required String phone,
    required String email,
  }) async
  {
    emit(UpdateUserDataLoadingState());
    var profileUrl = userModel?.image;
    var coverUrl = userModel?.cover;

    if (profileImage != null)
      profileUrl = await uploadToCloudinary(
        File(profileImage!.path),
        publicId: "users/${userModel?.uId}_profile",
      );

    if (coverImage != null)
      coverUrl = await uploadToCloudinary(
        File(coverImage!.path),
        publicId: "users/${userModel?.uId}_cover",
      );

    UserModel model = UserModel(
      uId: userModel?.uId,
      name: name,
      bio: bio,
      phone: phone,
      email: email,
      image: profileUrl,
      cover: coverUrl,
      isEmailVerified: userModel?.isEmailVerified,
      password: userModel?.password,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(AppConstants.uId)
        .update(model.toMap())
        .then((value) {
          // to apply changes
          userModel = model;
          //clean temp photos
          profileImage=null;
          coverImage=null;
          emit(UpdateUserDataSuccessState());
        })
        .catchError((error) {
          emit(UpdateUserDataErrorState());
          print(error);
        });
  }
}
