
import 'dart:ui';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvtalk/constant/color_const.dart';
import 'package:tvtalk/getxcontroller/detail_page_controller.dart';
import 'package:tvtalk/model/post_model.dart';
import 'package:tvtalk/services/service.dart';
import 'package:tvtalk/view/dialog/reset_password_dialog.dart';
import 'package:tvtalk/widgets/text_field.dart';

class ThemeDialog {
  var submitdialog = SubmitDialog();
  var apiProvider = ApiProvider();
  late String otpEmail;
    final colorconst = ColorConst();
  var detailpageController = Get.find<DetailPageController>();
  TextEditingController otpController = TextEditingController();
  void showThemeDialog(BuildContext context, String email) {
    otpEmail = email;
    showGeneralDialog(
      barrierLabel: "showGeneralDialog",
      barrierDismissible: false,
      barrierColor: colorconst.blackColor.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 400),
      context: context,
      pageBuilder: (context, _, __) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: _buildDialogContent(
            context,
          ),
        );
      },
      transitionBuilder: (_, animation1, __, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0, 1),
            end: const Offset(0, 0),
          ).animate(animation1),
          child: child,
        );
      },
    );
  }

  Widget FontSizeBox(String fontSize , ontap) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 25,
        width: 25,
        child: Center(
            child: Text(
          fontSize,
          style: TextStyle(
              color: detailpageController.isDark.value
                  ? colorconst.whiteColor
                  : colorconst.blackColor),
        )),
        decoration: BoxDecoration(
                  color: (fontSize == '12' && detailpageController.fontSize.value == 12)?
                   colorconst.greenColor :
                   (fontSize == '14' && detailpageController.fontSize.value == 14)?
                   colorconst.greenColor:
                   (fontSize == '16' && detailpageController.fontSize.value == 16)?
                   colorconst.greenColor:
                   (fontSize == '18' && detailpageController.fontSize.value == 18)?
                   colorconst.greenColor:
                   (fontSize == '20' && detailpageController.fontSize.value == 20)?
                   colorconst.greenColor : 
                   (fontSize == '22' && detailpageController.fontSize.value == 22)?
                   colorconst.greenColor : 
                   (fontSize == '24' && detailpageController.fontSize.value == 24)?
                   colorconst.greenColor : colorconst.transparentColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: detailpageController.isDark.value
                    ?(fontSize == '12' && detailpageController.fontSize.value == 12)?
                   colorconst.greenColor :
                   (fontSize == '14' && detailpageController.fontSize.value == 14)?
                   colorconst.greenColor:
                   (fontSize == '16' && detailpageController.fontSize.value == 16)?
                   colorconst.greenColor:
                   (fontSize == '18' && detailpageController.fontSize.value == 18)?
                   colorconst.greenColor:
                   (fontSize == '20' && detailpageController.fontSize.value == 20)?
                   colorconst.greenColor : colorconst.whiteColor
                    :(fontSize == '12' && detailpageController.fontSize.value == 12)?
                   colorconst.greenColor :
                   (fontSize == '14' && detailpageController.fontSize.value == 14)?
                   colorconst.greenColor:
                   (fontSize == '16' && detailpageController.fontSize.value == 16)?
                   colorconst.greenColor:
                   (fontSize == '18' && detailpageController.fontSize.value == 18)?
                   colorconst.greenColor:
                   (fontSize == '20' && detailpageController.fontSize.value == 20)?
                   colorconst.greenColor:
                   (fontSize == '22' && detailpageController.fontSize.value == 22)?
                   colorconst.greenColor:
                   (fontSize == '24' && detailpageController.fontSize.value == 24)?
                   colorconst.greenColor : colorconst.blackColor)),
      ),
    );
  }

  Widget FonttheamingButtons(String image,  String name, String fontName, ontap,) {
    return Column(
      children: [
        SizedBox(
            width: 150,
            height: 52,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    elevation: 0.0,                                                     //"QUICKSAND"   NOTO SERIF  Montserrat  VIDALOKA                                                          //NOTO SERIF
                    side: BorderSide(
                      color:((detailpageController.fontFamily.value == 1 && fontName == "ROBOTO") ||
                             (detailpageController.fontFamily.value == 2 && fontName == "QUICKSAND") ||
                             (detailpageController.fontFamily.value == 3 && fontName == "NOTO SERIF")||
                             (detailpageController.fontFamily.value == 4 && fontName == "Montserrat") ||
                             (detailpageController.fontFamily.value == 5 && fontName == "VIDALOKA")
                             ) ? 
                      colorconst.greenColor : Colors.grey 
                    ),
                    primary: colorconst.transparentColor),
                onPressed: ontap,
                child: name == 'Hello, friend!'
                    ? Text(
                        name,
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: fontName,
                            color: detailpageController.isDark.value
                                ? colorconst.whiteColor
                                : colorconst.blackColor),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 25,
                              width: 25,
                              child: Image(
                                image: AssetImage(image),
                                color: detailpageController.isDark.value
                                    ? colorconst.whiteColor
                                    : colorconst.blackColor,
                              )),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 14,
                              color: detailpageController.isDark.value
                                  ? colorconst.whiteColor
                                  : colorconst.blackColor,
                            ),
                          ),
                        ],
                      ))),
        SizedBox(
          width: 140,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              name == 'Hello, friend!'
                  ? Text(
                      fontName,
                      style: TextStyle(
                          fontSize: 12,
                          color: detailpageController.isDark.value
                              ? colorconst.whiteColor
                              : colorconst.blackColor),
                    )
                  : Text(
                      "$name Theme",
                      style: TextStyle(
                          fontSize: 12,
                          color: detailpageController.isDark.value
                              ? colorconst.whiteColor
                              : colorconst.blackColor),
                    ),
              Icon(
                Icons.check_circle_rounded,
                size: 16,                        //QUICKSAND NOTO SERIF  Montserrat VIDALOKA
                color: (detailpageController.isDark.value && (
                       (detailpageController.fontFamily.value == 1 && fontName == "ROBOTO") ||
                       (detailpageController.fontFamily.value == 2 && fontName == "QUICKSAND")||
                       (detailpageController.fontFamily.value == 3 && fontName == "NOTO SERIF")||
                       (detailpageController.fontFamily.value == 4 && fontName == "Montserrat")  ||
                       (detailpageController.fontFamily.value == 5 && fontName == "VIDALOKA")
                    ))
                    ? colorconst.greenColor
                    : (detailpageController.isDark == false && (
                       (detailpageController.fontFamily.value == 1 && fontName == "ROBOTO") ||
                       (detailpageController.fontFamily.value == 2 && fontName == "QUICKSAND")||
                       (detailpageController.fontFamily.value == 3 && fontName == "NOTO SERIF")||
                       (detailpageController.fontFamily.value == 4 && fontName == "Montserrat")  ||
                       (detailpageController.fontFamily.value == 5 && fontName == "VIDALOKA")
                             )) ?
                             colorconst.greenColor
                          : detailpageController.isDark.value ?
                          colorconst.whiteColor : colorconst.blackColor
              ),
            ],
          ),
        )
      ],
    );
  }


  Widget theamingButtons(String image,  String name, String fontName, ontap,) {
    return Column(
      children: [
        SizedBox(
            width: 150,
            height: 52,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    elevation: 0.0,
                    side: BorderSide(
                      color:((detailpageController.activeBorder.value == 1 && name == "Light") ||
                             (detailpageController.activeBorder.value == 2 && name == "Dark")) ? 
                      colorconst.greenColor : Colors.grey 
                    ),
                    primary: colorconst.transparentColor),
                onPressed: ontap,
                child: name == 'Hello, friend!'
                    ? Text(
                        name,
                        style: TextStyle(
                            fontSize: 14,
                            color: detailpageController.isDark.value
                                ? colorconst.whiteColor
                                : colorconst.blackColor),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 25,
                              width: 25,
                              child: Image(
                                image: AssetImage(image),
                                color: detailpageController.isDark.value
                                    ? colorconst.whiteColor
                                    : colorconst.blackColor,
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            name,
                            style: TextStyle(
                              fontSize: 14,
                              color: detailpageController.isDark.value
                                  ? colorconst.whiteColor
                                  : colorconst.blackColor,
                            ),
                          ),
                        ],
                      ))),
        SizedBox(
          width: 140,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              name == 'Hello, friend!'
                  ? Text(
                      fontName,
                      style: TextStyle(
                          fontSize: 12,
                          color: detailpageController.isDark.value
                              ? colorconst.whiteColor
                              : colorconst.blackColor),
                    )
                  : Text(
                      "$name Theme",
                      style: TextStyle(
                          fontSize: 12,
                          color: detailpageController.isDark.value
                              ? colorconst.whiteColor
                              : colorconst.blackColor),
                    ),
              Icon(
                Icons.check_circle_rounded,
                size: 16,
                color:(detailpageController.isDark.value && (detailpageController.activeBorder.value == 1 && name == "Light") ||
                             (detailpageController.activeBorder.value == 2 && name == "Dark") )
                    ? colorconst.greenColor:
                    (detailpageController.isDark == false && (detailpageController.activeBorder.value == 1 && name == "Light") ||
                              (detailpageController.activeBorder.value == 2 && name == "Dark")
                    ) ?
                    colorconst.greenColor : colorconst.blackColor
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildDialogContent(context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: IntrinsicHeight(
          child: Obx(() {
            return Container(
              width: double.maxFinite,
              clipBehavior: Clip.antiAlias,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: detailpageController.isDark.value
                    ? colorconst.blackColor
                    : colorconst.whiteColor,
              ),
              child: Material(
                child: Container(
                  color: detailpageController.isDark.value
                      ? colorconst.blackColor
                      : colorconst.whiteColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const SizedBox(height: 16),
                      // Text(
                      //   "Select Reading Theme",
                      //   style: TextStyle(
                      //       color: detailpageController.isDark.value
                                // ? colorconst.whiteColor
                      //           : colorconst.blackColor,
                      //       fontWeight: FontWeight.w600,
                      //       fontSize: 16),
                      // ),
                      // const SizedBox(height: 16),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     theamingButtons(
                      //         "assets/icons/icon_light.png",  "Light", "" ,(){
                      //           detailpageController.isDarkButton.value = false;
                      //           detailpageController.isDark.value = false;
                      //           detailpageController.activeBorder.value = 1;

                      //         }),
                      //     theamingButtons(
                      //         "assets/icons/icon_dark.png", "Dark", "",(){
                      //           detailpageController.isDarkButton.value = true;
                      //           detailpageController.isDark.value = true;
                      //           detailpageController.activeBorder.value = 2;
                      //         })
                      //   ],
                      // ),
                      // const SizedBox(height: 16),
                      // Divider(
                      //   color: detailpageController.isDark.value
                      //       ? colorconst.whiteColor
                      //       : colorconst.blackColor,
                      // ),
                      Text(
                        "Select Font",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: detailpageController.isDark.value
                                ? colorconst.whiteColor
                                : colorconst.blackColor),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        height: 100,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FonttheamingButtons("assets/icons/icon_light.png",
                              "Hello, friend!",  "ROBOTO",(){
                                  detailpageController.fontFamily.value = 1;
                              }),
                               const SizedBox(
                              width: 20,
                            ),
                            FonttheamingButtons("assets/icons/icon_light.png",
                              "Hello, friend!",  "QUICKSAND",(){
                                  detailpageController.fontFamily.value = 2;
                              }),
                            const SizedBox(
                              width: 20,
                            ),
                            FonttheamingButtons("assets/icons/icon_light.png",
                                "Hello, friend!", "NOTO SERIF",(){
                                  detailpageController.fontFamily.value = 3;
                                }),
                            const SizedBox(
                              width: 20,
                            ),
                            FonttheamingButtons("assets/icons/icon_light.png",
                                "Hello, friend!",  "Montserrat",(){
                                  detailpageController.fontFamily.value = 4;
                                }),
                            const SizedBox(
                              width: 20,
                            ),
                            FonttheamingButtons("assets/icons/icon_light.png",
                                "Hello, friend!",   "VIDALOKA",(){
                                  detailpageController.fontFamily.value = 5;
                                }),
                            const SizedBox(
                              width: 20,
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: detailpageController.isDark.value
                            ? colorconst.whiteColor
                            : colorconst.blackColor,
                      ),
                      Text(
                        "Select Font Size",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: detailpageController.isDark.value
                                ? colorconst.whiteColor
                                : colorconst.blackColor),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                              width: 65,
                              height: 55,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    elevation: 0.0,
                                    side: const BorderSide(color: Colors.grey),
                                    primary: colorconst.transparentColor),
                                onPressed: () {},
                                child: Text(
                                  "Tiny",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: detailpageController.isDark.value
                                          ? colorconst.whiteColor
                                          : colorconst.blackColor),
                                ),
                              )),
                          FontSizeBox("12",(){
                            detailpageController.fontSize.value = 12;
                          }),
                          FontSizeBox("14",(){
                            detailpageController.fontSize.value = 14;
                          }),
                          FontSizeBox("16",(){
                            detailpageController.fontSize.value = 16;
                          }),
                          FontSizeBox("18",(){
                            detailpageController.fontSize.value = 18;
                          }),
                          FontSizeBox("20",(){
                            detailpageController.fontSize.value = 20;
                          }),
                          FontSizeBox("22",(){
                            detailpageController.fontSize.value = 22;
                          }),
                          FontSizeBox("24",(){
                            detailpageController.fontSize.value = 24;
                          }),
                          SizedBox(
                              width: 65,
                              height: 55,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8))),
                                    elevation: 0.0,
                                    side: const BorderSide(color: Colors.grey),
                                    primary: colorconst.transparentColor),
                                onPressed: () {},
                                child: Text(
                                  "Big",
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: detailpageController.isDark.value
                                          ? colorconst.whiteColor
                                          : colorconst.blackColor),
                                ),
                              )),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Divider(),
                      Center(
                          child: SizedBox(
                        height: 50,
                        width: 100,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: detailpageController.isDark.value
                                  ? colorconst.whiteColor
                                  : colorconst.blackColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Done",
                            style: TextStyle(
                                color: detailpageController.isDark.value
                                    ? colorconst.blackColor
                                    : colorconst.whiteColor,
                                letterSpacing: 2),
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
