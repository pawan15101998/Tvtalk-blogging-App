import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvtalk/getxcontroller/home_page1_controller.dart';
import 'package:tvtalk/getxcontroller/your_intrest_controller.dart';
import 'package:tvtalk/model/all_tags_model.dart';
import 'package:tvtalk/model/post_model.dart';

class ApiProvider{
String baseUrl = 'http://142.93.219.133/the_tv_talk/api/v1';
String siteurl = 'https://www.thetvtalk.com';
var RegisterResponse;
String? resetToken;
var allTags = [];
List? allPost = [];
 Dio dio =  Dio();
final yourIntrestController = Get.find<YourIntrestController>();
final homepage1controller = Get.find<HomePage1Controller>();

Future Post(String url, Map<String, String>body) async{
  print("response ULS");
  print(url);
  print(body);
  print(jsonEncode(body));
  EasyLoading.show(status: 'loading');
  try {
  final response = await http.post(
    Uri.parse(baseUrl+url),
    // /user/signup
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(body)
  );
  EasyLoading.dismiss();
  RegisterResponse = json.decode(response.body);
  print(response.statusCode);
  // statuscode = response.statusCode;
  if (response.statusCode == 200) {
    print("responseee");
    print(response.body);
  }
    return RegisterResponse;
} on Exception catch (e) {
  print("error");
    print(e);
}
}

Future postApi(String url, Map<String, dynamic>body) async{
  print("response ULS");
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
    body: jsonEncode(body)
  );
  // EasyLoading.dismiss();
  print(response.body);
  RegisterResponse = json.decode(response.body);
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

//  dioPost(String url , Map<String, dynamic>body)async{
//   print(jsonEncode(body));
//   print(resetToken);
//     // FormData formData = FormData.from
//   try {
//     print("trying");
//     print(baseUrl+url);
//     final response = await dio.post(baseUrl+url,
//     data: {
//       "tags": [12,22,55], 
//       },
//     options: Options(
//       contentType: Headers.formUrlEncodedContentType,
//       headers: {
//         "Content-type": "application/x-www-form-urlencoded",
//         'authorization': "Bearer " + resetToken!}
//     )
//     );
//     print("resposnse");
//     print(response);
//     return response.data;
//   }catch (e) {
//       print('iiiiiiiiiiiiiiiiiiiiii');
//       print(e);
//     }
// }


get()async {
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  resetToken = sharedPreferences.getString('reset_token');
  print("token");
  print(resetToken);
  try{
    print("111111");
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
      
      for (var item in result){
        print("jkxcdsas");
        allTags.add(AllTagsModel.fromJson(item));
        print("item");
        print(allTags);
        yourIntrestController.allTagsModel = allTags;
      }
      // yourIntrestController.allTagsModel = allTags;
      print("data sucessfuly");
      print(yourIntrestController.allTagsModel![0]);
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



getPost()async {
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  resetToken = sharedPreferences.getString('reset_token');
  try{
    print("111111");
    // isDataLoading(true);
    http.Response response = await http.get(
        Uri.parse('$siteurl/wp-json/wp/v2/posts/?tags=36'),
        // headers: {'Authorization': 'Bearer $resetToken',
        // 'Content-Type': 'application/json; charset=UTF-8',
        // },
    );
    print("datallllllll");
    if(response.statusCode == 200){
      ///data successfully
      var result = jsonDecode(response.body);
      // print(result);
      for (var item in result){
        print("jkxcdsas");
        allPost!.add(HomePagePost.fromJson(item));
        print("item");
        // print(allTags);
       homepage1controller.allpostdata = allPost!;
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
  }catch(e){
    // log('Error while getting data is $e');
    print('Error while getting data is $e');
  }finally{
    // isDataLoading(false);
    print("object");
  }
}
}
