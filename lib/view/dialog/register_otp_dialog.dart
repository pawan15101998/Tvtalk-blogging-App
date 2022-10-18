import 'dart:ui';
import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvtalk/constant/color_const.dart';
import 'package:tvtalk/services/service.dart';
import 'package:tvtalk/view/dialog/reset_password_dialog.dart';
import 'package:tvtalk/widgets/text_field.dart';

class RegisterOtpDialog {
  var submitdialog = SubmitDialog();
  var apiProvider = ApiProvider();
  final colorconst = ColorConst();
  TextEditingController otpController = TextEditingController();
  void showBottomDialog(BuildContext context, email, name,  password, cnfpassword ) {
    showGeneralDialog(
      barrierLabel: "showGeneralDialog",
      barrierDismissible: true,
      barrierColor: colorconst.blackColor.withOpacity(0.6),
      transitionDuration: const Duration(milliseconds: 400),
      context: context,
      pageBuilder: (BuildContext context, _, __) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Align(
              alignment: Alignment.bottomCenter,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: IntrinsicHeight(
                  child: Container(
                    width: double.maxFinite,
                    clipBehavior: Clip.antiAlias,
                    padding:  EdgeInsets.all(16),
                    decoration:  BoxDecoration(
                      color: colorconst.whiteColor,
                    ),
                    child: Material(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          Text(
                            "Please verify your email",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 16),
                          ),
                          const SizedBox(height: 16),
                          RichText(
                            text: TextSpan(
                              // text: "An email has been sent to your email",
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'An OTP has been sent to your email ',
                                  style: TextStyle(
                                      fontSize: 16, color: colorconst.blackColor),
                                ),
                                TextSpan(
                                  text: '$email',
                                  style: TextStyle(
                                      color: colorconst.lightYellow, fontSize: 16),
                                ),
                                TextSpan(
                                  text: ' Please submit the OTP to Verify',
                                  style: TextStyle(
                                      fontSize: 16, color: colorconst.blackColor),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          HomePageTextField(
                            width: MediaQuery.of(context).size.width,
                            textName: "Verification OTP here...",
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
                                        shadowColor:
                                            MaterialStateProperty.all<Color>(
                                                colorconst.transparentColor),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                colorconst.transparentColor),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                side: BorderSide(
                                                    color: colorconst.blackColor)))),
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(color: colorconst.blackColor),
                                    )),
                              ),
                              SizedBox(
                                height: 50,
                                width: 130,
                                child: ElevatedButton(
                                    onPressed: () async {  
                                      var emailVerify = await apiProvider.Post(
                                          "/user/verify", {
                                        'email': email,
                                        'verification_code': otpController.text
                                      });
                                     
                                      if (emailVerify['message'] ==
                                          'Verification successful.') {
                                        Navigator.pop(context);
                                        final snackBar = SnackBar(
                                          backgroundColor: colorconst.greenColor,
                                          content: const Text(
                                              "verification Successful"),
                                          action: SnackBarAction(
                                            label: '',
                                            onPressed: () {
                                              // Some code to undo the change.
                                            },
                                          ),
                                        );
                                        final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                        sharedPreferences.setString("email", email);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                        Router.neglect(context, () {
                                          context.goNamed('SELECTYOURINTREST');
                                        });
                                      
                                        // context.pushNamed('HOMEPAGE');
                                        // String resetToken = emailVerify['data'].reset_token;
                                        sharedPreferences.setString('email', email);
                                        String? token = await FirebaseMessaging.instance.getToken();
                                        apiProvider.postApi("/user/fcm-token", {"fcm_token": token});
                                        // sharedPreferences.setString("reset_token", resetToken);
                                      }else if(emailVerify['message'] == 'Email already verified.'){
                                        Flushbar(
                                          backgroundColor: colorconst.redColor,
                                          message:
                                              "Email already verified.",
                                          duration: Duration(seconds: 2),
                                        ).show(context);
                                      }else if(emailVerify['message'] =='Login validation Verificationcode Empty'){
                                        Flushbar(
                                          backgroundColor: colorconst.redColor,
                                          message:
                                              "Login validation Verificationcode Empty",
                                          duration: Duration(seconds: 2),
                                        ).show(context);
                                      }
                                       else if (emailVerify['message'] ==
                                          'Incorrect verification code.') {
                                        Flushbar(
                                          backgroundColor: colorconst.redColor,
                                          message:
                                              "Incorrect_verification_code",
                                          duration: Duration(seconds: 2),
                                        ).show(context);
                                      } else if (emailVerify['message'] ==
                                          'Login validation Verificationcode Min') {
                                        Flushbar(
                                          backgroundColor: colorconst.redColor,
                                          message:
                                              "Login validation Verificationcode is 6 digit",
                                          duration: Duration(seconds: 2),
                                        ).show(context);
                                      } else if (emailVerify['message'] ==
                                          'Login validation Verificationcode Max') {
                                        Flushbar(
                                          backgroundColor: colorconst.redColor,
                                          message:
                                              "Login validation Verificationcode is 6 digit",
                                          duration: Duration(seconds: 2),
                                        ).show(context);
                                      }
                                  
                                    },
                                    style: ButtonStyle(
                                        shadowColor:
                                            MaterialStateProperty.all<Color>(
                                                colorconst.blackColor),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                colorconst.blackColor),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                side: BorderSide(
                                                    color: colorconst.blackColor)))),
                                    child: Text(
                                      "Submit",
                                      style: TextStyle(color: colorconst.whiteColor),
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
                                  text: "Haven't received email yet? ",
                                  style: TextStyle(
                                      fontSize: 14, color: colorconst.blackColor)),
                              TextSpan(
                                recognizer: TapGestureRecognizer()..onTap = ()async{
                          if(password == cnfpassword){
                              await apiProvider.Post('/user/signup', {
                                'name':name,
                                'email':email,
                                'password':password,
                                'confirm_password':cnfpassword   
                                 });
                                 if(apiProvider.RegisterResponse['message'] =='Email already exists and otp sent again'){
                                  Flushbar(
                                      backgroundColor: colorconst.greenColor,
                                      message: "Email already exists and otp sent again",
                                      duration: Duration(seconds: 1),
                                    ).show(context);
                                 }
                          }
                 
                           if(apiProvider.RegisterResponse['message'] == 'Mail sent successfully.'){
                             Flushbar(
          backgroundColor: colorconst.greenColor,
          message: "otp resend to your mail",
          duration: Duration(seconds: 1),
        ).show(context);
                           }
                        },
                                  text: "Resend",
                                  style: TextStyle(
                                      fontSize: 14, color: Color(0xfff0FC59A)))
                            ])),
                          ),
                          SizedBox(
                            height: 14,
                          ),
                          Center(
                            child: RichText(
                                text: TextSpan(children: [
                              TextSpan(
                                  text: "Wanna change above email? ",
                                  style: TextStyle(
                                      fontSize: 14, color: colorconst.blackColor)),
                              TextSpan(
                                  recognizer: TapGestureRecognizer()..onTap = (){
                                  Navigator.pop(context);
                                   },
                                  text: "Change Email",
                                  style: TextStyle(
                                      fontSize: 14, color: Color(0xfff0FC59A)))
                            ])),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
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
}
