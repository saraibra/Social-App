import 'package:flutter/material.dart';
import 'package:social_app2/screens/welcome/body.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () => Future.value(false),
      child: const Scaffold(
      body: Body()  
      ),
    );
  }
}