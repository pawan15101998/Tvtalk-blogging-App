import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tvtalk/constant/front_size.dart';
import 'package:tvtalk/getxcontroller/my_intrest_controller.dart';
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
  final myIntrestnotify = [
  MyIntrestNotification(title: "The Boys", image: "assets/images/myint1.png"),
  MyIntrestNotification(title: "Raised by Wolves",image: "assets/images/myint2.png"),
  MyIntrestNotification(title: "Breaking Bad",image: "assets/images/myint3.png"),
  MyIntrestNotification(title: "Vikings",image: "assets/images/myint4.png"),
  MyIntrestNotification(title: "Raised by Wolves", image: "assets/images/myint1.png"),
  MyIntrestNotification(title: "The Boys", image: "assets/images/myint2.png"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(fontSize.getadaptiveTextSize(context, 90)),
          child: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            toolbarHeight: 120.0,
            elevation: 0,
            // automaticallyImplyLeading: false,
            backgroundColor: Color(0xfffFFDC5C),
            title: Text(
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
                 child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                   child: Column(
                    children: [
                    // SizedBox(height: 20,),
                    ...myIntrestnotify.map(buildSingleNotify).toList()
                    ],
                   ),
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
          border: Border.all(color: Color(0xfffE5E5E5)),
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
            Container(
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
                        style: TextStyle(
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
                  Divider(), 
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
      trackColor: Color(0xfffFFC7C5),
      activeColor: Color(0xfffB5EFE1),
      thumbColor: notification ?  Color(0xfff00C462) : Color(0xfffDE2D28),
      // inactiveThumbColor: Color(0xfffDE2D28),
      // inactiveTrackColor:Color(0xfffFFC7C5) ,
      value: notification,
      onChanged: (value)=>onclick(),
      );
  }

}
