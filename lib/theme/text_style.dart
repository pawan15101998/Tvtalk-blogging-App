import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvtalk/constant/color_const.dart';
import 'package:tvtalk/getxcontroller/detail_page_controller.dart';
import 'package:tvtalk/theme/theme.dart';

final detailpageController = Get.find<DetailPageController>();
  final colorconst = ColorConst();
TextStyle textStyleLogin1 = const TextStyle(
    fontSize: 25, fontWeight: FontWeight.w700, fontFamily: 'Quicksand');

TextStyle textStyleForgot =  TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    // fontFamily: 'Quicksand',
    color: colorconst.darkBlue);

TextStyle textStyleForgotMail = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w100,
    // fontFamily: 'Quicksand',
    color: colorconst.blackColor);

TextStyle textStyleButton = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w100,
    // fontFamily: 'Quicksand',
    color: whiteColor);

TextStyle textStyleButton2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w100,
    // fontFamily: 'Quicksand',
    color: colorconst.blackColor);

TextStyle textStyleDetailHead = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    // fontFamily: 'Quicksand',
    color: colorconst.blackColor);

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
  color: detailpageController.isDark.value ? colorconst.whiteColor : colorconst.blackColor,
);
