import 'dart:convert';
import 'dart:io';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvtalk/getxcontroller/detail_page_controller.dart';
import 'package:tvtalk/getxcontroller/home_page1_controller.dart';
import 'package:tvtalk/getxcontroller/home_page_controller.dart';
import 'package:tvtalk/getxcontroller/your_intrest_controller.dart';
import 'package:tvtalk/model/all_tags_model.dart';
import 'package:tvtalk/model/get_comment_model.dart';
import 'package:tvtalk/model/notification_post_model.dart';
import 'package:tvtalk/model/post_model.dart';
import 'package:tvtalk/model/saved_articles_model.dart';

class ApiProvider{
String baseUrl = 'https://tv-talk.hackerkernel.com/api/v1';
String siteurl = 'https://www.thetvtalk.com';
var RegisterResponse;
 int? statuscode;
String? resetToken;
var allTags = [];
List? allPost = [];
List? savedPost = [];
List? notificationPost = [];
Map usertag = {};
  final getallcommment = GetComment();
// Map? allcomment;
 Dio dio =  Dio();
final yourIntrestController = Get.put(YourIntrestController());
final homepage1controller = Get.put(HomePage1Controller());
final detailpagecontroller  = Get.put(DetailPageController());
  var homePageController = Get.put(HomePageController());


Future Post(String url, Map<String, String>body) async{
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  // EasyLoading.show(status: 'loading');
  try {
  final response = await http.post(
    Uri.parse(baseUrl+url),
    // /user/signup
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(body)
);
  // EasyLoading.dismiss();
  RegisterResponse = json.decode(response.body);
  // statuscode = response.statusCode;
  if (response.statusCode == 200){
  // sharedPreferences.setString('reset_token', RegisterResponse['data']['reset_token']);
  }
    return RegisterResponse;
} on Exception catch (e) {
  print("error $e");
}
}

Future PostSocial(String url, Map<String, String>body) async{
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  // EasyLoading.show(status: 'loading');
  try {
  final response = await http.post(
    Uri.parse(baseUrl+url),
    // /user/signup
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(body)
);
  // EasyLoading.dismiss();
  RegisterResponse = json.decode(response.body);

  // statuscode = response.statusCode;
  if (response.statusCode == 200){
  sharedPreferences.setString('reset_token', RegisterResponse['data']['reset_token']);

  }
    return RegisterResponse;
} on Exception catch (e) {
 print("error $e");
}
}

Future postApi(String url, Map<String, dynamic>body) async{
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  resetToken = sharedPreferences.getString('reset_token');

  // EasyLoading.show(status: 'loading');
  try {
  final response = await http.post(
    Uri.parse(baseUrl+url),
    // /user/signup
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'authorization': 'Bearer ${resetToken!}',
    },
    body: body
  );
  // EasyLoading.dismiss();

  RegisterResponse = json.decode(response.body);
  statuscode = response.statusCode;
  // statuscode = response.statusCode;
  if (response.statusCode == 200) {

  }
    return RegisterResponse;
} on Exception catch (e) {
 print("error $e");
}
}

Future removeFcmToken(String url) async{
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  resetToken = sharedPreferences.getString('reset_token');

  // EasyLoading.show(status: 'loading');
  try {
  final response = await http.post(
    Uri.parse(baseUrl+url),
    // /user/signup
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'authorization': 'Bearer ${resetToken!}',
    },
    // body: body
  );
  // EasyLoading.dismiss();
  RegisterResponse = json.decode(response.body);
  statuscode = response.statusCode;
  // statuscode = response.statusCode;
  if (response.statusCode == 200) {
  }
    return RegisterResponse;
} on Exception catch (e) {
  print("error $e");
}
}

Future saveArticle(String url, Map<String, dynamic>body) async{
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  resetToken = sharedPreferences.getString('reset_token');
  try {
  final response = await http.post(
    Uri.parse(baseUrl+url),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded',
      'authorization': 'Bearer ${resetToken!}',
    },
    body: body
  );

  RegisterResponse = json.decode(response.body);
  statuscode = response.statusCode;
  if (response.statusCode == 200) {

  }
    return RegisterResponse;
} on Exception catch (e) {
 print("error $e");
}
}



// Future saveFCMToken(String url, Map<String, dynamic>body) async{
//   final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   resetToken = sharedPreferences.getString('reset_token');
//   try {
//   final response = await http.post(
//     Uri.parse(baseUrl+url),
//     headers: <String, String>{
//       'Content-Type': 'application/x-www-form-urlencoded',
//       'authorization': 'Bearer ${resetToken!}',
//     },
//     body: body
//   );
//   RegisterResponse = json.decode(response.body);
//   statuscode = response.statusCode;
//   if (response.statusCode == 200) {

//   }
//     return RegisterResponse;
// } on Exception catch (e) {
//  print("error $e");
// }
// }

get()async {
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  resetToken = sharedPreferences.getString('reset_token');

  try{
    // isDataLoading(true);
    http.Response response = await http.get(
        Uri.parse('$siteurl/wp-json/wp/v2/tags'),
        headers: {'Authorization': 'Bearer $resetToken',
        'Content-Type': 'application/json; charset=UTF-8',
        },
    );
    if(response.statusCode == 200){
      ///data successfully
      var result = jsonDecode(response.body);
      // yourIntrestController.alltagsDetails = result
      for (var item in result){
        allTags.add(AllTagsModel.fromJson(item));
        yourIntrestController.allTagsModel.value = allTags;
        
        yourIntrestController.copyTags.value = allTags;
      }
      for(int i = 0; i<allTags.length; i++){
      yourIntrestController.alltagsName.add(allTags[i].name.toLowerCase());
    }
    for(int i = 0; i<allTags.length; i++){
      yourIntrestController.alltagsId.add(allTags[i].id);
    }
      // yourIntrestController.allTagsModel = allTags;
    }else{
      //error
    }
  }catch(e){
    // log('Error while getting data is $e');
    print('Error while getting data is $e');
  }finally{
    // isDataLoading(false);
  }
}

getSavedPost(postId)async{
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  resetToken = sharedPreferences.getString('reset_token');
  try{  
    // EasyLoading.show(status: 'loading');
    http.Response response = await http.get(Uri.parse('$siteurl/wp-json/wp/v2/posts?include=$postId'),
        headers: {'Authorization': 'Bearer $resetToken',
        'Content-Type': 'application/json; charset=UTF-8',
        },
    );
    // EasyLoading.dismiss();
    if(response.statusCode == 200){
      var result = jsonDecode(response.body);
      savedPost = [];
      homePageController.savedArticles = [];
      for (var item in result){     
        savedPost!.add(SavedPostPage.fromJson(item));
       homePageController.savedArticles = savedPost!;
      }
    }else{
    }
  }catch(e){
    // EasyLoading.dismiss();
    print("Error $e");

  }finally{
  }
}

getNotificationPost(postId)async{
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  resetToken = sharedPreferences.getString('reset_token');
  try{  
    // EasyLoading.show(status: 'loading');
    http.Response response = await http.get(Uri.parse('$siteurl/wp-json/wp/v2/posts?include=$postId'),
        headers: {'Authorization': 'Bearer $resetToken',
        'Content-Type': 'application/json; charset=UTF-8',
        },
    );
    // EasyLoading.dismiss();
    if(response.statusCode == 200){
      var result = jsonDecode(response.body);
      notificationPost = [];
      homePageController.notificationArticle = [];
      for (var item in result){     
        notificationPost!.add(NotificationPostPage.fromJson(item));
       homePageController.notificationArticle = notificationPost!;
      }
    }else{
    }
  }catch(e){
    // EasyLoading.dismiss();

  }finally{
  }
}

getPost(sendingTags)async{

  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  resetToken = sharedPreferences.getString('reset_token');
  // homepage1controller.allpostdata.clear();
  try{  
    // EasyLoading.show(status: 'loading');
    http.Response response = await http.get(Uri.parse('$siteurl/wp-json/wp/v2/posts/?tags=${sendingTags},'),
        headers: {'Authorization': 'Bearer $resetToken',
        'Content-Type': 'application/json; charset=UTF-8',
        },
    );
    // EasyLoading.dismiss();
    if(response.statusCode == 200){
       homepage1controller.allpostdata = [].obs;
      ///data successfully
      var result = jsonDecode(response.body);

      // allTags  = [];
      for (var item in result){     
        allPost!.add(HomePagePost.fromJson(item));
        // allPost!.add({"status": 0});
       homepage1controller.allpostdata.value = allPost!;
       homepage1controller.copydata.value = allPost!;
      }
      // yourIntrestController.allTagsModel = allTags;
    }else{
      //error
    }
  }catch(e){
    EasyLoading.dismiss();
    // log('Error while getting data is $e');
  }finally{
    // isDataLoading(false);
  }
}


getArticleStatus()async {
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  resetToken = sharedPreferences.getString('reset_token');
  try{
    http.Response response = await http.get(Uri.parse('$baseUrl/post/read-status'),
        headers: {'Authorization': 'Bearer $resetToken',
        'Content-Type': 'application/json; charset=UTF-8',
        },
    );
    if(response.statusCode == 200){
      var result = jsonDecode(response.body);
      homePageController.readArticle.value = result;
      return result;
    }else{
    }
  }catch(e){
  }finally{
  }
}
 
getTags()async {
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  resetToken = sharedPreferences.getString('reset_token');
  try{
    http.Response response = await http.get(Uri.parse('$baseUrl/user/get-user-tags'),
        headers: {'Authorization': 'Bearer $resetToken',
        'Content-Type': 'application/json; charset=UTF-8',
        },
    );
    if(response.statusCode == 200){
      var result = jsonDecode(response.body);
 
      return result;
    }else{
    }
  }catch(e){
  }finally{
  }
}

getSavedArticle(userId)async {
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  resetToken = sharedPreferences.getString('reset_token');
  try{
    http.Response response = await http.get(Uri.parse('$baseUrl/user/get-saved-articles/$userId'),
        headers: {'Authorization': 'Bearer $resetToken',
        'Content-Type': 'application/json; charset=UTF-8',
        },
    );
    detailpagecontroller.savedArticlePostId.value = [];
    if(response.statusCode == 200){
      var result = jsonDecode(response.body);
      detailpagecontroller.savedArticlePostId.value = result;
      return result;
    }else{
    }
  }catch(e){
    print('Error while getting data is $e');
  }finally{
  }
}

getprofile()async {
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  resetToken = sharedPreferences.getString('reset_token');
  try{
    // isDataLoading(true);
    http.Response response = await http.get(Uri.parse('$baseUrl/user/get-user-details'),
        headers: {'Authorization': 'Bearer $resetToken',
        'Content-Type': 'application/json; charset=UTF-8',
        },
    );
    if(response.statusCode == 200){
      var result = jsonDecode(response.body);
     
      // yourIntrestController.allTagsModel = allTags;
    
      homePageController.userDetails.value = result;
      return result;
    }else{
      //error
    }
  }catch(e){
    // log('Error while getting data is $e');
    print('Error while getting data is $e');
  }finally{
    // isDataLoading(false);
  }
}

getComment(postId)async {
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  resetToken = sharedPreferences.getString('reset_token');

  try{
    // EasyLoading.show(status: "Loading...");
    // isDataLoading(true);
    http.Response response = await http.get(Uri.parse('$baseUrl/post/get-data?postId=$postId'),
        // headers: {'Authorization': 'Bearer $resetToken',
        // 'Content-Type': 'application/json; charset=UTF-8',
        // },
    );
    if(response.statusCode == 200){
      ///data successfully
      statuscode = response.statusCode;
      var result = jsonDecode(response.body);

      final details = GetComment.fromJson(result);
      detailpagecontroller.commentData = details;
      return detailpagecontroller.commentData;
      // detailpagecontroller.commentData.value = result;
    }else{
      //error
    }
    // EasyLoading.dismiss();
  }catch(e){
    // EasyLoading.dismiss();
    // log('Error while getting data is $e');
    print('Error while getting data is $e');
  }finally{
    // EasyLoading.dismiss();
    // isDataLoading(false);
  }
}
}
