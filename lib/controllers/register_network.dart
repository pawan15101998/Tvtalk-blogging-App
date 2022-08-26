import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvtalk/getxcontroller/signin_controller.dart';
import 'package:tvtalk/services/service.dart';
import 'package:tvtalk/view/dialog/register_otp_dialog.dart';

class RegisterNetwork{
  var apiProvider = ApiProvider();
  final signincontroller = Get.find<SignInController>();
   registerFunction(context, passwordController,cnfpasswordController, nameController, emailController) async {
    print("object");
    if (passwordController == cnfpasswordController) {
    var RegisterResponse=   await apiProvider.Post('/user/signup', {
      'name':nameController,
      'email':emailController,
      'password':passwordController,
      'confirm_password':cnfpasswordController   
       });
      print("apiproviderss");
      print(RegisterResponse['message']);
      if (RegisterResponse['message'] ==
          "User created successfully and otp sent to mail.") {
            signincontroller.isGuest.value = '';
        Flushbar(
          backgroundColor: Colors.green,
          message: "user created successfully and otp sent to mail",
          duration: Duration(seconds: 2),
        ).show(context);
        print("Responsessssssssss");
       print(RegisterResponse['data']['reset_token']);
        RegisterOtpDialog().showBottomDialog(context, emailController, nameController, passwordController, cnfpasswordController);
        final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
       sharedPreferences.setString("reset_token", RegisterResponse['data']['reset_token']);
       sharedPreferences.setString("name", RegisterResponse['data']['name']);
       signincontroller.userName = RegisterResponse['data']['name'];
       signincontroller.userEmail = RegisterResponse['data']['email'];
      }else if(RegisterResponse['message'] =='User already exist please login.'){
          Flushbar(
          backgroundColor: Colors.green,
          message: "User already exist please login.",
          duration: Duration(seconds: 2),
        ).show(context);
      }else if(RegisterResponse['message'] == 'Email already exists and otp sent again'){
        Flushbar(
          backgroundColor: Colors.green,
          message: "user created successfully and otp sent to mail",
          duration: Duration(seconds: 2),
        ).show(context);
        RegisterOtpDialog().showBottomDialog(context, emailController, nameController, passwordController, cnfpasswordController);
      } else if (RegisterResponse['message'] ==
          'Sign up validation Name Empty') {
        final snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: const Text("Enter Registration Details"),
          action: SnackBarAction(
            label: '',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (RegisterResponse['message'] ==
          'Sign up validation Email Empty') {
        final snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: const Text("Sign up validation Email Empty"),
          action: SnackBarAction(
            label: '',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (RegisterResponse['message'] ==
          'Sign up validation Password Empty') {
        final snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: const Text("Sign up validation Password Empty"),
          action: SnackBarAction(
            label: '',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (RegisterResponse['message'] ==
          'Sign up validation Password Pattern') {
        final snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: const Text(
              "Password length must be greater then 4 that  include at least 1 number and character"),
          action: SnackBarAction(
            label: '',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (RegisterResponse['message'] ==
          'Sign up validation Email Email') {
        final snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: const Text("Email Not valid"),
          action: SnackBarAction(
            label: '',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }else if(RegisterResponse['message'] ==
          'Email address is already registered .'){
        final snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: const Text("Email address is already registered ."),
          action: SnackBarAction(
            label: '',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }else{
        final snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: const Text("Something went wrong"),
          action: SnackBarAction(
            label: '',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    } else {
      final snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: const Text("password not match"),
        action: SnackBarAction(
          label: '',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

}