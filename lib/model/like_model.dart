import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Like extends GetxController{  
 Like( { this.image,   required this.isLike,});  
  final String? image;  
  RxBool  isLike = false.obs;
}  