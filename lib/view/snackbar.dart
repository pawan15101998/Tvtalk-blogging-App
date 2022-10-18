 import 'package:flutter/material.dart';
import 'package:tvtalk/constant/color_const.dart';

class MyMessageHandler {
  final colorconst = ColorConst();
       void showMySnackBar(var _scaffoldKey, String message) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
         backgroundColor: colorconst.greenColor,
         content: Text(message),
         duration: Duration(seconds: 2),
          ));
         }
      }