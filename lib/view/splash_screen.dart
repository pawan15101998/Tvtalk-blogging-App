import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvtalk/getxcontroller/home_page1_controller.dart';
import 'package:tvtalk/getxcontroller/signin_controller.dart';
import 'package:tvtalk/getxcontroller/your_intrest_controller.dart';
import 'package:tvtalk/services/service.dart';
import 'package:tvtalk/view/home_page.dart';
import 'package:tvtalk/view/profile_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{
late final finalEmail;
final apiProvider = ApiProvider();
  final signincontroller = Get.find<SignInController>();
final homepage1controller = Get.find<HomePage1Controller>();
 var yourIntrestController = Get.find<YourIntrestController>();
 String sendingTags = "";
List tagdata = [];
// getcallapi()async{
//     await  apiProvider.get();
// }
  @override
  void initState() {
    // getcallapi();
    // TODO: implement initState
    getValidation().whenComplete(()async{
     await signincontroller.getuserdata();
     await apiProvider.get();
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? resetToken = sharedPreferences.getString('reset_token');
    if(resetToken != null){
      final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      String? userid = sharedPreferences.getString('userId');
     await apiProvider.getprofile();
     print("This isnuser id");
    //  print(userid);
     await apiProvider.postApi("/user/show-notification", {
     "userID": userid
      });
      homePageController.notificationData.value =  apiProvider.RegisterResponse;
      for(var i = 0; i<homePageController.notificationData.length; i++){
        if(homePageController.notificationData[i]['is_read'] == false){
          homePageController.unReadNotification +=1;
        } 
      }

     var tagsss =  await apiProvider.getTags();
     for(var i= 0; i<tagsss['data'].length; i++){
     tagdata.add(tagsss['data'][i]['tagId']);
     homepage1controller.userTagId.add(tagsss['data'][i]['tagId']);
  }

    for(var i= 0; i<tagsss['data'].length; i++){
    homepage1controller.userTagName.add(tagsss['data'][i]['tagname']);
  }
   sendingTags = tagdata.toString().replaceAll("[", "").replaceAll("]", "");
   homepage1controller.userTags.value = sendingTags;
      await apiProvider.getPost(sendingTags);
      await  apiProvider.getArticleStatus();
      homePageController.readArticleId.value = [];
           homePageController.allPostId.value = [];
     for(int i =0; i<homePageController.readArticle.length; i++){
        homePageController.readArticleId.add(homePageController.readArticle[i]['articleId']);
       }
       for(int i =0; i<homepage1controller.allpostdata.length; i++){
        homePageController.allPostId.add(homepage1controller.allpostdata[i].id);
       }
       for(int i = 0; i<homePageController.allPostId.length; i++){
        if(homePageController.readArticleId.contains(homePageController.allPostId[i])){
           homepage1controller.copydata[i].read = true;
           homepage1controller.allpostdata[i].read = true;
          // homepage1controller.allpostdata.add({"read": true});
        }else{
          homepage1controller.copydata[i].read = false;
          homepage1controller.allpostdata[i].read = false;
        }
       }

       for(int i=0; i<yourIntrestController.allTagsModel.length; i++){
        if(homepage1controller.userTagName.toString().toLowerCase().contains(yourIntrestController.alltagsName[i].toString().toLowerCase()) ){
              yourIntrestController.allTagsModel[i].activetag = true;
        }else{
          yourIntrestController.allTagsModel[i].activetag = false;
        }
       }
       
    }
      Timer(const Duration(microseconds: 0),()=> finalEmail == null ? 
      Router.neglect(context, () {context.goNamed('SIGNINPAGE');}):
      Router.neglect(context, () {context.goNamed('HOMEPAGE');}));
    });
    super.initState();
  }
  Future getValidation()async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString('email');
    // setState((){
      finalEmail = obtainedEmail;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator(),),
    );
  }
}