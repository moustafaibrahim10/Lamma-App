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

class UpdateUserDataLoadingState extends SocialStates{}
class UpdateUserDataSuccessState extends SocialStates{}
class UpdateUserDataErrorState extends SocialStates{}

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
//likes
class PostLikeSuccessState extends SocialStates {}

class PostLikeErrorState extends SocialStates {
  final String error;

  PostLikeErrorState(this.error);
}