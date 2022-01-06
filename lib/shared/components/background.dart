import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({
    Key? key,
    required this.child,required this.image1,required this.image2,required this.login,required this.textChild,
  }) : super(key: key);

  final Widget child;
  final String image1;
  final String image2;
  final bool login;
  final Widget textChild;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
            Positioned(
            top: size.height * 0.08,
            left: size.width * 0.18,
            child: textChild,
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(image1),
            width: size.width * 0.3,
          ),
        login? Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(image2),
            width: size.width * 0.2,
          ): Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset(image2),
            width: size.width * 0.2,
          ),
          child
        ],
      ),
    );
  }
}
