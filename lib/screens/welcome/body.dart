
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_app2/screens/login_screen/login_screen.dart';
import 'package:social_app2/screens/sign_up/sign_up.dart';
import 'package:social_app2/shared/components/background.dart';
import 'package:social_app2/shared/components/components.dart';
import 'package:social_app2/shared/components/constants.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
        image1: 'assets/images/main_top.png',
        image2: 'assets/images/main_bottom.png',
        login: false,
        textChild: const Text(
          '',
          style: TextStyle(fontWeight: FontWeight.bold, color: kPrimaryColor,
          fontSize: 24
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.03),
              SvgPicture.asset(
                'assets/icons/chat.svg',
                height: size.height * 0.4,
              ),
              SizedBox(height: size.height * 0.02),
              buildRoundedButton(
                  size: size,
                  text: 'LOGIN',
                  onPressed: () => navigateTo(context, const LoginScreen()),
                  color: kPrimaryColor,
                  textColor: kPrimaryLightColor),
              SizedBox(height: size.height * 0.02),
              buildRoundedButton(
                  size: size,
                  text: 'REGISTER',
                  onPressed: () => navigateTo(context, const SignUp()),
                  color: kPrimaryLightColor,
                  textColor: kPrimaryColor),
            ],
          ),
        ));
  }
}
