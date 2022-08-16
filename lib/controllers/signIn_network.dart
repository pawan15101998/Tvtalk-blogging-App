import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvtalk/routers.dart';
import 'package:tvtalk/services/service.dart';
import 'package:tvtalk/view/dialog/forgot_password_dialog.dart';
import 'package:tvtalk/view/home_page.dart';

class SignInNetwork {
  var apiProvider = ApiProvider();
  var bottomDialog = BottomDialog();

  forgotPassword(context, loginEmailController) async {
    if (loginEmailController != ""){
   var ForgotPass = await apiProvider.Post('/user/forgot-password', {
        'email': loginEmailController
      });
      print("ForgotPAsss");
      print(ForgotPass['message']);
      if (ForgotPass['message'] == 'Email does not exist') {
        final snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: const Text('Email does not exist'),
          ),
          duration: Duration(milliseconds: 800),
          action: SnackBarAction(
            label: '',
            onPressed: (){
              // Some code to undo the change.
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (ForgotPass['message'] ==
          'Mail sent successfully.') {
        bottomDialog.showBottomDialog(context, loginEmailController);
        print("object");
        Flushbar(
        backgroundColor: Colors.green,
        message: "Mail Sent successfully ",
        duration: Duration(seconds: 2),
      ).show(context);
      } else if (ForgotPass['message'] == 'Email not found.') {
        print("object");
        final snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: const Text('Email not found'),
          ),
          duration: Duration(milliseconds: 800),
          action: SnackBarAction(
            label: '',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (ForgotPass['message'] ==
          'Login validation Email Email') {
        print("object");
        final snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: const Text('Invalid Email Format'),
          ),
          duration: Duration(milliseconds: 800),
          action: SnackBarAction(
            label: '',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (ForgotPass['message'] == 'Email is not verified') {
        
        print("object");
        final snackBar = SnackBar(
          backgroundColor: Colors.red,
          content: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: const Text('Email is not verified'),
          ),
          duration: Duration(milliseconds: 800),
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
        content: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: const Text('Enter email first'),
        ),
        duration: Duration(milliseconds: 800),
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

   logInFunction(BuildContext context, loginEmailController, loginpasswordController) async {
    // EasyLoading.show(status: 'loading..');
  var LoginResponse = await apiProvider.Post('/user/login', {
      'email': loginEmailController,
      'password': loginpasswordController
    });
    print("LoginRes");
    print(LoginResponse['message']);
    // print(LoginResponse['data']['reset_token']);
    if(LoginResponse['message'] == 'Logged in successfully') {
      final snackBar = SnackBar(
        content: const Text('Logged in successfully'),
        backgroundColor: Colors.green,
        action: SnackBarAction(
          label: '',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      String resetToken = LoginResponse['data']['reset_token'];
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('email', loginEmailController);
      sharedPreferences.setString("reset_token", resetToken);
      // context.pushNamed('HOMEPAGE');
      Router.neglect(context, () {context.goNamed('HOMEPAGE');});
    } else if(LoginResponse['message'] ==
        'Wrong password entered.') {
      Flushbar(
        backgroundColor: Colors.red,
        message: "Wrong password entered",
        duration: Duration(seconds: 2),
      ).show(context);
    }else if(LoginResponse['message'] ==
        'Login validation Password Pattern'){
          Flushbar(
        backgroundColor: Colors.red,
        message: "Login validation Password Pattern",
        duration: Duration(seconds: 2),
      ).show(context);
    } else if(LoginResponse['message'] == "Email does not exist.") {
      // EasyLoading.showError("Email doesn't Exist");
      Flushbar(
        backgroundColor: Colors.red,
        message: "Email doesn't Exist",
        duration: Duration(seconds: 2),
      ).show(context);
    } else if(LoginResponse['message'] ==
        "Login validation Email Email") {
      Flushbar(
        backgroundColor: Colors.red,
        message: "Enter Valid Email",
        duration: Duration(seconds: 2),
      ).show(context);
    } else if(LoginResponse['message'] ==
        "Login validation Password Empty") {
      print("wrong");
      Flushbar(
        backgroundColor: Colors.red,
        message: "Login validation Password Empty",
        duration: Duration(seconds: 2),
      ).show(context);
    } else if(LoginResponse['message'] ==
        "Login validation Email Empty") {
      print("wrong");
      Flushbar(
        backgroundColor: Colors.red,
        message: "Enter Email First",
        duration: Duration(seconds: 2),
      ).show(context);
    } else {
      Flushbar(
        backgroundColor: Colors.red,
        message: "Something Went Wrong",
        duration: Duration(seconds: 2),
      ).show(context);
    }
  }


}