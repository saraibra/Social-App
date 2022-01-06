

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_app2/screens/login_screen/login_cubit/cubit.dart';
import 'package:social_app2/screens/login_screen/login_cubit/states.dart';
import 'package:social_app2/screens/sign_up/cubit/signup_cubit.dart';
import 'package:social_app2/screens/sign_up/sign_up.dart';
import 'package:social_app2/shared/components/background.dart';
import 'package:social_app2/shared/components/components.dart';
import 'package:social_app2/shared/components/constants.dart';
import 'package:social_app2/shared/network/cashe_helper.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    var formKey = GlobalKey<FormState>();
return BlocConsumer<LoginCubit,LoginStates>(builder: (context,state){
  LoginCubit cubit = LoginCubit.get(context);
     return Background(
        image1: 'assets/images/main_top.png',
        image2: 'assets/images/login_bottom.png',
        textChild: const Text(
          'LOGIN',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: kPrimaryColor, fontSize: 22),
        ),
        login: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.02),
                SvgPicture.asset(
                  'assets/icons/login.svg',
                  height: size.height * 0.35,
                ),
                SizedBox(height: size.height * 0.02),
               SingleChildScrollView(
                  child:Form(
                      key: formKey,
                    child: Column(
                      children: [
                        buildTextFormField(
                         // initialValue:'',
                            size: size,
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: ( value) {
                              if (value.isEmpty) {
                                return 'Please enter your email ';
                              }
                            },
                            label: 'Email',
                            icon:Icon( Icons.email)),
                              buildTextFormField(
                                                        //  initialValue:'',

                      size: size,
                      controller: passwordController,
                      type: TextInputType.visiblePassword,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'Password is too short ';
                        }
                      },
                  
                      label: 'Password',
                      icon:Icon( Icons.lock)),
                      ],
                    ),
                  ),
                      
                ),
              
                buildRoundedButton(
                    size: size,
                    text: 'LOGIN',
                    onPressed: () {
                          if (formKey.currentState!.validate()) {
                           cubit.userLogin(email: emailController.text,
                            password: passwordController.text);
                        }
                    },
                    color: kPrimaryColor,
                    textColor: kPrimaryLightColor),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Don\'t have an account ?',
                      style: TextStyle(color: kPrimaryColor, fontSize: 18),
                    ),
                    TextButton(
                        onPressed: () => navigateTo(context, const SignUp()),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: kPrimaryColor),
                        ))
                  ],
                ),
              ],
            ),
          ),
      
      );
}
, listener: (context,state){

  if(state is LoginErrorState ){
        showToast(message: state.error, color: Colors.red);

  }
  if(state is LoginSuccessState){
    CasheHelper.putData(key: 'uid', value: state.uid);
  }
}
);
  }
}
