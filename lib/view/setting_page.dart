import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:tvtalk/theme/appbar.dart';
import 'package:tvtalk/view/feature_atricle_viewall_page.dart';
import 'package:tvtalk/view/profile_page.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
    bool val = homePageController.notificationToggle ? true : false;

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getuserDetails();
    print("this is notification");
    print(homePageController.notificationToggle);
  }

 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appbar(context, "Setting"),
       body: Padding(
         padding: const EdgeInsets.all(12.0),
         child: Column(
           children: [
             InkWell(
              onTap: (){
                print("djhgj");
                print(homePageController.userDetails['data']['fcm_token']);
              },
              child: Container(
             // height: 45,
             decoration: BoxDecoration(
                     color: Color(0xfffF9EDD9), borderRadius: BorderRadius.circular(10)),
             child: Row(
               children: [
                const Expanded(
                   child:  ListTile(
                          title: Text("Notification"),
                          leading: Image(
                          image: AssetImage("assets/icons/icon_bell.png"),
                          height: 24,
                             ),
                             minLeadingWidth: 10,
                           ),
                 ),
                buildSwitch()
               ],
             ),
                      ),
                    ),
         SizedBox(height: 20,),
             DrawerItems("assets/icons/icon_interest.png", "My Interests", (){
              context.pushNamed('MYINTEREST');
             }),
           ],
         ),
       )
      ));
  }

   Widget buildSwitch(){
    return CupertinoSwitch(
      trackColor:const Color(0xffFFC7C5),
      activeColor:const Color(0xffB5EFE1),
      thumbColor: homePageController.notificationToggle ? Color(0xff00C462) : Colors.red, 
      value: val, 
      onChanged: (bool valu)async{
      // val = value;
      if(homePageController.notificationToggle == true){
        await apiprovider.postApi(
        "/user/delete-fcm",
        {}
        
      );
      if(apiprovider.RegisterResponse['message'] == 'Token remove successfully'){
        homePageController.notificationToggle = false;
      }
      print("api responmse in page");
      print(apiprovider.RegisterResponse['message']);
      }else{
        String? token = await FirebaseMessaging.instance.getToken();
        print(token);
        await apiprovider.postApi("/user/fcm-token", 
        {"fcm_token": token});
        if(apiprovider.RegisterResponse['message'] == 'Token added successfully'){
        homePageController.notificationToggle = true;
      }
      }
      
      
      // print(valu);
      setState((){
        // print(val);
        val = valu;
      });
        // yourIntrestController.allTagsModel[index].activetag = value;
      },
      );
  }

  Widget DrawerItems(String icon, String title, ontap) {
  return InkWell(
    onTap: ontap,
    child: Container(
      // height: 45,
      decoration: BoxDecoration(
          color: Color(0xfffF9EDD9), borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(title),
        leading: Image(
          image: AssetImage(icon),
          height: 24,
        ),
        minLeadingWidth: 10,
      ),
    ),
  );
}
}