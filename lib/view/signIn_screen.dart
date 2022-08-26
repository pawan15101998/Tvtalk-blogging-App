import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvtalk/Authencation/google_sign_in.dart';
import 'package:tvtalk/constant/front_size.dart';
import 'package:tvtalk/controllers/signIn_network.dart';
import 'package:tvtalk/getxcontroller/signin_controller.dart';
import 'package:tvtalk/services/service.dart';
import 'package:tvtalk/theme/buttonTheme/button_theme.dart';
import 'package:tvtalk/theme/text_style.dart';
import 'package:tvtalk/theme/theme.dart';
import 'package:tvtalk/widgets/login_button.dart';
import 'package:tvtalk/widgets/text_field.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var textSize = const AdaptiveTextSize();
  var apiProvider = ApiProvider();
  final signincontroller = Get.find<SignInController>();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginpasswordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  late final String? title;
  Timer? _timer;
  late double _progress;
  var signInNetwork = SignInNetwork();

  @override
  Widget build(BuildContext context) {
    // configLoading();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                            child: InkWell(
                              onTap: (){
                                signincontroller.isGuest.value = 'guest';
                                  Router.neglect(context, () {context.goNamed('HOMEPAGE');});
                              },
                              child: Text(
                                "Continue as Guest >>|",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: textSize.getadaptiveTextSize(
                                        context, 12)),
                              ),
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
                "Log In",
                style: textStyleLogin1,
              ),
              SizedBox(
                height: height * 3 / 100,
              ),
              HomePageTextField(
                width: width,
                textName: "Email",
                controller: loginEmailController,
              ),
              SizedBox(
                height: height * 3 / 100,
              ),
              HomePageTextField(
                width: width,
                textName: "Password",
                controller: loginpasswordController,
              ),
              SizedBox(
                height: height * 2 / 100,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      signInNetwork.forgotPassword(
                          context, loginEmailController.text.trim());
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        // fontFamily: 'ExtraLight',
                        color: Color(0xfff0701BF),
                        // fontFamily: 'Quicksand'
                      ),
                    ),
                  ),
                ),
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
                    // clearsession
                    signInNetwork.logInFunction(
                        context,
                        loginEmailController.text.trim(),
                        loginpasswordController.text.trim());
                  },
                  child: Text(
                    "Log In",
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
                  print("userinfo from googl");
                  print(provider.user);
                  print(provider.user.displayName);
                  print(provider.user.email);
                  print(provider.user.id);
                  print(provider.user.photoUrl);
                  if(provider.user != null){
                    // context.goNamed("SELECTYOURINTREST");
                    signincontroller.isGuest.value = '';
                    await  apiProvider.PostSocial("/user/social-login", 
                    {"social_login_type": "1",
                     "name": provider.user.displayName,
                     "email":provider.user.email,
                     "social_login_id":provider.user.id,
                     "image":provider.user.photoUrl
                    });
                    print("ssssssddd");
                    if(apiProvider.RegisterResponse['message'] == 'Logged in successfully'){
                       context.goNamed("HOMEPAGE");
                    }else if(apiProvider.RegisterResponse['message'] == 'User Added Successfully'){
                       context.goNamed("SELECTYOURINTREST");
                    }
                    
                  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  sharedPreferences.setString('email', provider.user.email);
                  sharedPreferences.setString('name', provider.user.displayName);
                  sharedPreferences.setString('image', provider.user.photoUrl);
                  signincontroller.userName = provider.user.displayName;
                  signincontroller.userEmail = provider.user.email;
                  signincontroller.image = provider.user.photoUrl;
                  // context.pop();
                  // context.pushNamed("HOMEPAGE");  
                  }
                }
              ),
              SizedBox(
                height: height * 2 / 100,
              ),
              loginButton(
                width: width,
                text: "Continue with Facebook",
                image: "assets/icons/facebook.png",
                color: facebookColor,
                textColor: Colors.white,
                onPress: ()async{
                  final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                 await provider.facebookLogin();
                  if(provider.user != null){
                    print("facebook email");
                    context.goNamed("SELECTYOURINTREST");
                    signincontroller.isGuest.value = '';
                   await apiProvider.PostSocial("/user/social-login", 
                    {"social_login_type": "2",
                     "name": provider.user['name'],
                     "email":provider.user['email'],
                     "social_login_id":provider.user['id'],
                     "image":provider.user['picture']['data']['url']
                    });
                    print("ssssssssss");
                    print(apiProvider.RegisterResponse['message']);
                    if(apiProvider.RegisterResponse['message'] == 'Logged in successfully'){
                       context.goNamed("HOMEPAGE");
                    }else if(apiProvider.RegisterResponse['message'] == 'User Added Successfully'){
                       context.goNamed("SELECTYOURINTREST");
                    }
                    // if(socialres== )
                    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                    sharedPreferences.setString('email', provider.user['email']);
                    sharedPreferences.setString('name', provider.user['name']);
                    sharedPreferences.setString('image', provider.user['picture']['data']['url']);
                    signincontroller.userName = provider.user['name'];
                    signincontroller.userEmail = provider.user['email'];
                    signincontroller.image =  provider.user['picture']['data']['url'];
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
                  const Text("Not a member already?"),
                  const SizedBox(
                    width: 2,
                  ),
                  InkWell(
                    onTap: () {
                      context.pushNamed('REGISTER');
                    },
                    child: const Text(
                      "Register",
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
