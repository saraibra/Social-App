abstract class LoginStates{}
class LoginInitialState extends LoginStates{}
class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates{
 final String uid;

  LoginSuccessState(this.uid);
}
class LoginChangePasswordVisibilityState extends LoginStates{}

class LoginErrorState extends LoginStates{
  final String error;

 LoginErrorState(this.error);
}