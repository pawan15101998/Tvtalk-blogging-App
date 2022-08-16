import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Choice extends GetxController{  
 Choice( { this.title,  this.icon,  required this.select,});  
  final String? title;  
  final IconData? icon;  
  RxBool  select = false.obs;
}  
  
  