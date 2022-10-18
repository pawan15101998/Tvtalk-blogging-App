import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorConst {
final mainColor = const Color(0xffFFDC5C);
final darkBlue = const Color(0xff0701BF);
final greyColor = const Color(0xff949494);
final lightYellow = const Color(0xffF1B142);
final redColor =  Colors.red;
final transparentColor = Colors.transparent;
final greenColor = Colors.green;
final blueColor = Colors.blue;
final blackColor = Colors.black;
final whiteColor = Colors.white;

final notificationRead =const LinearGradient(colors: [
Color.fromARGB(255, 248, 237, 143),
Color.fromARGB(255, 226, 222, 189),]);

final notificationUnRead = const LinearGradient(colors: [
Color(0xffFFDC5C),
Color.fromARGB(255, 248, 237, 143),]);
}