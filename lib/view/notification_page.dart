import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:tvtalk/constant/color_const.dart';
import 'package:tvtalk/constant/front_size.dart';
import 'package:tvtalk/getxcontroller/home_page_controller.dart';
import 'package:tvtalk/widgets/notification_blog_card.dart';
import 'package:tvtalk/widgets/saved_blog_card.dart';

class notificationPage extends StatefulWidget {
  const notificationPage({Key? key}) : super(key: key);

  @override
  State<notificationPage> createState() => _notificationPageState();
}

class _notificationPageState extends State<notificationPage> {
var fontSize = const AdaptiveTextSize();
final homePageController = Get.find<HomePageController>();
final colorconst = ColorConst();

@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{
        context.goNamed('HOMEPAGE');
        return false;
      },
      child: Scaffold(
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20,),
               ListView.builder(
                shrinkWrap: true,
                physics:const ScrollPhysics(),
                itemCount: homePageController.notificationArticle.length,
                itemBuilder:(context, index) {
                   return  NotificationBlogCard(
                      indexx: index,
                      context: context,
                      blogDetail: homePageController.notificationArticle[index],
                      
                    );
                  },
                  )
            ],
          ),
        ) ,
      ),
    );
  }
}