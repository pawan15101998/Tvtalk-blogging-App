
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvtalk/Authencation/google_sign_in.dart';
import 'package:tvtalk/constant/front_size.dart';
import 'package:tvtalk/controllers/register_network.dart';
import 'package:tvtalk/getxcontroller/signin_controller.dart';
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
  final signincontroller = Get.find<SignInController>();

 
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
              Container(
          width: MediaQuery.of(context).size.width * 90 / 100,
          height: textSize.getadaptiveTextSize(context, 45),
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: TextFieldColor),
          child: Obx(() {
              return TextFormField(
                  obscureText: signincontroller.cnfpasswordVisiblity.value == false ? true : false,
                  controller: cnfpasswordController,
                  decoration: InputDecoration(
                      fillColor: const Color(0xffFEDC5D),
                      border: InputBorder.none,
                      label: Text("Confirm Password"),
                      suffixIcon: IconButton(
                        onPressed: (){
                          signincontroller.cnfpasswordVisiblity.toggle();
                        },
                  icon: 
                Icon(
                (signincontroller.cnfpasswordVisiblity.value)
                 ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black,
                )
             
                )
                          // textfieldLogic.sufixIcon(widget.textName, _passwordVisible)
                          )
                          );
            }
          ),
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
                  signincontroller.userName = provider.user.displayName;
                  signincontroller.userEmail = provider.user.email;
                  signincontroller.image = provider.user.photoUrl;
                  // context.pop();
                  // context.pushNamed("HOMEPAGE");
                    // context.goNamed("SELECTYOURINTREST");
                   await apiProvider.PostSocial("/user/social-login", 
                    {"social_login_type": "1",
                     "name": provider.user.displayName,
                     "email":provider.user.email,
                     "social_login_id":provider.user.id,
                     "image":provider.user.photoUrl
                    });
                    if(apiProvider.RegisterResponse['message'] == 'Logged in successfully'){
                       context.goNamed("HOMEPAGE");
                    }else if(apiProvider.RegisterResponse['message'] == 'User Added Successfully'){
                       context.goNamed("SELECTYOURINTREST");
                    }
                    signincontroller.isGuest.value = '';
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
                    signincontroller.userName = provider.user['name'];
                    signincontroller.userEmail = provider.user['email'];
                    signincontroller.image =  provider.user['picture']['data']['url'];
                    // context.goNamed("SELECTYOURINTREST");
                   await  apiProvider.PostSocial("/user/social-login", 
                    {"social_login_type": "2",
                     "name": provider.user['name'],
                     "email":provider.user['email'],
                     "social_login_id":provider.user['id'],
                     "image":provider.user['picture']['data']['url']
                    });
                    if(apiProvider.RegisterResponse['message'] == 'Logged in successfully'){
                       context.goNamed("HOMEPAGE");
                    }else if(apiProvider.RegisterResponse['message'] == 'User Added Successfully'){
                       context.goNamed("SELECTYOURINTREST");
                    }
                    signincontroller.isGuest.value = '';
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
