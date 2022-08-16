import 'package:flutter/material.dart';

class TextFieldLogic {
    obscureText(textName,_passwordVisible ) {
    if ((textName == "Password" ||
            textName == "Confirm Password" ||
            textName == "New Password") &&
        _passwordVisible == false) {
      return true;
    } else {
      return false;
    }
  }

    sufixIcon(textName, _passwordVisible) {
    if (textName == "Password" ||
        textName == "Confirm Password" ||
        textName == "New Password") {
      return IconButton(
        icon: Icon(
          _passwordVisible ? Icons.visibility : Icons.visibility_off,
          color: Colors.black,
        ),
        padding: EdgeInsets.zero,
        constraints: const BoxConstraints(),
        onPressed: () {
          
        },
      );
    }
  }
}