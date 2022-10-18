import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tvtalk/constant/color_const.dart';
import 'package:tvtalk/services/service.dart';
import 'package:tvtalk/view/dialog/reset_password_dialog.dart';

class DialogNetwork {
  var apiProvider = ApiProvider();
  var submitdialog = SubmitDialog();
  final colorconst = ColorConst();
  forgotPassword(context, otpController, otpEmail) async {
    if (otpController != "") {
      var VerifyForgotPass = await apiProvider.Post(
          '/user/verifyForgotPassword',
          {'email': otpEmail, 'verification_code': otpController});
      if (VerifyForgotPass['message'] == 'OTP verified successfully') {
        Navigator.pop(context);
        // submitdialog.showBottomDialog(context, otpEmail);
        Flushbar(
          backgroundColor: colorconst.greenColor,
          message: "OTP verified successfully",
          duration: Duration(seconds: 1),
        ).show(context);
      } else if (VerifyForgotPass['message'] ==
          'Input validation Verificationcode Min') {
        Flushbar(
          backgroundColor: colorconst.redColor,
          message: "Input validation Verificationcode Min",
          duration: Duration(seconds: 1),
        ).show(context);
      } else if (VerifyForgotPass['message'] ==
          'Input validation Verificationcode Max') {
        Flushbar(
          backgroundColor: colorconst.redColor,
          message: "Input validation Verificationcode Max",
          duration: Duration(seconds: 1),
        ).show(context);
      } else if (VerifyForgotPass['message'] == 'incorrect OTP') {
        Flushbar(
          backgroundColor: colorconst.redColor,
          message: "incorrect OTP",
          duration: Duration(seconds: 1),
        ).show(context);
      } else if (VerifyForgotPass['message'] ==
          'Input validation Email Email') {
        Flushbar(
          backgroundColor: colorconst.redColor,
          message: "OTP not valid",
          duration: Duration(seconds: 1),
        ).show(context);
      }
    } else {
      Flushbar(
        backgroundColor: colorconst.redColor,
        message: "Enter OTP",
        duration: Duration(seconds: 1),
      ).show(context);
    }
  }

  registerOtp(BuildContext context, email, otpController) async {
    var EmailVarify = await apiProvider.Post(
        "/user/verify", {'email': email, 'verification_code': otpController});
    if (EmailVarify['message'] == 'verification Successful') {
      Navigator.pop(context);
      final snackBar = SnackBar(
        backgroundColor: colorconst.greenColor,
        content: const Text("verification Successful"),
        action: SnackBarAction(
          label: '',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      context.pushNamed('HOMEPAGE');
    } else if (EmailVarify['message'] == 'Incorrect_verification_code') {
      Flushbar(
        backgroundColor: colorconst.redColor,
        message: "Incorrect_verification_code",
        duration: Duration(seconds: 2),
      ).show(context);
    } else if (EmailVarify['message'] ==
        'Login validation Verificationcode Min') {
      Flushbar(
        backgroundColor: colorconst.redColor,
        message: "Login validation Verificationcode is 6 digit",
        duration: Duration(seconds: 2),
      ).show(context);
    } else if (EmailVarify['message'] ==
        'Login validation Verificationcode Max') {
      Flushbar(
        backgroundColor: colorconst.redColor,
        message: "Login validation Verificationcode is 6 digit",
        duration: Duration(seconds: 2),
      ).show(context);
    }

  }

  resetPassword(BuildContext context, newpasswordController, confirmpasswordController,
      resetEmail) async {
    if (newpasswordController != "" && confirmpasswordController != "") {
      if (newpasswordController == confirmpasswordController) {
        var ResetForgotPass = await apiProvider.Post(
            '/user/resetForgotPassword', {
          'email': resetEmail,
          'newPassword': confirmpasswordController
        });

        if (ResetForgotPass['message'] == 'Password reset successful') {
          final snackBar = SnackBar(
            backgroundColor: colorconst.greenColor,
            content: const Text('Password reset successful'),
            action: SnackBarAction(
              label: '',
              onPressed: () {
                // Some code to undo the change.
              },
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          context.pushNamed('SIGNINPAGE');
          // context.pushNamed
        } else if (ResetForgotPass['message'] ==
            'Input validation Email Email') {
          Flushbar(
            backgroundColor: colorconst.redColor,
            message:
                "Password length must be greater then 4 that  include at least  UPPERCASE letter  LOWERCASE letter number and special character(ex. @, !)",
            duration: Duration(seconds: 2),
          ).show(context);
        } else if (ResetForgotPass['message'] ==
            'Input validation Newpassword Pattern') {
          Flushbar(
            backgroundColor: colorconst.redColor,
            message:
                "Password length must be greater then 4 that  include at least  UPPERCASE letter  LOWERCASE letter number and special character(ex. @, !)",
            duration: Duration(seconds: 2),
          ).show(context);
        } else {
          Flushbar(
            backgroundColor: colorconst.redColor,
            message: "something Went Wrong",
            duration: Duration(seconds: 2),
          ).show(context);
        }
      } else {
        Flushbar(
          backgroundColor: colorconst.redColor,
          message: "Both password not matched",
          duration: Duration(seconds: 1),
        ).show(context);
      }
    } else {
      if (newpasswordController == "") {
        Flushbar(
          backgroundColor: colorconst.redColor,
          message: "Enter new password",
          duration: Duration(seconds: 1),
        ).show(context);
      } else if (confirmpasswordController == "") {
        Flushbar(
          backgroundColor: colorconst.redColor,
          message: "Enter confirm password",
          duration: Duration(seconds: 1),
        ).show(context);
      }
    }
  }
}
