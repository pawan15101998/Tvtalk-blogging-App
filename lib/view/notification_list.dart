import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvtalk/constant/color_const.dart';
import 'package:tvtalk/constant/front_size.dart';
import 'package:tvtalk/getxcontroller/home_page_controller.dart';
import 'package:tvtalk/services/service.dart';

class notificationList extends StatefulWidget {
  const notificationList({Key? key}) : super(key: key);

  @override
  State<notificationList> createState() => _notificationListState();
}

class _notificationListState extends State<notificationList> {
final fontSize = const AdaptiveTextSize();
final apiProvider = ApiProvider();
final homePageController = Get.find<HomePageController>();
final colorconst = ColorConst();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(fontSize.getadaptiveTextSize(context, 90)),
        child: AppBar(
          iconTheme: IconThemeData(
            color: colorconst.blackColor
          ),
          toolbarHeight: 120.0,
          elevation: 0,
          // automaticallyImplyLeading: false,
          backgroundColor: colorconst.mainColor,
          title: Text("Notification",
          style: TextStyle(
            color: colorconst.blackColor,
            fontSize: 20
          ),
          ),
        ),
      ),
      body:
      homePageController.notificationData.isNotEmpty ?
       SingleChildScrollView(
        child: Column(
          children: [
           const SizedBox(height: 20,),
            ListView.builder(
              shrinkWrap: true,
              reverse: true,
              physics:const ScrollPhysics(),
              itemCount: homePageController.notificationData.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async{
                    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                          String? userid = sharedPreferences.getString('userId');
                          await apiProvider.postApi("/user/show-notification", {
                            "userID": userid
                          });
                          homePageController.notificationData.value =  apiProvider.RegisterResponse;
                          // for(var i = 0; i<homePageController.notificationData.length; i++){
                          // if(homePageController.notificationData[i]['is_read'] == false){
                          //     homePageController.unReadNotification +=1;
                          //    } 
                          //     }
                          
                          await homePageController.notification(index);
                          await apiProvider.postApi("/user/isnotification-read",{
                            "userID": userid.toString(),
                            "notificationID":homePageController.notificationData[index]['id'].toString()
                          });

                          //  homePageController.notification();
                          context.pushNamed('NOTIFICATION');
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Container(
                      // color: colorconst.blueColor,
                      decoration: BoxDecoration(
                        // color:homePageController.notificationData[index]['is_read'] ? Color.fromARGB(255, 226, 222, 189) : Color.fromARGB(255, 248, 237, 143),
                        gradient:homePageController.notificationData[index]['is_read']? colorconst.notificationRead : colorconst.notificationUnRead,
                        // border: Border.all()
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                      ),
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image:const DecorationImage(image: AssetImage("assets/images/Detail.png"),fit: BoxFit.cover
                                )
                              ),
                              // child: Image.asset("assets/images/Detail.png", fit: BoxFit.cover,)
                              ),
                             const SizedBox(width: 10,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(homePageController.notificationData[index]['title'],
                                style:const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                                ),
                                ),
                                Text(
                                  homePageController.notificationData[index]['content'],
                                  style: const TextStyle(
                                    fontSize: 12
                                  ),
                                  ),
                                const SizedBox(height: 20,)
                              ],
                            ),
                              ],
                            ),
                            Column(
                              children: [
                              const Text("42m ago", style: TextStyle(
                                  fontSize: 10
                                ),),
                                 Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(image: AssetImage("assets/images/Detail.png"),fit: BoxFit.cover
                                )
                              ),
                              // child: Image.asset("assets/images/Detail.png", fit: BoxFit.cover,)
                              ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ): Center(child: Text("No Notification found"),),
    );
  }
}