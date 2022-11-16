import 'dart:convert';

import 'package:get/get.dart';
import 'package:tvtalk/view/feature_atricle_viewall_page.dart';

class HomePageController extends GetxController{
RxInt bootomNav = 0.obs;
RxString birthday = "".obs;
RxMap userDetails = {}.obs;
List savedArticles = [];
List notificationArticle = [];
RxList readArticle = [].obs;
RxList readArticleId = [].obs;
RxList allPostId  = [].obs;
RxList notificationData = [].obs;
RxInt unReadNotification = 0.obs;
RxBool searchIcon = true.obs; 
RxString notificationPostId = ''.obs;
bool notificationToggle = true; 



notification(index)async{
var postID = json.decode(notificationData[index]['jsonData']);
print("postIDe");
notificationPostId.value =  postID[0]['postId'].toString().replaceAll("[", "").replaceAll("]", "");
print(notificationPostId);
 await apiprovider.getNotificationPost(notificationPostId);
}

isArticleRead()async{
  await  apiprovider.getArticleStatus();
      readArticleId.value = [];
           allPostId.value = [];
     for(int i =0; i<readArticle.length; i++){
        readArticleId.add(readArticle[i]['articleId']);
       }
       for(int i =0; i<homePage1Controller.allpostdata.length; i++){
        allPostId.add(homePage1Controller.allpostdata[i].id);
       }
       for(int i = 0; i<allPostId.length; i++){
        if(readArticleId.contains(allPostId[i])){
          homePage1Controller.copydata[i].read = true;
           homePage1Controller.allpostdata[i].read = true;
          print("hjvbdsjfd");
          print(homePage1Controller.copydata[i].read);
          // homepage1controller.allpostdata.add({"read": true});
        }else{
          homePage1Controller.copydata[i].read = false;
          homePage1Controller.allpostdata[i].read = false;
        }
       }
}
}