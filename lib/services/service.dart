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
Map usertag = {};
  final getallcommment = GetComment();
// Map? allcomment;
 Dio dio =  Dio();
final yourIntrestController = Get.find<YourIntrestController>();
final homepage1controller = Get.find<HomePage1Controller>();
final detailpagecontroller  = Get.find<DetailPageController>();
  var homePageController = Get.find<HomePageController>();


Future Post(String url, Map<String, String>body) async{
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  print("response ULSss");
  print(url);
  print(body);
  print(jsonEncode(body));
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
  print("resssssss");
  // print(RegisterResponse['data']['reset_token']);
  // statuscode = response.statusCode;
  if (response.statusCode == 200){
  // sharedPreferences.setString('reset_token', RegisterResponse['data']['reset_token']);
    print("responseee");
    print(RegisterResponse['message']);
  }
    return RegisterResponse;
} on Exception catch (e) {
  print("error");
    print(e);
}
}

Future PostSocial(String url, Map<String, String>body) async{
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  print("response ULSss");
  print(url);
  print(body);
  print(jsonEncode(body));
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
  print("resssssss");
  print(response.statusCode);
  print(RegisterResponse);
  // print(RegisterResponse['data']['reset_token']);
  // statuscode = response.statusCode;
  if (response.statusCode == 200){
  sharedPreferences.setString('reset_token', RegisterResponse['data']['reset_token']);
    print("responseee");
    print(RegisterResponse);
  }
    return RegisterResponse;
} on Exception catch (e) {
  print("error");
    print(e);
}
}

Future postApi(String url, Map<String, dynamic>body) async{
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  resetToken = sharedPreferences.getString('reset_token');
  print("response ULS");
  print(resetToken);
  print(url);
  print(body);
  print(jsonEncode(body));
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
  print("hbjhsdjks");
  print(response.body);
  RegisterResponse = json.decode(response.body);
  statuscode = response.statusCode;
  print(response.statusCode);
  // statuscode = response.statusCode;
  if (response.statusCode == 200) {
    print("responseee");
    print(RegisterResponse);
    print(response.body);
  }
    return RegisterResponse;
} on Exception catch (e) {
  print("error");
    print(e);
}
}

Future removeFcmToken(String url) async{
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  resetToken = sharedPreferences.getString('reset_token');
  print("response ULS");
  print(resetToken);
  print(url);
  // print(body);
  // print(jsonEncode(body));
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
  print("remove fcm token");
  print(response.body);
  RegisterResponse = json.decode(response.body);
  statuscode = response.statusCode;
  print(response.statusCode);
  // statuscode = response.statusCode;
  if (response.statusCode == 200) {
    print("responseee");
    print(RegisterResponse);
    print(response.body);
  }
    return RegisterResponse;
} on Exception catch (e) {
  print("error");
    print(e);
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
  print("saved article response");
  print(response.body);
  RegisterResponse = json.decode(response.body);
  statuscode = response.statusCode;
  if (response.statusCode == 200) {
    print(RegisterResponse);

  }
    return RegisterResponse;
} on Exception catch (e) {
  print("error");
    print(e);
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
//   print("saved article response");
//   print(response.body);
//   RegisterResponse = json.decode(response.body);
//   statuscode = response.statusCode;
//   if (response.statusCode == 200) {
//     print(RegisterResponse);

//   }
//     return RegisterResponse;
// } on Exception catch (e) {
//   print("error");
//     print(e);
// }
// }

get()async {
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  resetToken = sharedPreferences.getString('reset_token');
  print("token");
  print(resetToken);
  try{
    print("111112");
    // isDataLoading(true);
    http.Response response = await http.get(
        Uri.parse('$siteurl/wp-json/wp/v2/tags'),
        headers: {'Authorization': 'Bearer $resetToken',
        'Content-Type': 'application/json; charset=UTF-8',
        },
    );
    print("datallllllll");
    if(response.statusCode == 200){
      ///data successfully
      var result = jsonDecode(response.body);
      // yourIntrestController.alltagsDetails = result
      for (var item in result){
        print("jkxcdsas");
        allTags.add(AllTagsModel.fromJson(item));
        print("item");
        print(allTags);
        yourIntrestController.allTagsModel.value = allTags;
        yourIntrestController.copyTags.value = allTags;
      }
    print("All tagsname");
    print(yourIntrestController.alltagsName);
      for(int i = 0; i<allTags.length; i++){
      yourIntrestController.alltagsName.add(allTags[i].name.toLowerCase());
    }
    for(int i = 0; i<allTags.length; i++){
      yourIntrestController.alltagsId.add(allTags[i].id);
    }
      // yourIntrestController.allTagsModel = allTags;
      print("data sucessfuly");
      print(yourIntrestController.allTagsModel[0]);
      // print(allTags.data![2].tagname);
      print(result);
    }else{
      //error
      print("err");
    }
  }catch(e){
    // log('Error while getting data is $e');
    print('Error while getting data is $e');
  }finally{
    // isDataLoading(false);
    print("object");
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
       print(homePageController.savedArticles);
      }
    }else{
      print("err");
    }
  }catch(e){
    // EasyLoading.dismiss();

  }finally{
    print("object");
  }
}

getPost(sendingTags)async{
  print("taggggggggggggggg");
  print(sendingTags);
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  resetToken = sharedPreferences.getString('reset_token');
  // homepage1controller.allpostdata.clear();
  try{  
    print("111114");
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
      print("dataaaaaaaaaaa");
      print(result);
      // allTags  = [];
      for (var item in result){     
        print("jkxcdsas");
        allPost!.add(HomePagePost.fromJson(item));
        // allPost!.add({"status": 0});
        print("itemmmmmm");
        print(allPost);
        // print(allTags);
       homepage1controller.allpostdata.value = allPost!;
       homepage1controller.copydata.value = allPost!;
      }
      // yourIntrestController.allTagsModel = allTags;
      // print(result);
      print("data sucessfuly");
      print(homepage1controller.allpostdata);
      // print(allTags.data![2].tagname);
      // print(result);
    }else{
      //error
      print("err");
    }
    print("Data length");
    print(homepage1controller.allpostdata.length);
  }catch(e){
    EasyLoading.dismiss();
    // log('Error while getting data is $e');
    print('Error while getting data is $e');
  }finally{
    // isDataLoading(false);
    print("object");
  }
}


getArticleStatus()async {
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  resetToken = sharedPreferences.getString('reset_token');
  try{
    print("111113");
    http.Response response = await http.get(Uri.parse('$baseUrl/post/read-status'),
        headers: {'Authorization': 'Bearer $resetToken',
        'Content-Type': 'application/json; charset=UTF-8',
        },
    );
    if(response.statusCode == 200){
      var result = jsonDecode(response.body);
      print("This is user article staus");
      homePageController.readArticle.value = result;
      print(result);
      return result;
    }else{
      print("err");
    }
  }catch(e){
    print('Error while getting data is $e');
  }finally{
    print("object");
  }
}
 
getTags()async {
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  resetToken = sharedPreferences.getString('reset_token');
  print("rokern");
  print(resetToken);
  try{
    print("111113");
    http.Response response = await http.get(Uri.parse('$baseUrl/user/get-user-tags'),
        headers: {'Authorization': 'Bearer $resetToken',
        'Content-Type': 'application/json; charset=UTF-8',
        },
    );
    if(response.statusCode == 200){
      var result = jsonDecode(response.body);
      print("This is user tags");
      print(response.body);
      print(result);
      print("data sucessfuly");
      return result;
    }else{
      print("err");
    }
  }catch(e){
    print('Error while getting data is $e');
  }finally{
    print("object");
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
      print(result);
      return result;
    }else{
      print("err");
    }
  }catch(e){
    print('Error while getting data is $e');
  }finally{
    print("object");
  }
}

getprofile()async {
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  resetToken = sharedPreferences.getString('reset_token');
  try{
    print("111115");
    // isDataLoading(true);
    http.Response response = await http.get(Uri.parse('$baseUrl/user/get-user-details'),
        headers: {'Authorization': 'Bearer $resetToken',
        'Content-Type': 'application/json; charset=UTF-8',
        },
    );
    if(response.statusCode == 200){
      var result = jsonDecode(response.body);
      print("where is image");
       print(result);
      // yourIntrestController.allTagsModel = allTags;
      // print(result);
      print("data sucessfuly");
      // print(homepage1controller.allpostdata);
      // print(allTags.data![2].tagname);
      // print(result);
      homePageController.userDetails.value = result;
      print("where is controller image");
      print(homePageController.userDetails);
      return result;
    }else{
      //error
      print("err");
    }
  }catch(e){
    // log('Error while getting data is $e');
    print('Error while getting data is $e');
  }finally{
    // isDataLoading(false);
    print("object");
  }
}

getComment(postId)async {
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  resetToken = sharedPreferences.getString('reset_token');
  print("comment");
  print(postId);
  print(resetToken);
  try{
    // EasyLoading.show(status: "Loading...");
    print("111116");
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
      print("data sucessfuly");
      print(result);
      final details = GetComment.fromJson(result);
      detailpagecontroller.commentData = details;
      print("commenttttt");
      print(detailpagecontroller.commentData);
      return detailpagecontroller.commentData;
      //  print(detailpagecontroller.commentData!.data);
      // detailpagecontroller.commentData.value = result;
      // print(result);
    }else{
      //error
      print("err");
    }
    // EasyLoading.dismiss();
  }catch(e){
    // EasyLoading.dismiss();
    // log('Error while getting data is $e');
    print('Error while getting data is $e');
  }finally{
    // EasyLoading.dismiss();
    // isDataLoading(false);
    print("object");
  }
}
}
