import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvtalk/constant/color_const.dart';
import 'package:tvtalk/constant/front_size.dart';
import 'package:tvtalk/getxcontroller/home_page1_controller.dart';
import 'package:tvtalk/getxcontroller/home_page_controller.dart';
import 'package:tvtalk/view/profile_page.dart';
import 'package:tvtalk/widgets/blog_card.dart';
import 'package:tvtalk/widgets/saved_blog_card.dart';

class MySavedArticles extends StatefulWidget {
  const MySavedArticles({Key? key}) : super(key: key);

  @override
  State<MySavedArticles> createState() => _MySavedArticlesState();
}

class _MySavedArticlesState extends State<MySavedArticles> {
final fontSize = const AdaptiveTextSize();
final homePage1Controller = Get.find<HomePage1Controller>();
final homePageController = Get.find<HomePageController>();
final colorconst = ColorConst();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title: Text("My Saved Articles",
          style: TextStyle(
            color: colorconst.blackColor,
            fontSize: 20
          ),
          ),
        ),
      ),
      body:
      homePageController.savedArticles.length == 10?
     const Center(
      child: Text("No saved article found"),):
       SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20,),
             ListView.builder(
              shrinkWrap: true,
              physics:const ScrollPhysics(),
              itemCount: homePageController.savedArticles.length,
              itemBuilder:(context, index) {
              
                 return  SavedBlogCard(
                    indexx: index,
                    context: context,
                    blogDetail: homePageController.savedArticles[index]
                  );
                },
                )
          ],
        ),
      ) ,
    );
  }
}