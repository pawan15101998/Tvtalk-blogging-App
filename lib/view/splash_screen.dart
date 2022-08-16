import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvtalk/getxcontroller/your_intrest_controller.dart';
import 'package:tvtalk/services/service.dart';
import 'package:tvtalk/view/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>{
late final finalEmail;
final apiProvider = ApiProvider();
 var yourIntrestController = Get.put(YourIntrestController());
getcallapi()async{
    await  apiProvider.get();
    print("alltagsmodelss");
    print("print data");
    // print(yourIntrestController.allTagsModel!.data![0].id);
    // print(allTags);
    print(yourIntrestController.allTagsModel);
}
  @override
  void initState() {
    getcallapi();
    // TODO: implement initState
    getValidation().whenComplete(()async{
    Timer(Duration(microseconds: 0), ()=> finalEmail == null ? 
    Router.neglect(context, () {context.goNamed('SIGNINPAGE');}):
   Router.neglect(context, () {context.goNamed('HOMEPAGE');}));
    });
    
    super.initState();
  }
  Future getValidation()async{
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var obtainedEmail = sharedPreferences.getString('email');
    // setState((){
      finalEmail = obtainedEmail;
    // });
    print(finalEmail);
    print(obtainedEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}