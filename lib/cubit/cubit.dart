import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/services/location_service.dart';
import 'package:social_app/core/utils/app_constants.dart';
import 'package:social_app/cubit/states.dart';
import 'package:social_app/models/chat_model.dart';
import 'package:social_app/models/comment_model.dart';
import 'package:social_app/models/post_model.dart';
import 'package:social_app/models/user_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/new_post/new_post_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import '../modules/home/home_screen.dart';
import '../modules/profile/profile_screen.dart';

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
          emit(GetUserSuccessState());
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

  void chaneBottomNavIndex(int index) async {
    if (index == 1) {
      getAllUsers();
      LocationService locationService = LocationService();
      try {
        var pos = await locationService.getUserLocation();
        if (pos != null) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(AppConstants.uId)
              .update({"lat": pos.latitude, "long": pos.longitude});
          emit(UpdateUserLocationSuccessState());
        }
      } catch (e) {
        emit(UpdateUserLocationErrorState(e.toString()));
      }
    }
    if (index == 2) {
      getPosts();
    }
    ;
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
    } else {
      print("No Image Selected");
      emit(ProfileImagePickedErrorState());
    }
  }

  XFile? coverImage;

  Future getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = XFile(pickedFile.path);
      emit(CoverImagePickedSuccessState());
    } else {
      print("No Image Selected");
      emit(CoverImagePickedErrorState());
    }
  }

  //cloudinary
  final cloudinary = CloudinaryPublic("dadz62mgc", "lammaApp");

  Future<String?> uploadToCloudinary(File file, {d}) async {
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

  void updateProfileImage() async {
    if (profileImage == null) return;
    emit(UploadProfileImageLoadingState());
    final imageUrl = await uploadToCloudinary(File(profileImage!.path));
    FirebaseFirestore.instance
        .collection('users')
        .doc(AppConstants.uId)
        .update({'image': imageUrl})
        .then((value) {
          userModel = userModel?.copyWith(image: imageUrl);
          emit(UploadProfileImageSuccessState());
          profileImage = null;
        })
        .catchError((error) {
          emit(UploadProfileImageErrorState());
          print(error);
        });
  }

  void updateCoverImage() async {
    if (coverImage == null) return;
    emit(UploadCoverImageLoadingState());
    final coverUrl = await uploadToCloudinary(File(coverImage!.path));
    FirebaseFirestore.instance
        .collection('users')
        .doc(AppConstants.uId)
        .update({'cover': coverUrl})
        .then((value) {
          userModel = userModel?.copyWith(cover: coverUrl);
          emit(UploadCoverImageSuccessState());
          coverImage = null;
        })
        .catchError((error) {
          emit(UploadCoverImageErrorState());
          print(error);
        });
  }

  //updateUserData
  void updateUserData({
    required String name,
    required String bio,
    required String phone,
    required String email,
  }) async {
    emit(UpdateUserDataLoadingState());

    UserModel model = userModel!.copyWith(
      name: name,
      nameLower: name.toLowerCase(),
      bio: bio,
      phone: phone,
      email: email,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .update(model.toMap())
        .then((value) {
          // to apply changes
          userModel = model;
          //clean temp photos
          profileImage = null;
          coverImage = null;
          emit(UpdateUserDataSuccessState());
        })
        .catchError((error) {
          emit(UpdateUserDataErrorState());
          print(error);
        });
  }

  //create post

  XFile? newPostImage;

  Future getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      newPostImage = XFile(pickedFile.path);
      emit(PostImagePickedSuccessState());
    } else {
      print("No Image Selected");
      emit(PostImagePickedErrorState());
    }
  }

  void removeNewPostImage() {
    newPostImage = null;
    emit(RemoveNewPostImageState());
  }

  String? postImage;

  void createNewPost({required String dateTime, required String text}) async {
    emit(CreatePostLoadingState());

    if (newPostImage != null) {
      postImage = await uploadToCloudinary(File(newPostImage!.path));
    }
    PostModel postModel = PostModel(
      name: userModel?.name,
      image: userModel?.image,
      uId: userModel?.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? null,
    );
    FirebaseFirestore.instance
        .collection("posts")
        .add(postModel.toMap())
        .then((value) {
          emit(CreatePostSuccessState());
        })
        .catchError((error) {
          emit(CreatePostErrorState());
        });
  }

  List<PostModel> posts = [];
  List<PostModel> myPosts = [];
  List<String> postsIds = [];
  List<int> likes = [];
  List<bool> isLiked = [];

  void getPosts() {
    emit(GetPostsLoadingState());
    posts.clear();
    myPosts.clear();
    postsIds.clear();
    likes.clear();
    isLiked.clear();
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value) {
          value.docs.forEach((element) {
            element.reference
                .collection('likes')
                .get()
                .then((value) {
                  emit(GetPostsSuccessState());
                  postsIds.add(element.id);
                  likes.add(value.docs.length);
                  posts.add(PostModel.fromJson(element.data()));
                  if (element.data()['uId'] == userModel?.uId)
                    myPosts.add(PostModel.fromJson(element.data()));
                  getComments(element.id);
                  final postLikes = value.docs.map((e) => e.id);
                  isLiked.add(postLikes.contains(userModel?.uId));
                })
                .catchError((error) {});
          });
        })
        .catchError((error) {
          emit(GetUserErrorState(error));
        });
  }

  List<PostModel> targetUserPosts = [];

  void getTargetUserPosts({required String targetUid}) {
    emit(GetTargetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .where('uId', isEqualTo: targetUid)
        .get()
        .then((value) {
          targetUserPosts.clear();
          value.docs.forEach((element) {
            targetUserPosts.add(PostModel.fromJson(element.data()));
            emit(GetTargetPostsSuccessState());
          });
        })
        .catchError((error) {
          emit(GetTargetPostsErrorState(error));
        });
  }

  void likePost(String postId, index) {
    final likeRef = FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel?.uId);

    likeRef
        .get()
        .then((value) {
          if (value.exists) {
            final currentLike = value.data()?['like'] ?? false;
            likeRef.update({"like": !currentLike});
            isLiked[index] = !currentLike;
            if (!currentLike) {
              likes[index]++;
            } else {
              likes[index]--;
            }
            emit(PostLikeSuccessState());
          } else {
            likeRef.set({"like": true});
            isLiked[index] = true;
            likes[index]++;
            emit(PostLikeSuccessState());
          }
        })
        .catchError((error) {
          emit(PostLikeErrorState(error));
        });
  }

  void commentPost(String postId, String comment) {
    CommentModel commentModel = CommentModel(
      userModel?.name,
      userModel?.image,
      userModel?.uId,
      comment,
      DateTime.now(),
    );
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection("comments")
        .add(commentModel.toMap())
        .then((value) {
          emit(PostCommentSuccessState());
        })
        .catchError((error) {
          emit(PostCommentErrorState(error));
        });
  }

  Map<String, List<CommentModel>> comments = {};

  void getComments(String postId) {
    emit(GetPostCommentLoadingState());
    comments[postId] = [];
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('date')
        .snapshots()
        .listen((event) {
          comments[postId] =
              event.docs.map((e) => CommentModel.fromJson(e.data())).toList();
          emit(GetPostCommentSuccessState());
        });
  }

  //Get All Users
  List<UserModel> users = [];

  void getAllUsers() {
    emit(GetAllUsersLoadingState());

    if (users.length == 0)
      FirebaseFirestore.instance
          .collection('users')
          .get()
          .then((value) {
            value.docs.forEach((element) {
              if (element.id != userModel?.uId)
                users.add(UserModel.fromJson(element.data()));
            });
            emit(GetAllUsersSuccessState());
          })
          .catchError((error) {
            emit(GetAllUsersErrorState(error));
          });
  }

  void sendMessage({required String receiverId, required String text}) {
    ChatModel model = ChatModel(
      dateTime: Timestamp.now(),
      receiverId: receiverId,
      senderId: userModel?.uId,
      text: text,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
          emit(SendMessageSuccessState());
        })
        .catchError((error) {
          emit(SendMessageErrorState(error));
        });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel?.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
          emit(ReceiveMessageSuccessState());
        })
        .catchError((error) {
          emit(ReceiveMessageErrorState(error));
        });
  }

  List<ChatModel> messages = [];

  void getMessages({required String receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
          messages = [];
          event.docs.forEach((element) {
            messages.add(ChatModel.fromJson(element.data()));
          });
          emit(GetMessageSuccessState());
        });
  }

  List<UserModel> userSearch = [];

  Future<void> searchUser(String name) async {
    userSearch.clear();
    emit(SearchLoadingState());
    String searchName = name.toLowerCase();
    final snapShot = await FirebaseFirestore.instance
        .collection('users')
        .where('nameLower', isGreaterThanOrEqualTo: searchName)
        .where('nameLower', isLessThanOrEqualTo: searchName + '\uf8ff')
        .get()
        .then((value) {
          value.docs.forEach((element) {
            if (element.id != userModel?.uId)
              userSearch.add(UserModel.fromJson(element.data()));
          });
          emit(SearchSuccessState());
        })
        .catchError((error) {
          emit(SearchErrorState());
        });
  }

  bool isDark = false;

  void changeAppMode() {
    isDark = !isDark;
    emit(ChangeAppModeState());
  }

  bool isFollow = false;

  void followUser({required UserModel targetUser}) async {
    emit(FollowUserLoadingState());
    FollowModel newFollowing = FollowModel(
      uId: targetUser.uId,
      name: targetUser.name,
      image: targetUser.image,
    );
    FollowModel newFollower = FollowModel(
      uId: userModel?.uId,
      name: userModel?.name,
      image: userModel?.image,
    );
    bool isCurrentlyFollowing =
        userModel?.following?.any((f) => f.uId == targetUser.uId) ?? false;

    try {
      //unFollow user
      if (isCurrentlyFollowing) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userModel?.uId)
            .update({
              'following': FieldValue.arrayRemove([newFollowing.toMap()]),
            });

        FirebaseFirestore.instance
            .collection('users')
            .doc(targetUser.uId)
            .update({
              "followers": FieldValue.arrayRemove([newFollower.toMap()]),
            });
        List<FollowModel> updateFollowing = userModel?.following ?? [];
        updateFollowing.removeWhere((f) => f.uId == targetUser.uId);
        userModel = userModel?.copyWith(following: updateFollowing);
        emit(UnfollowUserSuccessState());
      } else {
        //Follow user
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userModel?.uId)
            .update({
              'following': FieldValue.arrayUnion([newFollowing.toMap()]),
            });

        await FirebaseFirestore.instance
            .collection('users')
            .doc(targetUser.uId)
            .update({
              "followers": FieldValue.arrayUnion([newFollower.toMap()]),
            });
        List<FollowModel> updateFollowing = userModel?.following ?? [];
        updateFollowing.add(newFollowing);
        userModel = userModel?.copyWith(following: updateFollowing);
        emit(FollowUserSuccessState());
      }
    } catch (error) {
      print("Error following user: $error");
      emit(FollowUserErrorState(error.toString()));
    }

    getUserById(targetUser.uId.toString());
  }

  List<String> profileStack = [];
  UserModel? profileModel;

  Future<void> getUserById(String uId) async {
    try {
      var snapShot =
          await FirebaseFirestore.instance.collection('users').doc(uId).get();
      profileModel = UserModel.fromJson(snapShot.data()!);
      profileStack.add(uId);
      getTargetUserPosts(targetUid: uId);
      emit(GetUserByIdSuccessState());
    } catch (e) {
      emit(GetUserByIdErrorState(e.toString()));
    }
  }

  void removeLastItem() async {
    if (profileStack.isNotEmpty) {
      profileStack.removeLast();
      if (profileStack.isNotEmpty) {
        await getUserById(profileStack.last);
      }

      emit(RemoveLastItemState());
    }
  }

  void deletePost({required String postId}) async {
    emit(DeletePostLoadingState());

    try {
      print("Deleting post with ID: $postId");

      await FirebaseFirestore.instance
          .collection("posts")
          .doc(postId)
          .delete();


      int postIndex = postsIds.indexOf(postId);
      PostModel? postToDelete;

      if (postIndex != -1) {
        postToDelete = posts[postIndex];

        if (postToDelete != null) {
          myPosts.remove(postToDelete);
        }

        postsIds.removeAt(postIndex);
        posts.removeAt(postIndex);

        if (postIndex < likes.length) {
          likes.removeAt(postIndex);
          isLiked.removeAt(postIndex);
        }
      }
      getPosts();
      emit(DeletePostSuccessState());

    } catch (error) {
      print("Firebase Delete Error: $error");
      emit(DeletePostErrorState());
    }
  }

}
