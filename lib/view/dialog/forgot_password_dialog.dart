
import 'dart:ui';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:tvtalk/services/service.dart';
import 'package:tvtalk/view/dialog/reset_password_dialog.dart';
import 'package:tvtalk/widgets/text_field.dart';

class BottomDialog {
  var submitdialog = SubmitDialog();
  var apiProvider = ApiProvider();
  late String otpEmail;
  TextEditingController otpController = TextEditingController();
  void showBottomDialog(BuildContext context, String email) {
    otpEmail = email;
    showGeneralDialog(
      barrierLabel: "showGeneralDialog",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.6),
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

  Widget _buildDialogContent(context) {
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
                  Text(
                    "Forgot Password",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  RichText(
                    text: TextSpan(
                      // text: "An email has been sent to your email",
                      children: <TextSpan>[
                        TextSpan(
                          text: 'An email has been sent to your email ',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                        TextSpan(
                          text: '${otpEmail}',
                          style:
                              TextStyle(color: Color(0xfffF1B142), fontSize: 16),
                        ),
                        TextSpan(
                          text: ' Please submit the OTP to Reset Password.',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  HomePageTextField(
                    width: MediaQuery.of(context).size.width,
                    textName: "Password Reset OTP here...",
                    controller: otpController,
                  ),
                  const SizedBox(height: 16),
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
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    Colors.transparent),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                        side: BorderSide(color: Colors.black)))),
                            child: Text(
                              "Cancle",
                              style: TextStyle(color: Colors.black),
                            )),
                      ),
                      SizedBox(
                        height: 50,
                        width: 130,
                        child: ElevatedButton(
                            onPressed: () async{
                              // print(VerifyForgotPass);
                                  if (otpController.text != "") {
                                 var VerifyForgotPass= await apiProvider.Post('/user/verify-forgot-password', {
                                      'email':otpEmail.trim(),
                                      'verification_code': otpController.text.trim()
                                    }
                                        );
                                        // otpEmail.trim(),otpController.text.trim()
                                        print(VerifyForgotPass);
                                    if (VerifyForgotPass['message'] ==
                                        'OTP verified successfully.') {
                                          Navigator.pop(context);
                                      submitdialog.showBottomDialog(context, otpEmail);
                                      Flushbar(
                                    backgroundColor: Colors.green,
                                    message: "OTP verified successfully",
                                    duration: Duration(seconds: 1),
                                  ).show(context);
                                    } else if (VerifyForgotPass['message'] ==
                                        'Input validation. Verificationcode Min') {
                                      Flushbar(
                                    backgroundColor: Colors.red,
                                    message: "Input validation Verificationcode Min",
                                    duration: Duration(seconds: 1),
                                  ).show(context);
                                    }else if (VerifyForgotPass['message'] ==
                                        'Input validation. Verificationcode Max'){
                                      Flushbar(
                                    backgroundColor: Colors.red,
                                    message: "Input validation Verificationcode Max",
                                    duration: Duration(seconds: 1),
                                  ).show(context);
                                    }else if(VerifyForgotPass['message'] ==
                                        'Incorrect OTP.') {
                                      Flushbar(
                                    backgroundColor: Colors.red,
                                    message: "Incorrect OTP.",
                                    duration: Duration(seconds: 1),
                                  ).show(context);
                                    }
                                    else if (VerifyForgotPass['message'] ==
                                        'Input validation Email Email') {
                                      Flushbar(
                                    backgroundColor: Colors.red,
                                    message: "OTP not valid",
                                    duration: Duration(seconds: 1),
                                  ).show(context);
                                    }
                                  } else {
                                    Flushbar(
                                    backgroundColor: Colors.red,
                                    message: "Enter OTP",
                                    duration: Duration(seconds: 1),
                                  ).show(context);
                                  }
                            },
                            style: ButtonStyle(
                                shadowColor: MaterialStateProperty.all<Color>(
                                    Colors.black),
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    Colors.black),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12.0),
                                        side: BorderSide(color: Colors.black)))),
                            child: Text(
                              "Submit",
                              style: TextStyle(color: Colors.white),
                            )),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  Divider(),
                  const SizedBox(height: 16),
                  Center(
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Haven't received email yet?",
                          style: TextStyle(fontSize: 14, color: Colors.black)),
                      TextSpan(
                          text: "Resend",
                          style:
                              TextStyle(fontSize: 14, color: Color(0xfff0FC59A)))
                    ])),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Center(
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Wanna change above email?",
                          style: TextStyle(fontSize: 14, color: Colors.black)),
                      TextSpan(
                          text: "Change Email",
                          style:
                              TextStyle(fontSize: 14, color: Color(0xfff0FC59A)))
                    ])),
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

