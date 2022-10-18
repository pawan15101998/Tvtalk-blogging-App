import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvtalk/getxcontroller/home_page1_controller.dart';
import 'package:tvtalk/getxcontroller/home_page_controller.dart';
import 'package:tvtalk/getxcontroller/your_intrest_controller.dart';
import 'package:tvtalk/services/service.dart';

class SignInController extends GetxController{
RxBool passwordVisiblity = false.obs;
RxBool cnfpasswordVisiblity = false.obs;
String? userName;
int? userId;
String? userEmail;  
String? image;
String? googleUserDob;
String? googleUserGender;
RxString isGuest = ''.obs;
final apiProvider = ApiProvider();
final homePageController = Get.find<HomePageController>();
final homepage1controller = Get.find<HomePage1Controller>();
String sendingTags = "";
var yourIntrestController = Get.find<YourIntrestController>();


getuserdata()async{
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  userName = sharedPreferences.getString('name');
userEmail = sharedPreferences.getString('email');
image = sharedPreferences.getString('image');
}

}