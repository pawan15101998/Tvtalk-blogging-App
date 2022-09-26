import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

getuserdata()async{
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  userName = sharedPreferences.getString('name');
userEmail = sharedPreferences.getString('email');
image = sharedPreferences.getString('image');
}

}