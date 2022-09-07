

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvtalk/model/all_tags_model.dart';
import 'package:tvtalk/model/select_your_intrest_model.dart';
import 'package:tvtalk/services/service.dart';

class YourIntrestController extends GetxController{
  RxBool yourIntrest = false.obs;
  RxBool activeTextfield = false.obs;
 RxList allTagsModel = [].obs;
 RxList alltagsName = [].obs;
 RxList alltagsDetails = [].obs;
 RxBool searchTags =false.obs;
 RxList copyTags = [].obs;
//  final apiProvider = ApiProvider();
// @override
// void onInit(){
//   super.onInit();
//   apiProvider.get();
// }

RxList images = [
  ""
  ""
 ].obs;
 RxList<Choice> choices = <Choice>[  
 Choice(title: 'assets/images/intrest1.jpg', icon: Icons.home, select: false.obs),  
 Choice(title: 'assets/images/intrest2.jpg', icon: Icons.contacts, select: false.obs),  
 Choice(title: 'assets/images/intrest3.jpg', icon: Icons.map, select: false.obs),  
 Choice(title: 'assets/images/intrest4.webp', icon: Icons.phone, select: false.obs),  
 Choice(title: 'assets/images/intrest5.jpg', icon: Icons.camera_alt, select: false.obs),  
 Choice(title: 'assets/images/intrest6.jpg', icon: Icons.settings, select: false.obs),  
 Choice(title: 'assets/images/intrest6.jpg', icon: Icons.settings, select: false.obs),  
//  Choice(title: 'GPS', icon: Icons.gps_fixed),  
].obs;
}