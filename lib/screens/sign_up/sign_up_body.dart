import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_app2/screens/home/home_screen.dart';
import 'package:social_app2/screens/sign_up/cubit/signup_states.dart';
import 'package:social_app2/shared/components/background.dart';
import 'package:social_app2/shared/components/components.dart';
import 'package:social_app2/shared/components/constants.dart';

import 'cubit/signup_cubit.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    TextEditingController phoneController = TextEditingController();

    var formKey = GlobalKey<FormState>();
    return BlocConsumer<RegisterCubit, RegisterStates>(
        builder: (context, state) {
      RegisterCubit cubit = RegisterCubit.get(context);

      return Background(
        image1: 'assets/images/signup_top.png',
        image2: 'assets/images/main_bottom.png',
        login: false,
        textChild: const Text(
          'SIGN UP',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: kPrimaryColor, fontSize: 22),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.02),
              SvgPicture.asset(
                'assets/icons/signup.svg',
                height: size.height * 0.35,
              ),
              SizedBox(height: size.height * 0.02),
              SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      buildTextFormField(
                          size: size,
                         //  initialValue:'',
                          controller: nameController,
                          type: TextInputType.name,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter your name ';
                            }
                          },
                          label: 'Name',
                          icon:Icon( Icons.person)),
                      buildTextFormField(
                          size: size,
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter your email ';
                            }
                          },
                          label: 'Email',
                       // initialValue:'',
                          icon:Icon( Icons.email)),
                      buildTextFormField(
                          size: size,
                          //initialValue:'',
                          controller: passwordController,
                          suffixIcon: const Icon(Icons.visibility_off),
                          type: TextInputType.visiblePassword,
                          isPassword:
                              RegisterCubit.get(context).isPasswordShowen,
                          suffixPressed: () => RegisterCubit.get(context)
                              .changePasswordVisiblity(),
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Password is too short ';
                            }
                          },
                          label: 'Password',
                          icon:Icon( Icons.lock)),
                      buildTextFormField(
                          size: size,
                           //initialValue:'',
                          controller: phoneController,
                          type: TextInputType.phone,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter your number ';
                            }
                          },
                          label: 'Number',
                          icon: Icon( Icons.phone)),
                    ],
                  ),
                ),
              ),
              buildRoundedButton(
                  size: size,
                  text: 'SIGN UP',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      cubit.userRegister(
                          name: nameController.text,
                          email: emailController.text,
                          password: passwordController.text,
                          phone: phoneController.text);
                    }
                  },
                  color: kPrimaryColor,
                  textColor: kPrimaryLightColor),
            ],
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is RegisterErrorState) {
        showToast(message: state.error, color: Colors.red);
      }
      if (state is CreateUserSuccessState) {
        navigateTo(context, HomeScreen());
      }
    });
  }
}
