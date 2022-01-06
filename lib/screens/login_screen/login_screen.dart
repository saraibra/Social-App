import 'package:flutter/material.dart';
import 'package:social_app2/screens/login_screen/body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return const Scaffold(body: LoginBody());
  }
}
