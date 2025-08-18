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

class uploadProfileImageSuccessState extends SocialStates {}
class uploadProfileImageErrorState extends SocialStates {}
