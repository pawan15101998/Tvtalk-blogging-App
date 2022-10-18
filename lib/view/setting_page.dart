import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:tvtalk/theme/appbar.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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
                      onTap: (){},
                      child: Container(
             // height: 45,
             decoration: BoxDecoration(
                     color: Color(0xfffF9EDD9), borderRadius: BorderRadius.circular(10)),
             child: Row(
               children: [
                 Expanded(
                   child: const ListTile(
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
    bool val = true;
    return CupertinoSwitch(
      trackColor:const Color(0xffFFC7C5),
      activeColor:const Color(0xffB5EFE1),
      thumbColor: Color(0xff00C462),
      value:val, 
      onChanged: (value)async{
      val = value;
      setState(() {
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