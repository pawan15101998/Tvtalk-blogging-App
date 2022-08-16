import 'dart:ui';
import 'package:go_router/go_router.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:tvtalk/services/service.dart';
import 'package:tvtalk/widgets/text_field.dart';

class SubmitDialog {
  TextEditingController newpasswordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  var apiProvider = ApiProvider();
  late String resetEmail;
  void showBottomDialog(BuildContext context, String otpEmail) {
    resetEmail = otpEmail;
    showGeneralDialog(
      barrierLabel: "showGeneralDialog",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 400),
      context: context,
      pageBuilder: (context, _, __) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: _buildDialogContent(context),
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

  Widget _buildDialogContent(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        child: IntrinsicHeight(
          child: Container(
            width: double.maxFinite,
            clipBehavior: Clip.antiAlias,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Material(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                 const Text(
                    "Reset password",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text("Create a new password"),
                  const SizedBox(height: 16),
                  HomePageTextField(
                    width: MediaQuery.of(context).size.width,
                    textName: "New Password",
                    controller: newpasswordController,
                  ),
                  const SizedBox(height: 16),
                  HomePageTextField(
                    width: MediaQuery.of(context).size.width,
                    textName: "Confirm New Password",
                    controller: confirmpasswordController,
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 130,
                        child: ElevatedButton(
                            onPressed: () {
                               Navigator.pop(context);
                            },
                            style: ButtonStyle(
                                shadowColor: MaterialStateProperty.all<Color>(
                                    Colors.transparent),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.transparent),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        side:
                                            BorderSide(color: Colors.black)))),
                            child: const Text(
                              "Cancle",
                              style: TextStyle(color: Colors.black),
                            )),
                      ),
                      SizedBox(
                        height: 50,
                        width: 130,
                        child: ElevatedButton(
                            onPressed: () async {
                              if (newpasswordController.text != "" &&
                                  confirmpasswordController.text != "") {
                                if (newpasswordController.text ==
                                    confirmpasswordController.text) {
                               var ResetForgotPass =   await apiProvider.Post('/user/reset-forgot-password',{
                                          'email':resetEmail.trim(),
                                          'new_password':confirmpasswordController.text.trim()
                                  }
                                      // resetEmail.trim(),
                                      // confirmpasswordController.text.trim()
                                      );
                                  print("passwordReset");
                                  print(ResetForgotPass);
                                  if (ResetForgotPass['message'] ==
                                      'Password reset successful.') {
                                    final snackBar = SnackBar(
                                      backgroundColor: Colors.green,
                                      content: const Text(
                                          'Password reset successful'),
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
                                      backgroundColor: Colors.red,
                                      message:
                                          "Password length must be greater then 4 that  include at least  UPPERCASE letter  LOWERCASE letter number and special character(ex. @, !)",
                                      duration: Duration(seconds: 2),
                                    ).show(context);
                                  }else if (ResetForgotPass['message'] ==
                                      'Input validation Newpassword Pattern') {
                                    Flushbar(
                                      backgroundColor: Colors.red,
                                      message:
                                          "Password length must be greater then 4 that  include at least  UPPERCASE letter  LOWERCASE letter number and special character(ex. @, !)",
                                      duration: Duration(seconds: 2),
                                    ).show(context);
                                  }else{
                                    Flushbar(
                                      backgroundColor: Colors.red,
                                      message:
                                          "something Went Wrong",
                                      duration: Duration(seconds: 2),
                                    ).show(context);
                                  }
                                } else {
                                  Flushbar(
                                    backgroundColor: Colors.red,
                                    message: "Both password not matched",
                                    duration: Duration(seconds: 1),
                                  ).show(context);
                                }
                              } else {
                                if (newpasswordController.text == "") {
                                  Flushbar(
                                    backgroundColor: Colors.red,
                                    message: "Enter new password",
                                    duration: Duration(seconds: 1),
                                  ).show(context);
                                } else if (confirmpasswordController.text ==
                                    "") {
                                  Flushbar(
                                    backgroundColor: Colors.red,
                                    message: "Enter confirm password",
                                    duration: Duration(seconds: 1),
                                  ).show(context);
                                }
                              }
                            },
                            style: ButtonStyle(
                                shadowColor: MaterialStateProperty.all<Color>(
                                    Colors.black),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        side:
                                            BorderSide(color: Colors.black)))),
                            child: Text(
                              "Reset Password",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 13),
                            )),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
