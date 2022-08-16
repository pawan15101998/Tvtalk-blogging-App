 import 'package:flutter/material.dart';

class MyMessageHandler {
       void showMySnackBar(var _scaffoldKey, String message) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
         backgroundColor: Colors.green,
         content: Text(message),
         duration: Duration(seconds: 2),
          ));
         }
      }