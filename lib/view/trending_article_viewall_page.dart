import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvtalk/getxcontroller/home_page1_controller.dart';
import 'package:tvtalk/getxcontroller/signin_controller.dart';
import 'package:tvtalk/services/service.dart';
import 'package:tvtalk/view/profile_page.dart';

class TrendingArticleViewAll extends StatefulWidget {
  const TrendingArticleViewAll(
      {Key? key,})
      : super(key: key);
  @override
  State<TrendingArticleViewAll> createState() => _TrendingArticleViewAllState();
}
var homePage1Controller = Get.find<HomePage1Controller>();
final apiprovider = ApiProvider();
final signincontroller = Get.find<SignInController>();
var isRead;

class _TrendingArticleViewAllState extends State<TrendingArticleViewAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          title: const Text("Trending Article"),
          backgroundColor:Color(0xffFBDC6D),
          elevation: 0.0,
        ),
      ),
      body: ListView.builder(
        itemCount: homePage1Controller.allpostdata.length,
        itemBuilder: (context, index) {
          return  Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                if (signincontroller.isGuest.value == 'guest') {
                        context.pushNamed('SIGNINPAGE');
                      } else {
                        context.pushNamed('ARTICLEDETAILPAGE',
                            extra: homePage1Controller.allpostdata[index],
                            queryParams: {"index": index.toString()});
                      }
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 20 / 100,
                width: MediaQuery.of(context).size.width * 25 / 100,
                decoration:  BoxDecoration(
              image: DecorationImage(
                  image:homePage1Controller.copydata[index].featuredImageSrc != null?
 NetworkImage(homePage1Controller.copydata[index].featuredImageSrc, scale: 0.5):
 const NetworkImage('https://newhorizon-department-of-computer-science-engineering.s3.ap-south-1.amazonaws.com/nhengineering/department-of-computer-science-engineering/wp-content/uploads/2020/01/13103907/default_image_01.png'),
                  fit: BoxFit.cover,), ),
              ),
            ),
            SizedBox(
              // padding: const EdgeInsets.all(16.0),
              //  width: c_width,
              height: MediaQuery.of(context).size.height * 20 / 100,
              width: MediaQuery.of(context).size.width - 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                
                    // children: const [
                      // Text(
                      //   "The Boys",
                      //   style: TextStyle(
                      //     color: Color(0xfff00A17B),
                      //     fontSize: 14,
                      //     fontWeight: FontWeight.w500
                      //   ),
                      // ),
                      // SizedBox(width: 100,),
                    // ],
                  // ),
                  InkWell(
                    onTap: () async {
                      if (signincontroller.isGuest.value == 'guest') {
                        context.pushNamed('SIGNINPAGE');
                      } else {
                        context.pushNamed('ARTICLEDETAILPAGE',
                            extra: homePage1Controller.allpostdata[index],
                            queryParams: {"index": index.toString()});
                      }
                      // final SharedPreferences sharedPreferences =
                      //     await SharedPreferences.getInstance();
                      // sharedPreferences.setInt('Readed', widget.blogDetail.id);
                      // var allldata = sharedPreferences.getInt('Readed');
                      // isRead = await apiprovider.postApi(
                      //     'post/mark-read', {"postId": widget.blogDetail.id});
                    },
                    child: Html(
                    data:  "<h4>${homePage1Controller.allpostdata[index].title.rendered}</h4>",
                  
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () async {
                          // print(widget.blogDetail.link);
                          // await Share.share(widget.blogDetail.link);
                        },
                        child: InkWell(
                          onTap: () async{
                            print(homePage1Controller.allpostdata[index].link);
                          await Share.share(homePage1Controller.allpostdata[index].link);
                          },
                          child: Row(
                            children: const[
                              Text("Share"),
                              SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: Image(
                                    image: AssetImage(
                                      "assets/icons/icon_share.png",
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children:const [
                          Text("2.5k"),
                          SizedBox(
                            width: 5,
                          ),
                          SizedBox(
                              height: 22,
                              width: 22,
                              child: Image(
                                image: AssetImage(
                                  "assets/icons/heart.png",
                                ),
                              ))
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
        },),
      
    );
  }
}
