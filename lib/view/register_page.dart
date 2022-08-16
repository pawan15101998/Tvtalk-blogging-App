import 'dart:convert';
import 'dart:ui';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvtalk/Authencation/google_sign_in.dart';
import 'package:tvtalk/constant/front_size.dart';
import 'package:tvtalk/controllers/register_network.dart';
import 'package:tvtalk/services/service.dart';
import 'package:tvtalk/theme/buttonTheme/button_theme.dart';
import 'package:tvtalk/theme/text_style.dart';
import 'package:tvtalk/theme/theme.dart';
import 'package:tvtalk/view/dialog/register_otp_dialog.dart';
import 'package:tvtalk/view/dialog/reset_password_dialog.dart';
import 'package:tvtalk/view/signIn_screen.dart';
import 'package:tvtalk/widgets/login_button.dart';
import 'package:tvtalk/widgets/text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var textSize = AdaptiveTextSize();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cnfpasswordController = TextEditingController();
  var apiProvider = ApiProvider();
  var registerNetwork = RegisterNetwork();

 
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar:
      body: SingleChildScrollView(
        child: SizedBox(
          // height: height,
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PreferredSize(
                  preferredSize: Size.fromHeight(
                      MediaQuery.of(context).size.height * 1 / 4),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 1 / 3,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          mainColor,
                          mainColor,
                          mainColor,
                          whiteColor,
                        ])),
                    child: Column(
                      children: [
                        AppBar(
                          elevation: 0,
                          // backgroundColor: Col,
                          backgroundColor: Colors.transparent,
                          title: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Continue as Guest >>|",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: textSize.getadaptiveTextSize(
                                      context, 12)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 45,
                        ),
                        Container(
                          // margin: EdgeInsets.only(top: 40),
                          height: 38,
                          width: 174,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage(
                              "assets/images/logo.png",
                            ),
                            fit: BoxFit.cover,
                          )),
                        )
                      ],
                    ),
                  )),
              Text(
                "Register",
                style: textStyleLogin1,
              ),
              SizedBox(
                height: height * 3 / 100,
              ),
              HomePageTextField(
                width: width,
                textName: "Name",
                controller: nameController,
              ),
              SizedBox(
                height: height * 3 / 100,
              ),
              HomePageTextField(
                width: width,
                textName: "Email",
                controller: emailController,
              ),
              SizedBox(
                height: height * 3 / 100,
              ),
              HomePageTextField(
                width: width,
                textName: "Password",
                controller: passwordController,
              ),
              SizedBox(
                height: height * 3 / 100,
              ),
              HomePageTextField(
                width: width,
                textName: "Confirm Password",
                controller: cnfpasswordController,
              ),
              SizedBox(
                height: height * 2 / 100,
              ),
              SizedBox(
                height: height * 3 / 100,
              ),
              Container(
                width: width * 90 / 100,
                height: height * 7 / 100,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [logincolor1, logincolor2, logincolor3]),
                    borderRadius: BorderRadius.circular(10)),
                child: ElevatedButton(
                  onPressed: () async {
                    apiProvider.get();
                    registerNetwork.registerFunction(
                    context, 
                    passwordController.text.trim(), 
                    cnfpasswordController.text.trim(), 
                    nameController.text.trim(), 
                    emailController.text.trim(),
                    );
                  },
                  child: Text(
                    "Register",
                    style: textStyleButton,
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.transparent,
                      onSurface: Colors.transparent,
                      shadowColor: Colors.transparent,
                      // padding: EdgeInsets.symmetric(horizontal: width*10/100,),
                      textStyle: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold)),
                ),
              ),
              SizedBox(
                height: height * 5 / 100,
              ),
              loginButton(
                width: width,
                text: "Continue with Google",
                image: "assets/icons/google.png",
                color: Colors.white,
                textColor: Colors.black,
                onPress: ()async{
                  final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                await  provider.googleLogin();
                  print("userinfo from google");
                  print(provider.user.email);
                  if(provider.user != null){
                  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  sharedPreferences.setString('email', provider.user.email);
                  // context.pop();
                  // context.pushNamed("HOMEPAGE");
                    context.goNamed("HOMEPAGE");
                  }
                },
              ),
              SizedBox(
                height: height * 2 / 100,
              ),
              loginButton(
                width: width,
                text: "Continue with facebook",
                image: "assets/icons/facebook.png",
                color: facebookColor,
                textColor: Colors.white,
                 onPress: ()async{
                  final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                 await provider.facebookLogin();
                  if(provider.user != null){
                    print("facebook email");
                    print(provider.user['email']);
                    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    sharedPreferences.setString('email', provider.user['email']);
                    context.goNamed("HOMEPAGE");
                    print("facebookdata");
                    print(provider.user);
                  }
                },
              ),
              SizedBox(
                height: height * 2 / 100,
              ),
              // loginButton(
              //   width: width,
              //   text: "Continue with Apple",
              //   image: "assets/icons/apple.png",
              //   color: Colors.black,
              //   textColor: Colors.white,
              // ),
              // SizedBox(
              //   height: height * 2 / 100,
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already a member?"),
                  SizedBox(
                    width: 2,
                  ),
                  InkWell(
                    onTap: () {
                      context.pushNamed('SIGNINPAGE');
                    },
                    child: Text(
                      "Log In",
                      style: TextStyle(
                          color: Color(0xfff0FC59A),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
