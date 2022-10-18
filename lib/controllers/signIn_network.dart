import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvtalk/getxcontroller/home_page1_controller.dart';
import 'package:tvtalk/getxcontroller/signin_controller.dart';
import 'package:tvtalk/routers.dart';
import 'package:tvtalk/services/service.dart';
import 'package:tvtalk/view/dialog/forgot_password_dialog.dart';
import 'package:tvtalk/view/home_page.dart';
import 'package:tvtalk/view/profile_page.dart';

class SignInNetwork {
  var apiProvider = ApiProvider();
  var bottomDialog = BottomDialog();
  final signincontroller = Get.find<SignInController>();
  List tagdata = [];
  final homepage1controller = Get.find<HomePage1Controller>();
  String sendingTags = "";

  forgotPassword(context, loginEmailController) async {
    if (loginEmailController != ""){
   var ForgotPass = await apiProvider.Post('/user/forgot-password', {
        'email': loginEmailController
      });

      if (ForgotPass['message'] == 'Email does not exist') {
        final snackBar = SnackBar(
          backgroundColor: colorconst.redColor,
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
        Flushbar(
        backgroundColor: colorconst.greenColor,
        message: "Mail Sent successfully ",
        duration: Duration(seconds: 2),
      ).show(context);
      } else if (ForgotPass['message'] == 'Email not found.') {
        final snackBar = SnackBar(
          backgroundColor: colorconst.redColor,
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
        final snackBar = SnackBar(
          backgroundColor: colorconst.redColor,
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
        
        final snackBar = SnackBar(
          backgroundColor: colorconst.redColor,
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
        backgroundColor: colorconst.redColor,
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

    if(LoginResponse['message'] == 'Logged in successfully') {
      String resetToken = LoginResponse['data']['reset_token'];
      String userName = LoginResponse['data']['name'];
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('email', loginEmailController);
      sharedPreferences.setString("name", LoginResponse['data']['name']);
      sharedPreferences.setString("reset_token", resetToken);
      sharedPreferences.setString("userId", LoginResponse['data']['id'].toString());
      String? token = await FirebaseMessaging.instance.getToken();

      apiProvider.postApi("/user/fcm-token", {"fcm_token": token});

      signincontroller.userName = LoginResponse['data']['name'];
      signincontroller.userEmail = loginEmailController;

      var tagsss=  await apiProvider.getTags();
       await  apiProvider.getArticleStatus();
       for(int i =0; i<homePageController.readArticle.length; i++){
        homePageController.readArticleId.add(homePageController.readArticle[i]['articleId']);
       }
       for(int i =0; i<homepage1controller.allpostdata.length; i++){
        homePageController.allPostId.add(homepage1controller.allpostdata[i].id);
       }




    for(var i= 0; i<tagsss['data'].length; i++){
     tagdata.add(tagsss['data'][i]['tagId']);
    }
     sendingTags = tagdata.toString().replaceAll("[", "").replaceAll("]", "");
     homepage1controller.userTags.value = sendingTags;
      await apiProvider.getPost(sendingTags);
      await apiProvider.getprofile();
      // context.pushNamed('HOMEPAGE');
     signincontroller.isGuest.value = '';
           await  apiProvider.getArticleStatus();
           homePageController.readArticleId.value = [];
           homePageController.allPostId.value = [];
     for(int i =0; i<homePageController.readArticle.length; i++){
        homePageController.readArticleId.add(homePageController.readArticle[i]['articleId']);
       }
       for(int i =0; i<homepage1controller.allpostdata.length; i++){
        homePageController.allPostId.add(homepage1controller.allpostdata[i].id);
       }
       for(int i = 1; i<homePageController.allPostId.length; i++){
        if(homePageController.readArticleId.contains(homePageController.allPostId[i])){
          homepage1controller.copydata[i].read = true;
           homepage1controller.allpostdata[i].read = true;
          // homepage1controller.allpostdata.add({"read": true});
        }else{
          homepage1controller.copydata[i].read = false;
          homepage1controller.allpostdata[i].read = false;
        }
       }
       final snackBar = SnackBar(
        content: const Text('Logged in successfully'),
        backgroundColor: colorconst.greenColor,
        action: SnackBarAction(
          label: '',
          onPressed:(){
            // Some code to undo the change.
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Router.neglect(context, () {context.goNamed('HOMEPAGE');});
    } else if(LoginResponse['message'] ==
        'Wrong password entered.'){
      Flushbar(
        backgroundColor: colorconst.redColor,
        message: "Wrong password entered",
        duration: Duration(seconds: 2),
      ).show(context);
    }else if(LoginResponse['message'] ==
        'Login validation Password Pattern'){
          Flushbar(
        backgroundColor: colorconst.redColor,
        message: "Login validation Password Pattern",
        duration: Duration(seconds: 2),
      ).show(context);
    } else if(LoginResponse['message'] == "Email does not exist.") {
      // EasyLoading.showError("Email doesn't Exist");
      Flushbar(
        backgroundColor: colorconst.redColor,
        message: "Email doesn't Exist",
        duration: Duration(seconds: 2),
      ).show(context);
    } else if(LoginResponse['message'] ==
        "Login validation Email Email") {
      Flushbar(
        backgroundColor: colorconst.redColor,
        message: "Enter Valid Email",
        duration: Duration(seconds: 2),
      ).show(context);
    } else if(LoginResponse['message'] ==
        "Login validation Password Empty") {
      Flushbar(
        backgroundColor: colorconst.redColor,
        message: "Login validation Password Empty",
        duration: Duration(seconds: 2),
      ).show(context);
    } else if(LoginResponse['message'] ==
        "Login validation Email Empty") {
      Flushbar(
        backgroundColor: colorconst.redColor,
        message: "Enter Email First",
        duration: Duration(seconds: 2),
      ).show(context);
    } else {
      Flushbar(
        backgroundColor: colorconst.redColor,
        message: "Something Went Wrong",
        duration: Duration(seconds: 2),
      ).show(context);
    }
  }
}