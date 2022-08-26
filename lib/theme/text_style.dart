import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvtalk/getxcontroller/detail_page_controller.dart';
import 'package:tvtalk/theme/theme.dart';

final detailpageController = Get.find<DetailPageController>();

TextStyle textStyleLogin1 = const TextStyle(
    fontSize: 25, fontWeight: FontWeight.w700, fontFamily: 'Quicksand');

TextStyle textStyleForgot = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    // fontFamily: 'Quicksand',
    color: Color(0xfff0701BF));

TextStyle textStyleForgotMail = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w100,
    // fontFamily: 'Quicksand',
    color: Colors.black);

TextStyle textStyleButton = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w100,
    // fontFamily: 'Quicksand',
    color: whiteColor);

TextStyle textStyleButton2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w100,
    // fontFamily: 'Quicksand',
    color: Colors.black);

TextStyle textStyleDetailHead = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    // fontFamily: 'Quicksand',
    color: Colors.black);

TextStyle detailStyle = TextStyle(
  fontSize: 16,
  fontFamily: detailpageController.fontFamily == 1
      ? "QUICKSAND"
      : detailpageController.fontFamily == 2
          ? "NOTO SERIF"
          : detailpageController.fontFamily == 3
              ? "Montserrat"
              : detailpageController.fontFamily == 4
                  ? "VIDALOKA"
                  : "POPPINS",
  color: detailpageController.isDark.value ? Colors.white : Colors.black,
);
