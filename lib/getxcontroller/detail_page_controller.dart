import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvtalk/model/get_comment_model.dart';

class DetailPageController extends GetxController{
  RxInt DetailScroll = 0.obs;
  RxBool CommentShow = false.obs;
  RxBool isDark = false.obs;
  RxBool isDarkButton = false.obs;
  RxInt activeBorder = 1.obs;
  RxInt fontFamily = 1.obs;
  RxInt fontSize = 16.obs;
  RxBool articleRead = false.obs;
  RxBool islike = false.obs;
  GetComment? commentData;

 fontfamily(color){
    return TextStyle(
                  fontSize: fontSize.value == 12 ?
                  12 :
                  fontSize.value == 14 ?
                  14:
                  fontSize.value == 16 ?
                  16:
                  fontSize.value == 18?
                  18: 
                  fontSize.value == 20?
                  20:
                  fontSize.value == 22?
                  22:
                  fontSize.value == 24?
                  24:null,
                  fontFamily: fontFamily.value == 1 ?
                    "QUICKSAND" :
                   fontFamily.value == 2 ?
                    "NOTO SERIF" : 
                    fontFamily.value == 3 ?  
                    "Montserrat":
                    fontFamily.value == 4 ?
                    "VIDALOKA": "POPPINS",
                   color: color == Colors.green ? Colors.green : isDark.value
                                    ? Colors.white
                                    : Colors.black,
                  );
  }
}