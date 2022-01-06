import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app2/models/user_model.dart';
import 'package:social_app2/screens/login_screen/login_cubit/states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState()) ;
    static LoginCubit get(context) => BlocProvider.of(context);

  IconData suffixIcon = Icons.visibility_outlined;
  bool isPasswordShowen =true;
  void changePasswordVisiblity() {
    isPasswordShowen = !isPasswordShowen;
        suffixIcon =isPasswordShowen?Icons.visibility_outlined: Icons.visibility_off_outlined;
emit(LoginChangePasswordVisibilityState());
  }

  void userLogin({required String email, required String password}) {
  UserModel loginModel;

    emit(LoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
    .then((value) => {
      emit(LoginSuccessState(value.user!.uid)),
    }).catchError((error){
      emit(LoginErrorState(error.toString()));
    });

  }
}
