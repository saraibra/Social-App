
import 'package:social_app2/models/user_model.dart';

abstract class RegisterStates{}
class RegisterInitialState extends RegisterStates{}
class RegisterLoadingState extends RegisterStates{}
class RegisterSuccessState extends RegisterStates{

}

class RegisterChangePasswordVisibilityState extends RegisterStates{}

class RegisterErrorState extends RegisterStates{
  final String error;

 RegisterErrorState(this.error);
}
class CreateUserSuccessState extends RegisterStates{
}

class CreateUserErrorState extends RegisterStates{
  final String error;

 CreateUserErrorState(this.error);
}