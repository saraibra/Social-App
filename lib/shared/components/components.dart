import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app2/shared/components/constants.dart';
import 'package:social_app2/shared/style/icon_broken.dart';

Widget buildRoundedButton({
  required Size size,
  required String text,
  required onPressed,
  Color color = Colors.purple,
  Color textColor = Colors.white,
}) =>
    InkWell(
      onTap: onPressed,
      child: Container(
        width: size.width * 0.9,
        height: size.height * 0.08,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: color),
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Center(
              child: Text(
                text,
                style: TextStyle(color: textColor),
              ),
            )),
      ),
    );
Widget buildTextFormField(
        {required Size size,
        required TextEditingController controller,
        required TextInputType type,
        onSubmitted,
        onChanged,
        onTab,
        suffixIcon,
        suffixPressed,
        bool isPassword = false,
     //  required String initialValue ,
        required validate,
        required String label,
        required  icon}) =>
    Container(
      width: size.width * 0.9,
      height: size.width * 0.18,
      child: TextFormField(
       // initialValue: initialValue,
        controller: controller,
        keyboardType: type,
        maxLength: 30,
        maxLines: 1,
        obscureText: isPassword,
        onFieldSubmitted: onSubmitted,
        onChanged: onChanged,
        validator: validate,
        onTap: onTab,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            prefixIcon: 
              icon,
         
          //  suffixIcon: IconButton(
            //  onPressed: suffixPressed,
            //  icon: 
              //  suffixIcon,
           
            //),
            labelText: label,
            labelStyle: const TextStyle(
              color: Colors.black,
            )),
      ),
    );
Widget buildSocialIcon({required image, required onPressed}) => GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            border: Border.all(
          width: 2,
          color: kPrimaryLightColor,
        )),
        child: SvgPicture.asset(
          image,
          height: 20,
          width: 20,
        ),
      ),
    );
void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void showToast({required String message, required Color color}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
Widget textButton({required Widget child, required onPressed}) =>
    TextButton(onPressed: onPressed, child: child,
 
    );
 defaultAppBar({required BuildContext context,String title = '',
List<Widget>? actions
})=>AppBar(
  title: Text(title),
  titleSpacing: 0.0,
  actions: actions,
  
leading: IconButton(onPressed: (){
  Navigator.pop(context);
}, icon: Icon(IconBroken.Arrow___Left_2)),
);