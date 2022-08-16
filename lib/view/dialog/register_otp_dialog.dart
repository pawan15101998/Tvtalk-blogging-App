import 'dart:ui';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvtalk/services/service.dart';
import 'package:tvtalk/view/dialog/reset_password_dialog.dart';
import 'package:tvtalk/widgets/text_field.dart';

class RegisterOtpDialog {
  var submitdialog = SubmitDialog();
  var apiProvider = ApiProvider();
  TextEditingController otpController = TextEditingController();
  void showBottomDialog(BuildContext context, email) {
    showGeneralDialog(
      barrierLabel: "showGeneralDialog",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.6),
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
                                  text: 'An email has been sent to your email ',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                TextSpan(
                                  text: '$email',
                                  style: TextStyle(
                                      color: Color(0xfffF1B142), fontSize: 16),
                                ),
                              const  TextSpan(
                                  text: ' Please submit the OTP to Verify',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
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
                                                Colors.transparent),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.transparent),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                side:const BorderSide(
                                                    color: Colors.black)))),
                                    child:const Text(
                                      "Cancle",
                                      style: TextStyle(color: Colors.black),
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
                                       print("emails");
                                      print(emailVerify['message']);
                                      if (emailVerify['message'] ==
                                          'Verification successful.') {
                                        Navigator.pop(context);
                                        final snackBar = SnackBar(
                                          backgroundColor: Colors.green,
                                          content: const Text(
                                              "verification Successful"),
                                          action: SnackBarAction(
                                            label: '',
                                            onPressed: () {
                                              // Some code to undo the change.
                                            },
                                          ),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                        Router.neglect(context, () {
                                          context.goNamed('SELECTYOURINTREST');
                                        });
                                        print("emailData");
                                        print(email);
                                        // context.pushNamed('HOMEPAGE');
                                        // String resetToken = emailVerify['data'].reset_token;
                                        print(emailVerify['data'].reset_token);
                                        final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                        sharedPreferences.setString('email', email);
                                        // sharedPreferences.setString("reset_token", resetToken);
                                      }else if(emailVerify['message'] == 'Email already verified.'){
                                        Flushbar(
                                          backgroundColor: Colors.red,
                                          message:
                                              "Email already verified.",
                                          duration: Duration(seconds: 2),
                                        ).show(context);
                                      }else if(emailVerify['message'] =='Login validation Verificationcode Empty'){
                                        Flushbar(
                                          backgroundColor: Colors.red,
                                          message:
                                              "Login validation Verificationcode Empty",
                                          duration: Duration(seconds: 2),
                                        ).show(context);
                                      }
                                       else if (emailVerify['message'] ==
                                          'Incorrect verification code.') {
                                        Flushbar(
                                          backgroundColor: Colors.red,
                                          message:
                                              "Incorrect_verification_code",
                                          duration: Duration(seconds: 2),
                                        ).show(context);
                                      } else if (emailVerify['message'] ==
                                          'Login validation Verificationcode Min') {
                                        Flushbar(
                                          backgroundColor: Colors.red,
                                          message:
                                              "Login validation Verificationcode is 6 digit",
                                          duration: Duration(seconds: 2),
                                        ).show(context);
                                      } else if (emailVerify['message'] ==
                                          'Login validation Verificationcode Max') {
                                        Flushbar(
                                          backgroundColor: Colors.red,
                                          message:
                                              "Login validation Verificationcode is 6 digit",
                                          duration: Duration(seconds: 2),
                                        ).show(context);
                                      }
                                      print("EmailVarify");
                                      // print(
                                      //     apiProvider.EmailVarify['message']);
                                    },
                                    style: ButtonStyle(
                                        shadowColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.black),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.black),
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                                side: BorderSide(
                                                    color: Colors.black)))),
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
                                  text: "Haven't received email yet? ",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black)),
                              TextSpan(
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
                                      fontSize: 14, color: Colors.black)),
                              TextSpan(
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

//   Widget _buildDialogContent(context) {
//     return BackdropFilter(
//       filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
//       child: IntrinsicHeight(
//         child: Container(
//           width: double.maxFinite,
//           clipBehavior: Clip.antiAlias,
//           padding: const EdgeInsets.all(16),
//           decoration: const BoxDecoration(
//             color: Colors.white,
//           ),
//           child: Material(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 16),
//                 Text("Forgot Password",
//                 style: TextStyle(
//                   fontWeight: FontWeight.w600,
//                   fontSize: 16
//                 ),
//                 ),
//                 const SizedBox(height: 16),
//                 RichText(
//                   text: const TextSpan(
//                     // text: "An email has been sent to your email",
//                     children: <TextSpan>[
//                        TextSpan(
//                           text: 'An email has been sent to your email',
//                           style: TextStyle(fontSize: 16, color: Colors.black),),
//                       TextSpan(
//                           text: ' jo************il.com',
//                           style: TextStyle(color: Color(0xfffF1B142),fontSize: 16),),
//                       TextSpan(
//                           text: ' Please submit the OTP to Reset Password.',
//                           style: TextStyle(fontSize: 16, color: Colors.black),
//                           ),

//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 16),
//                 HomePageTextField(
//                     width: MediaQuery.of(context).size.width,
//                     textName: "Password Reset OTP here...",
//                     controller: otpController,
//                     ),
//                 const SizedBox(height: 16),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     SizedBox(
//                       height: 50,
//                       width: 130,
//                       child: ElevatedButton(
//                           onPressed: () {},
//                           style: ButtonStyle(
//                               shadowColor: MaterialStateProperty.all<Color>(
//                                   Colors.transparent),
//                               backgroundColor: MaterialStateProperty.all<Color>(
//                                   Colors.transparent),
//                               shape: MaterialStateProperty.all<
//                                       RoundedRectangleBorder>(
//                                   RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(12.0),
//                                       side: BorderSide(color: Colors.black)))),
//                           child: InkWell(
//                             onTap: (){
//                                Navigator.pop(context);
//                             },
//                             child: Text(
//                               "Cancle",
//                               style: TextStyle(color: Colors.black),
//                             ),
//                           )),
//                     ),
//                     SizedBox(
//                       height: 50,
//                       width: 130,
//                       child: ElevatedButton(
//                           onPressed: () {},
//                           style: ButtonStyle(
//                               shadowColor: MaterialStateProperty.all<Color>(
//                                   Colors.black),
//                               backgroundColor: MaterialStateProperty.all<Color>(
//                                   Colors.black),
//                               shape: MaterialStateProperty.all<
//                                       RoundedRectangleBorder>(
//                                   RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(12.0),
//                                       side: BorderSide(color: Colors.black)))),
//                           child: InkWell(
//                             onTap: (){
//                               Navigator.pop(context);
//                               submitdialog.showBottomDialog(context);
//                             },
//                             child: InkWell(
//                               onTap: (){
//                               apiProvider.VerifyEmail(otpController );
//                               },
//                               child: Text(
//                                 "Submit",
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ),
//                           )),
//                     )
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 Divider(),
//                 const SizedBox(height: 16),
//                 Center(
//                   child: RichText(
//                       text: TextSpan(children: [
//                     TextSpan(
//                         text: "Haven't received email yet?",
//                         style: TextStyle(fontSize: 14, color: Colors.black)),
//                     TextSpan(
//                         text: "Resend",
//                         style:
//                             TextStyle(fontSize: 14, color: Color(0xfff0FC59A)))
//                   ])),
//                 ),
//                 SizedBox(
//                   height: 14,
//                 ),
//                 Center(
//                   child: RichText(
//                       text: TextSpan(children: [
//                     TextSpan(
//                         text: "Wanna change above email?",
//                         style: TextStyle(fontSize: 14, color: Colors.black)),
//                     TextSpan(
//                         text: "Change Email",
//                         style:
//                             TextStyle(fontSize: 14, color: Color(0xfff0FC59A)))
//                   ])),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
}
