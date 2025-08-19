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
  var picker = ImagePicker();

  Future getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = XFile(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else
      print("No Image Selected");
    emit(ProfileImagePickedErrorState());
  }

  XFile? coverImage;

  Future getCoverImage() async {
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

  Future<String?> uploadToCloudinary(File file) async {
    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(
          file.path,
          resourceType: CloudinaryResourceType.Image,
        ),
      );
      return response.secureUrl;
    } on CloudinaryException catch (error) {
      print("Cloudinary error is $error");
      return null;
    }
  }

  //upload photo
  void uploadProfileImage() async {
    if (profileImage == null) return;

    emit(UploadProfileImageLoadingState());

    final url = await uploadToCloudinary(File(profileImage!.path));
    if (url != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(AppConstants.uId)
          .update({'image': url})
          .then((value) {
            emit(UploadProfileImageSuccessState());
          })
          .catchError((error) {
            emit(UploadProfileImageErrorState());
            print(error);
          });
    }
  }

  //uploadCoverImage
  void uploadCoverImage() async {
    if (coverImage == null) return;

    emit(UploadCoverImageLoadingState());

    final url = await uploadToCloudinary(File(coverImage!.path));
    if (url != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(AppConstants.uId)
          .update({'cover': url})
          .then((value) {
            emit(UploadCoverImageSuccessState());
          })
          .catchError((error) {
            emit(UploadCoverImageErrorState());
            print(error);
          });
    }
  }
}
