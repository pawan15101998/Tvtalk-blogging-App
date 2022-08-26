import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInController extends GetxController{
RxBool passwordVisiblity = false.obs;
RxBool cnfpasswordVisiblity = false.obs;
String? userName;
String? userEmail;  
String? image;
RxString isGuest = ''.obs;

getuserdata()async{
  final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  userName = sharedPreferences.getString('name');
userEmail = sharedPreferences.getString('email');
image = sharedPreferences.getString('image');
}

}