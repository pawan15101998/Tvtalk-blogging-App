import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvtalk/Authencation/google_sign_in.dart';
import 'package:tvtalk/constant/color_const.dart';
import 'package:tvtalk/constant/front_size.dart';
import 'package:tvtalk/controllers/signIn_network.dart';
import 'package:tvtalk/getxcontroller/home_page1_controller.dart';
import 'package:tvtalk/getxcontroller/signin_controller.dart';
import 'package:tvtalk/getxcontroller/your_intrest_controller.dart';
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
  final yourIntrestController = Get.find<YourIntrestController>();
  late final String? title;
  Timer? _timer;
  late double _progress;
  var signInNetwork = SignInNetwork();
  List tagdata = [];
  final homepage1controller = Get.find<HomePage1Controller>();
  String sendingTags = "";
  final colorconst = ColorConst();

  @override
  Widget build(BuildContext context) {
    // configLoading();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: colorconst.whiteColor,
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
                          backgroundColor: colorconst.transparentColor,
                          title: Align(
                            alignment: Alignment.centerRight,
                            child: InkWell(
                              onTap: () async{
                                signincontroller.isGuest.value = 'guest';
                                await apiProvider.getPost(yourIntrestController.alltagsId.toString().replaceAll('[', '').replaceAll(']', ''));
                                Router.neglect(context, () {
                                  context.goNamed('HOMEPAGE');
                                });
                              },
                              child: Text(
                                "Continue as Guest >>|",
                                style: TextStyle(
                                    color: colorconst.blackColor,
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
                        color: Color(0xff0701BF),
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
                      primary: colorconst.transparentColor,
                      onSurface: colorconst.transparentColor,
                      shadowColor: colorconst.transparentColor,
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
                  color: colorconst.whiteColor,
                  textColor: colorconst.blackColor,
                  onPress: () async {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    await provider.googleLogin();
                    String birthday = await provider.getBirthday();
                    // await provider.getGender();
                    // await provider.getGender();           
                    if (provider.user != null) {
                      // context.goNamed("SELECTYOURINTREST");
                      signincontroller.isGuest.value = '';
                      await apiProvider.PostSocial("/user/social-login",{
                        "social_login_type": "1",
                        "name": provider.user.displayName,
                        "email": provider.user.email,
                        "social_login_id": provider.user.id,
                        "image": provider.user.photoUrl,
                        "dob": signincontroller.googleUserDob!,
                        "gender": signincontroller.googleUserGender == 'male'
                            ? '0'
                            : '1'
                      });
                      final SharedPreferences sharedPreferences =
                          await SharedPreferences.getInstance();
                      sharedPreferences.setString('email', provider.user.email);
                      sharedPreferences.setString('name', provider.user.displayName);
                      sharedPreferences.setString('image', provider.user.photoUrl);
                      // sharedPreferences.setString('userId', provider.user.photoUrl);
                      signincontroller.userName = provider.user.displayName;
                      signincontroller.userEmail = provider.user.email;
                      signincontroller.image = provider.user.photoUrl;
                      var tagsss = await apiProvider.getTags();
                      for (var i = 0; i < tagsss['data'].length; i++){
                        tagdata.add(tagsss['data'][i]['tagId']);
                      }
                      sendingTags = tagdata.toString().replaceAll("[", "").replaceAll("]", "");
                      homepage1controller.userTags.value = sendingTags;
                      await apiProvider.getPost(sendingTags);
                      if (apiProvider.RegisterResponse['message'] =='Logged in successfully'){
                        await apiProvider.getprofile();
                        context.goNamed("HOMEPAGE");
                      } else if (apiProvider.RegisterResponse['message'] ==
                          'User Added Successfully') {
                        context.goNamed("SELECTYOURINTREST");
                      }
                      sharedPreferences.setString('userId', apiProvider.RegisterResponse['data']['id'].toString());
                      print("this is user Res");
                       for(int i=0; i<yourIntrestController.allTagsModel.length; i++){
                if(homepage1controller.userTagName.toString().toLowerCase().contains(yourIntrestController.alltagsName[i].toString().toLowerCase()) ){
              yourIntrestController.allTagsModel[i].activetag = true;
                    }else{
                  yourIntrestController.allTagsModel[i].activetag = false;
                 }
           }
                      
                    }
                  }),
              SizedBox(
                height: height * 2 / 100,
              ),
              loginButton(
                width: width,
                text: "Continue with Facebook",
                image: "assets/icons/facebook.png",
                color: facebookColor,
                textColor: colorconst.whiteColor,
                onPress: () async {
                  final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
                  await provider.facebookLogin();
                  if (provider.user != null) {
                    signincontroller.isGuest.value = '';
                    await apiProvider.PostSocial("/user/social-login", {
                      "social_login_type": "2",
                      "name": provider.user['name'],
                      "email": provider.user['email'],
                      "social_login_id": provider.user['id'],
                      "image": provider.user['picture']['data']['url']
                    });
                    final SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.setString(
                        'email', provider.user['email']);
                    sharedPreferences.setString('name', provider.user['name']);
                    sharedPreferences.setString(
                        'image', provider.user['picture']['data']['url']);
                    signincontroller.userName = provider.user['name'];
                    signincontroller.userEmail = provider.user['email'];
                    signincontroller.image = provider.user['picture']['data']['url'];
                        var tagsss = await apiProvider.getTags();
                      // for (var i = 0; i < tagsss['data'].length; i++){
                      //   tagdata.add(tagsss['data'][i]['tagId']);
                      // }
                      sendingTags = tagdata.toString().replaceAll("[", "").replaceAll("]", "");
                      homepage1controller.userTags.value = sendingTags;
                      await apiProvider.getPost(sendingTags);
                      if (apiProvider.RegisterResponse['message'] ==
                        'Logged in successfully') {
                      context.pushNamed("HOMEPAGE");
                    } else if (apiProvider.RegisterResponse['message'] ==
                        'User Added Successfully') {
                      context.goNamed("SELECTYOURINTREST");
                    }
                  }
                },
              ),
              SizedBox(
                height: height * 2 / 100,
              ),
              // loginButton(
              //   onPress: (){},
              //   width: width,
              //   text: "Continue with Apple",
              //   image: "assets/icons/apple.png",
              //   color: colorconst.blackColor,
              //   textColor: colorconst.whiteColor,
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
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
