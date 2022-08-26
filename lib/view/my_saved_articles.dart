import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tvtalk/constant/front_size.dart';
import 'package:tvtalk/getxcontroller/home_page1_controller.dart';
import 'package:tvtalk/widgets/blog_card.dart';

class MySavedArticles extends StatefulWidget {
  const MySavedArticles({Key? key}) : super(key: key);

  @override
  State<MySavedArticles> createState() => _MySavedArticlesState();
}

class _MySavedArticlesState extends State<MySavedArticles> {
    var fontSize = const AdaptiveTextSize();
    var homePage1Controller = Get.find<HomePage1Controller>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(fontSize.getadaptiveTextSize(context, 90)),
        child: AppBar(
          iconTheme:const IconThemeData(
            color: Colors.black
          ),
          toolbarHeight: 120.0,
          elevation: 0,
          // automaticallyImplyLeading: false,
          backgroundColor:const Color(0xffFFDC5C),
          title:const Text("My Saved Articles",
          style: TextStyle(
            color: Colors.black,
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
                    itemCount: homePage1Controller.allpostdata.length,
                    itemBuilder:(context, index) {
                      return  BlogCard(
                        indexx: index,
                    context: context,
                    blogDetail: homePage1Controller.allpostdata[index]
                  );
                },
                ),
          ],
        ),
      ),
    );
  }
}