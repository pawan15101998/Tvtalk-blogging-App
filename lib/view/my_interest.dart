import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tvtalk/constant/front_size.dart';
import 'package:tvtalk/getxcontroller/my_intrest_controller.dart';
import 'package:tvtalk/getxcontroller/your_intrest_controller.dart';
import 'package:tvtalk/model/notification_toggle.dart';

class MyInterest extends StatefulWidget {
  const MyInterest({Key? key}) : super(key: key);

  @override
  State<MyInterest> createState() => _MyInterestState();
}

class _MyInterestState extends State<MyInterest> {
  var fontSize = AdaptiveTextSize();
  bool switchvalue = true;
  var myintrest = Get.find<MyIntrestController>();
// 'assets/images/1000-Sister.png'
// 'assets/images/LittleJohnstone.png'
// 'assets/images/Cover_Variation.png'
// 'assets/images/Bold&Beautifull.png'  
// 'assets/images/daysOfOurLife.png',  
// 'assets/images/GeneralHospital.png',  
// 'assets/images/LittlePeopleBigWorld.png',  
// 'assets/images/My600lb.png',
// 'assets/images/OutDaughter.png',  
// 'assets/images/TheRealHouseWives.png'  


  final myIntrestnotify = [
  MyIntrestNotification(title: "1000-Lb Sisters", image: "assets/images/1000-Sister.png"),
  MyIntrestNotification(title: "7 Little Johnstons",image:'assets/images/LittleJohnstone.png'),
  MyIntrestNotification(title: "90 Day Fiance",image: 'assets/images/Cover_Variation.png'),
  MyIntrestNotification(title: "Bold and the Beautiful",image: 'assets/images/Bold&Beautifull.png'),
  MyIntrestNotification(title: "Days Of Our Lives", image: 'assets/images/daysOfOurLife.png'),
  MyIntrestNotification(title: "General Hospital", image: 'assets/images/GeneralHospital.png'),
  MyIntrestNotification(title: "Little People Big World", image: 'assets/images/LittlePeopleBigWorld.png'),
  MyIntrestNotification(title: "My 600-Lb Life", image: 'assets/images/My600lb.png'),
  MyIntrestNotification(title: "Outdaughtered", image: 'assets/images/OutDaughter.png'),
  MyIntrestNotification(title: "Real Housewives", image: 'assets/images/TheRealHouseWives.png'),
  ];
    var yourIntrestController = Get.find<YourIntrestController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(fontSize.getadaptiveTextSize(context, 90)),
          child: AppBar(
            iconTheme:const IconThemeData(color: Colors.black),
            toolbarHeight: 120.0,
            elevation: 0,
            // automaticallyImplyLeading: false,
            backgroundColor: Color(0xfffFFDC5C),
            title:const Text(
              "My Interests",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ),
        body: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: Color(0xfffF2F1F1),
                  hintText: "Search interests to add",
                  border: InputBorder.none,
                  ),
            ),
           Expanded(
                 child: ListView.builder(
                  itemCount:yourIntrestController.allTagsModel.length,
                   itemBuilder: (context, snapshot) {
                     return Column(
                      children: [
                      // SizedBox(height: 20,),
                      // buildSingleNotify()
                      ...myIntrestnotify.map(buildSingleNotify).toList()
                      ],
                     );
                   }
                 ),
               )            
          ],
        ));
  }

   Widget buildSingleNotify(MyIntrestNotification notification)=>
   myInterestBox(
    notification: notification,
    onClicked: (){
        myintrest.intrest.toggle();
        final newvalue = !notification.value;
        notification.value =  myintrest.intrest.value;
    }
   );
  Widget myInterestBox({
    required MyIntrestNotification notification,
    required VoidCallback onClicked,
  }){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color:const Color(0xffE5E5E5)),
          borderRadius: BorderRadius.circular(8)
        ),
        child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height:100,
              width:  100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(image: AssetImage(notification.image),fit: BoxFit.cover)
              ),
            ),
            SizedBox(
              height:MediaQuery.of(context).size.height*12/100,
              width: MediaQuery.of(context).size.width-150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        notification.title,
                        style:const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      // SizedBox(width: 100,),
                      Container(
                        height: 20,
                        width: 20,
                       decoration:  const BoxDecoration(
                        image: DecorationImage(image: AssetImage('assets/icons/myinticon.png'), fit: BoxFit.cover)
                       ),
                      )
                    ],
                  ),
                  const Divider(), 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Show Notifications",
                        style: TextStyle(
                          color: Color(0xfff949494)
                        ),
                      ),
                      Obx((){
                          return buildSwitch(onClicked, notification.value, myintrest.intrest.value);
                        }
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
       ),
      ),
    );
  }

 Widget buildSwitch(onclick, notification, intrestToggle){
    return CupertinoSwitch(
      trackColor:const Color(0xffFFC7C5),
      activeColor:const Color(0xffB5EFE1),
      thumbColor: notification ?const  Color(0xff00C462) :const Color(0xffDE2D28),
      // inactiveThumbColor: Color(0xfffDE2D28),
      // inactiveTrackColor:Color(0xfffFFC7C5) ,
      value: notification,
      onChanged: (value)=>onclick(),
      );
  }

}
