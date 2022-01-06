import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app2/models/user_model.dart';
import 'package:social_app2/screens/sign_up/cubit/signup_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  IconData suffixIcon = Icons.visibility_outlined;
  bool isPasswordShowen = true;
  void changePasswordVisiblity() {
    isPasswordShowen = !isPasswordShowen;
    suffixIcon = isPasswordShowen
        ? Icons.visibility_outlined
        : Icons.visibility_off_outlined;
    emit(RegisterChangePasswordVisibilityState());
  }

  void userRegister(
      {required String email,
      required String password,
      required String name,
      required String phone}) {
    UserModel? userModel;

    emit(RegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => {
              createUser(
                  email: email, name: name, phone: phone, uid: value.user!.uid),
              emit(RegisterSuccessState()),
            })
        .catchError(onError);
  }

  void createUser({
    required String email,
    required String name,
    required String phone,
    required String uid,
  }) {
    UserModel userModel = UserModel(
        name: name,
        email: email,
        phone: phone,
        uid: uid,
        image:
            'https://image.freepik.com/free-photo/medium-shot-happy-man-smiling_23-2148221808.jpg',
        cover:
            'https://image.freepik.com/free-photo/joyful-black-author-works-writing-new-book-readers_273609-28047.jpg',
        bio: 'Write your bio ...',
        isEmailVerified: false);
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(userModel.toMap())
        .then((value) => {emit(CreateUserSuccessState())})
        .catchError((error) {
      emit(CreateUserErrorState(error.toString()));
    });
  }
}
