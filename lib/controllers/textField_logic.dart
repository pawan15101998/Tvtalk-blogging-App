import 'package:flutter/material.dart';
import 'package:tvtalk/constant/color_const.dart';

class TextFieldLogic {
  final colorconst = ColorConst();
    obscureText(textName,_passwordVisible) {
    if ((textName == "Password" ||
            textName == "Confirm Password" ||
            textName == "New Password") &&
       ( _passwordVisible == false)) {
      return true;
    } else {
      return false;
    }
  }

    sufixIcon(textName, passwordVisible) {
    if (textName == "Password" ||
        textName == "Confirm Password" ||
        textName == "New Password") {
      return IconButton(
        icon: Icon(
          passwordVisible ? Icons.visibility : Icons.visibility_off,
          color: colorconst.blackColor,
        ),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        onPressed: () {
          
        },
      );
    }
  }
}