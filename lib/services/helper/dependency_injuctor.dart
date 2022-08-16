
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:tvtalk/getxcontroller/detail_page_controller.dart';
import 'package:tvtalk/getxcontroller/home_page1_controller.dart';
import 'package:tvtalk/getxcontroller/home_page2_controller.dart';
import 'package:tvtalk/getxcontroller/home_page3_controller.dart';
import 'package:tvtalk/getxcontroller/home_page_controller.dart';
import 'package:tvtalk/getxcontroller/my_intrest_controller.dart';
import 'package:tvtalk/getxcontroller/signin_controller.dart';
import 'package:tvtalk/getxcontroller/your_intrest_controller.dart';

import '../../getxcontroller/home_page4_controller.dart';

class DependencyInjuctor{
  static void initializeController(){
    Get.put(MyIntrestController());
    Get.put(SignInController());
    Get.put(HomePageController());
    Get.put(HomePage1Controller());
    Get.put(YourIntrestController());
    Get.put(HomePage2Controller());
    Get.put(HomePage3Controller());
    Get.put(HomePage4Controller());
    Get.put(DetailPageController());
  } 
}