abstract class SocialStates {}

class InitialState extends SocialStates {}

//GetUserData
class GetUserLoadingState extends SocialStates {}

class GetUserSuccessState extends SocialStates {}

class GetUserErrorState extends SocialStates {
  final String error;

  GetUserErrorState(this.error);
}

//BottomNavBar
class ChangeBottomNavBarState extends SocialStates {}

class NewPostState extends SocialStates {}

class ProfileImagePickedSuccessState extends SocialStates {}

class ProfileImagePickedErrorState extends SocialStates {}

class CoverImagePickedSuccessState extends SocialStates {}

class CoverImagePickedErrorState extends SocialStates {}

class UploadProfileImageLoadingState extends SocialStates {}

class UploadProfileImageSuccessState extends SocialStates {}

class UploadProfileImageErrorState extends SocialStates {}

class UploadCoverImageLoadingState extends SocialStates {}

class UploadCoverImageSuccessState extends SocialStates {}

class UploadCoverImageErrorState extends SocialStates {}

class UpdateUserDataLoadingState extends SocialStates {}

class UpdateUserDataSuccessState extends SocialStates {}

class UpdateUserDataErrorState extends SocialStates {}

class PostImagePickedSuccessState extends SocialStates {}

class PostImagePickedErrorState extends SocialStates {}

class CreatePostLoadingState extends SocialStates {}

class CreatePostSuccessState extends SocialStates {}

class CreatePostErrorState extends SocialStates {}

class RemoveNewPostImageState extends SocialStates {}

//Get Posts
class GetPostsLoadingState extends SocialStates {}

class GetPostsSuccessState extends SocialStates {}

class GetPostsErrorState extends SocialStates {
  final String error;

  GetPostsErrorState(this.error);
}

class GetTargetPostsLoadingState extends SocialStates {}

class GetTargetPostsSuccessState extends SocialStates {}

class GetTargetPostsErrorState extends SocialStates {
  final String error;

  GetTargetPostsErrorState(this.error);
}

//likes
class PostLikeSuccessState extends SocialStates {}

class PostLikeErrorState extends SocialStates {
  final String error;

  PostLikeErrorState(this.error);
}

class PostCommentSuccessState extends SocialStates {}

class PostCommentErrorState extends SocialStates {
  final String error;

  PostCommentErrorState(this.error);
}

class GetPostCommentLoadingState extends SocialStates {}

class GetPostCommentSuccessState extends SocialStates {}

class GetPostCommentErrorState extends SocialStates {
  final String error;

  GetPostCommentErrorState(this.error);
}

//Get All Users
class GetAllUsersLoadingState extends SocialStates {}

class GetAllUsersSuccessState extends SocialStates {}

class GetAllUsersErrorState extends SocialStates {
  final String error;

  GetAllUsersErrorState(this.error);
}

//Send Message
class SendMessageSuccessState extends SocialStates {}

class SendMessageErrorState extends SocialStates {
  final String error;

  SendMessageErrorState(this.error);
}

//Receive Message
class ReceiveMessageSuccessState extends SocialStates {}

class ReceiveMessageErrorState extends SocialStates {
  final String error;

  ReceiveMessageErrorState(this.error);
}

//Get Messages
class GetMessageSuccessState extends SocialStates {}

//Location
class UpdateUserLocationSuccessState extends SocialStates {}

class UpdateUserLocationErrorState extends SocialStates {
  final String error;

  UpdateUserLocationErrorState(this.error);
}

//search
class SearchLoadingState extends SocialStates {}

class SearchSuccessState extends SocialStates {}

class SearchErrorState extends SocialStates {}

//change app mode
class ChangeAppModeState extends SocialStates {}

//follow
class FollowUserLoadingState extends SocialStates {}

class FollowUserSuccessState extends SocialStates {}

class FollowUserErrorState extends SocialStates {
  FollowUserErrorState(String string);
}
