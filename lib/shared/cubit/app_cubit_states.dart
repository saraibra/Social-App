abstract class AppCubitStates {}
class InitalState extends AppCubitStates{}
class GetUserSuccessLoadingState extends AppCubitStates{}
class GetUserSuccessState extends AppCubitStates{}

class GetUserErrorState extends AppCubitStates{
  final String error;

  GetUserErrorState(this.error);
}
class ChangeBottomNavState extends AppCubitStates{}
class NewPostState extends AppCubitStates{}
class ProfileImageSuccessState extends AppCubitStates{}

class ProfileImageErrorState extends AppCubitStates{
  final String error;

  ProfileImageErrorState(this.error);
}
class ProfileCoverSuccessState extends AppCubitStates{}

class ProfileCoverErrorState extends AppCubitStates{
  final String error;

  ProfileCoverErrorState(this.error);
}
class UserUpdateLoadingState extends AppCubitStates{}

class UserUpdateErrorState extends AppCubitStates{
  final String error;

  UserUpdateErrorState(this.error);
}
class CreatePostSuccessState extends AppCubitStates{}
class CreatePostLoadingState extends AppCubitStates{}

class CreatePostErrorState extends AppCubitStates{
  final String error;

  CreatePostErrorState(this.error);
}
class PostImageSuccessState extends AppCubitStates{}

class PostImageErrorState extends AppCubitStates{
  final String error;

  PostImageErrorState(this.error);
}
class RemovePostImageSuccessState extends AppCubitStates{}
class GetPostsSuccessLoadingState extends AppCubitStates{}
class GetPostsSuccessState extends AppCubitStates{}

class GetPostsErrorState extends AppCubitStates{
  final String error;

  GetPostsErrorState(this.error);
}
class LikePostsSuccessState extends AppCubitStates{}

class LikePostsErrorState extends AppCubitStates{
  final String error;

  LikePostsErrorState(this.error);
}

class GetAllUsersSuccessLoadingState extends AppCubitStates{}
class GetAllUsersSuccessState extends AppCubitStates{}

class GetAllUsersErrorState extends AppCubitStates{
  final String error;

  GetAllUsersErrorState(this.error);
}
class SendMessageSuccessState extends AppCubitStates{}

class SendMessageErrorState extends AppCubitStates{
  final String error;

  SendMessageErrorState(this.error);
}
class GetMessagesSuccessState extends AppCubitStates{}
