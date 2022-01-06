import 'package:flutter/material.dart';
import 'package:social_app2/screens/sign_up/sign_up_body.dart';

class SignUp extends StatelessWidget {
  const SignUp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignUpBody(),
    );
  }
}