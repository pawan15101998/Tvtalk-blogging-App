

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
 RxList alltagsId = [].obs;
 RxList alltagsDetails = [].obs;
 RxBool searchTags =false.obs;
 RxList copyTags = [].obs;
 RxList tagselectfromsearch = [].obs;
var isSelected = false.obs;
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
 Choice(title: 'assets/images/1000-Sister.png', icon: Icons.home, select: false.obs),  
 Choice(title: 'assets/images/LittleJohnstone.png', icon: Icons.contacts, select: false.obs),  
 Choice(title: 'assets/images/Cover_Variation.png', icon: Icons.map, select: false.obs),  
 Choice(title: 'assets/images/Bold&Beautifull.png', icon: Icons.phone, select: false.obs),  
 Choice(title: 'assets/images/daysOfOurLife.png', icon: Icons.camera_alt, select: false.obs),  
 Choice(title: 'assets/images/GeneralHospital.png', icon: Icons.settings, select: false.obs),  
 Choice(title: 'assets/images/LittlePeopleBigWorld.png', icon: Icons.settings, select: false.obs),  
 Choice(title: 'assets/images/My600lb.png', icon: Icons.settings, select: false.obs),  
 Choice(title: 'assets/images/OutDaughter.png', icon: Icons.settings, select: false.obs),  
 Choice(title: 'assets/images/TheRealHouseWives.png', icon: Icons.settings, select: false.obs),  
//  Choice(title: 'GPS', icon: Icons.gps_fixed),  
].obs;
}