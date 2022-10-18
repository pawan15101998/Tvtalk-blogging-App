
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tvtalk/Authencation/google_sign_in.dart';
import 'package:tvtalk/constant/color_const.dart';
import 'package:tvtalk/constant/front_size.dart';

class loginButton extends StatelessWidget {
  loginButton({
    Key? key,
    required this.width,
    required this.color,
    required this.textColor,
    required this.text,
    required this.image,
    required this.onPress
  }) : super(key: key);

  final double width;
  Color color;
  Color textColor;
  String text;
  String image;
  var onPress;
 var textSize = AdaptiveTextSize();
   final colorconst = ColorConst();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 90 / 100,
      height: MediaQuery.of(context).size.height*7/100,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: text == "Continue with Google"
              ? Border.all()
              : Border.all(color: colorconst.transparentColor)),
      child: ElevatedButton(
        onPressed: onPress,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              image,
              width: 25,
              height: 25,
              fit: BoxFit.cover,
            ),
            // const Icon(
            //   Icons.golf_course,
            //   color: colorconst.blackColor,
            // ),
            SizedBox(
              width: width * 10 / 100,
            ),
            Text(text,
            textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: textSize.getadaptiveTextSize(context, 16),
                    fontWeight: FontWeight.w100,
                    // fontFamily: 'Poppins',
                    color: textColor)),
          ],
        ),
        style: ElevatedButton.styleFrom(
            primary: colorconst.transparentColor,
            onSurface: colorconst.transparentColor,
            shadowColor: colorconst.transparentColor,
            // padding: EdgeInsets.symmetric(horizontal: width*10/100,),
            textStyle:
                const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
